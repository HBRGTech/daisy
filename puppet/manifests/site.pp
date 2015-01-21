node 'daisy.pattern.lab' {

	# git
	include git

	package { 'dos2unix':
		ensure => 'present'
	}

	file { '/var/www/daisy.pattern.lab':
	   ensure => 'link',
	   target => '/vagrant_data/www',
	   force => true
	}

	# Configure Apache
	class { 'apache':
		default_vhost => false
    }
	include apache::mod::rewrite

	# set up name based virtual hosting
	apache::namevirtualhost { '*:80': }

	# Set up the Virtual Host using the qualified domain name
	apache::vhost { 'daisy.pattern.lab':
		servername => 'daisy.pattern.lab',
		port => '80',
		docroot => '/var/www/daisy.pattern.lab/public',
		options => ['Indexes','FollowSymLinks','MultiViews'],
		proxy_pass => $proxy_pass
	}

	class { 'php': }
	php::module { "json": }

	# set up node and grunt
	package { 'nodejs':
		ensure => 'present'
	}

	package { 'npm':
		ensure => 'present'
	}

	file { '/usr/bin/node':
	   ensure => 'link',
	   target => '/usr/bin/nodejs',
	   require => Package['nodejs']
	}
	
	exec { 'install bower':
		command => '/usr/bin/npm install -g bower',
		user => 'root',
		timeout => 0,		
		require => Package['npm']
	}
	
	exec { 'install grunt-cli':
		command => '/usr/bin/npm install -g grunt-cli',
		user => 'root',
		timeout => 0,
		require => Package['npm']
	}
	->
	# prepare grunt
	exec { 'npm install':
		command => '/usr/bin/npm install --no-bin-links',
		cwd => '/vagrant_data',
		user => 'vagrant',
		timeout => 0,
		require => Package['npm']
	}
	->
	# prepare pattern lab
	exec { 'prepare-pattern-lab':
		command => '/usr/local/bin/grunt shell:patternlab',
		cwd => '/vagrant_data',
		user => 'vagrant',
		timeout => 0
	}
	->
	# prepare grunt watcher
	exec { 'prepare-grunt-watcher':
		command => '/bin/chmod a+x /vagrant_data/bin/watch.sh',
		user => 'vagrant',
		timeout => 0
	}
	->
	# start grunt
	exec { 'start-grunt':
		command => '/vagrant_data/bin/watch.sh',
		user => 'vagrant',
		timeout => 0		
	}
}

node 'daisy.pattern.lab' {

	# git
	include git

	package { 'dos2unix':
		ensure => 'present'
	}

	file { '/var/www/daisy.pattern.lab':
	   ensure => 'link',
	   target => '/vagrant_data/www',
	   force => true,
	}

	# Configure Apache
	class { 'apache':
		default_vhost => false,
    }
	include apache::mod::rewrite

	# set up name based virtual hosting
	apache::namevirtualhost { '*:80': }

	# Set up the Virtual Host using the qualified domain name
	apache::vhost { 'daisy.pattern.lab':
		servername => 'daisy.pattern.lab',
		port => '80',
		docroot => '/var/www/daisy.pattern.lab',
		options => ['Indexes','FollowSymLinks','MultiViews'],
		proxy_pass => $proxy_pass,
		aliases => [
		  { alias      => '/resources',
		    path       => '/var/www/daisy.pattern.lab/source',
		  },
		  { alias      => '/pattern-lab',
		    path       => '/var/www/daisy.pattern.lab/public',
		  }
		],
	}

	class { 'php': }
	php::module { "json": }

	# install ruby
	class { 'ruby':
		gems_version  => 'latest',
		rubygems_update => false,
		before => Exec['bundle-install']
	}

	# Install bundler to handle Ruby dependencies
	package { 'bundler':
		ensure => 'present'
	}

	# prepare ruby
	exec { 'bundle-install':
		command => 'bundle install',
		cwd => '/vagrant_data',
		user => 'root',
		path => '/usr/bin',
		timeout => 0,
		before => Exec['start-grunt'],
		require => Package['bundler']
	}

	# set up node and grunt
	package { 'nodejs':
		ensure => 'present'
	}

	package { 'npm':
		ensure => 'present'
	}

	exec { 'install grunt-cli':
		command => '/usr/bin/npm install -g grunt-cli',
		user => 'root',
		timeout => 0,
		require => Package['npm'],
		before => Exec['npm install']
	}

	# prepare grunt
	exec { 'npm install':
		command => '/usr/bin/npm install --no-bin-links',
		cwd => '/vagrant_data',
		user => 'vagrant',
		timeout => 0,
		require => Package['npm']
	}

	file { '/usr/bin/node':
	   ensure => 'link',
	   target => '/usr/bin/nodejs',
	   require => Package['nodejs']
	}

	# prepare grunt watcher
	exec { 'prepare grunt watcher':
		command => '/bin/chmod a+x /vagrant_data/bin/watch.sh',
		user => 'vagrant',
		timeout => 0,
		before => Exec['start-grunt']
	}

	# start grunt
	exec { 'start-grunt':
		command => '/vagrant_data/bin/watch.sh',
		user => 'vagrant',
		timeout => 0,
		require => File['/usr/bin/node']
	}

}

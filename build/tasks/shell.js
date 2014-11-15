module.exports = function(grunt) {
	grunt.loadNpmTasks("grunt-shell");

	grunt.config("shell", {
		patternlab: {
			command: "touch /vagrant_data/www/public/styleguide/html/styleguide.html && php /vagrant_data/www/core/builder.php -g"
		},
		patternonly: {
			command: "php /vagrant_data/www/core/builder.php -gp"
		}
	});
};

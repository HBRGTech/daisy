module.exports = function(grunt) {
	grunt.loadNpmTasks("grunt-shell");

	grunt.config("shell", {
		patternlab: {
			command: "php /vagrant_data/www/core/console --generate"
		},
		patternonly: {
			command: "php /vagrant_data/www/core/console -gp"
		}
	});
};

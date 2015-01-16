/**
 * Daisy Gruntfile
 * Outlines the grunt tasks for development
 */

module.exports = function(grunt) {
	// project configuration
	grunt.initConfig({
		pkg: grunt.file.readJSON("package.json")
	});

	// load tasks.
	grunt.loadTasks("build/tasks");

	/* define the tasks to run when run with 'grunt' */
	grunt.registerTask("default", [
		"sass",
		"copy",
		"shell:patternlab"
	]);
};
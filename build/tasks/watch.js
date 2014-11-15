module.exports = function(grunt) {
	grunt.loadNpmTasks("grunt-contrib-watch");

	grunt.config("watch", {
		scripts: {
			files: ["www/source/js/**/*.js", "www/source/js/*.js"],
			tasks: ["jshint"]
		},
		css: {
			files: ["www/source/scss/**/*.scss", "www/source/scss/*.scss"],
			tasks: ["compass", "copy:css", "shell:patternlab"],
			options: {
				spawn: false,
				livereload: true
			}
		},
		patternlab: {
			files: [
				"www/source/_patterns/**/*.json",
				"www/source/_data/*.json",
			],
			tasks: ["shell:patternlab"],
			options: {
				spawn: false,
				livereload: true
			}
		},
		mustache: {
			files: [
				"www/source/_patterns/**/*.mustache"
			],
			tasks: ["shell:patternonly"],
			options: {
				spawn: false,
				livereload: true
			}
		}
	});
};

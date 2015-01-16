module.exports = function(grunt) {
	grunt.loadNpmTasks("grunt-contrib-watch");

	grunt.config("watch", {
		css: {
			files: ["www/source/scss/**/*.scss", "www/source/scss/*.scss"],
			tasks: ["sass", "copy:css", "shell:patternlab"],
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

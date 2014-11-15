module.exports = function(grunt) {
	grunt.loadNpmTasks("grunt-contrib-copy");

	grunt.config("copy", {
		css: {
			expand: true,
			cwd: "../../tmp/css/",
			src: "*",
			dest: "www/source/css/",
			filter: 'isFile'
		}
	});
};

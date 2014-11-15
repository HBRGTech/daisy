module.exports = function(grunt) {
	grunt.loadNpmTasks("grunt-contrib-compass");

	grunt.config("compass", {
		dev: {
			options: {
				httpPath: "/resources",
				cacheDir: "../../tmp/.sass-cache",
				cssDir: "../../tmp/css",
				sassDir: "www/source/scss",
				imagesDir: "css/images",
				javascriptsDir: "js",
				fontsDir: "fonts",
				fontsPath: "/resources/fonts",
				relativeAssets: false,
				outputStyle: "expanded",
				importPath: "bower_components/foundation/scss",
				force: true
			}
		}
	});
};

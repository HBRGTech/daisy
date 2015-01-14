module.exports = function(grunt) {
  grunt.loadNpmTasks("grunt-sass");

  grunt.config("sass", {
    options: {
      includePaths: ["bower_components/foundation/scss"]
    },
    dist: {
      files: [{
        expand: true,
        cwd: 'www/source/scss',
        src: ['*.{scss,sass}'],
        dest: '../../tmp/css/',
        ext: '.css'
      }]
    }
  });
};

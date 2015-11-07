module.exports = function(grunt) {
  // Do grunt-related things in here
  grunt.initConfig({
  	pkg: grunt.file.readJSON('package.json'),
		sass: {
				dist: {
					files: {
						'public/css/style.css' : 'public/css/style.scss'
					}
				}
		},
		watch: {
			css: {
				files: '**/*.scss',
				tasks: ['sass'],
				 options: {
      				livereload: true,
      			}
			}
		},
		nodemon: {
	      dev: {
	        script: 'server.js'
	      }
	    }

	});
  grunt.loadNpmTasks('grunt-nodemon'); 
  grunt.loadNpmTasks('grunt-contrib-sass');
  grunt.loadNpmTasks('grunt-contrib-watch');

  // register the nodemon task when we run grunt
  grunt.registerTask('default', ['nodemon', 'watch']); 
};
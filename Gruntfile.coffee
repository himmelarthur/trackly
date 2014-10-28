module.exports = (grunt) ->

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    compass:
      dist:
        options:
          sassDir: 'assets/sass/pages'
          cssDir: 'public/stylesheets'

    watch:
      css:
        files: ['assets/sass/**/*']
        tasks: ['compass']
      js:
        files: ['assets/js/**/*']
        tasks: ['browserify']
      options:
        livereload: true

    browserify:
      dist:
        bundleOptions:
          debug: true
        files: 'public/javascripts/main.js': ['assets/js/apps/trackly.coffee']

  grunt.loadNpmTasks('grunt-contrib-compass')
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-browserify')

  grunt.registerTask('default', ['browserify', 'compass'])

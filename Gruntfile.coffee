module.exports = (grunt) ->

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    compass:
      dist:
        options:
          sassDir: 'assets/sass'
          cssDir: 'public/stylesheets'

    watch:
      css:
        files: ['assets/sass/**/*']
        tasks: ['compass']

  grunt.loadNpmTasks('grunt-contrib-compass')
  grunt.loadNpmTasks('grunt-contrib-watch')

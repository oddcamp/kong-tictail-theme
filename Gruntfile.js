module.exports = function(grunt) {

grunt.initConfig({
  exec: {
    build: {
      //cmd: 'bower install',
      cmd: 'bundle exec compass compile'
    },
    serve: {
      cmd: 'bundle exec compass watch'
    },
    deploy: {
      cmd: 'fab deploy'
    }
  }
});

grunt.loadNpmTasks('grunt-exec');

grunt.registerTask('default', [ 'exec:build' ]);
grunt.registerTask('serve', [ 'exec:serve' ]);
grunt.registerTask('deploy', [ 'exec:build', 'exec:deploy' ]);

};

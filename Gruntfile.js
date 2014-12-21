module.exports = function(grunt) {

grunt.initConfig({
  exec: {
    build: {
      cmd: 'bower install',
      cmd: 'bundle exec compass compile'
    },
    assets: {
      cmd: 'bundle exec compass watch'
    },
    assets_deploy: {
      cmd: 'fab prod deploy'
    },
    serve: {
      cmd: 'bundle exec rackup config.ru'
    }
  }
});

grunt.loadNpmTasks('grunt-exec');

grunt.registerTask('default', [ 'exec:server' ]);
grunt.registerTask('serve', [ 'exec:serve' ]);
grunt.registerTask('assets', [ 'exec:assets' ]);
grunt.registerTask('deploy', [ 'exec:build', 'exec:assets_deploy' ]);

};

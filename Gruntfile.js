module.exports = function(grunt) {

grunt.initConfig({
  pkg: grunt.file.readJSON('package.json'),

  concat: {
    dist: {
      src: [
        'static/assets/javascripts/*.js'
      ],
      dest: 'static/assets/dist/application.js',
    }
  },

  uglify: {
    build: {
      src: 'static/assets/dist/application.js',
      dest: 'static/assets/dist/application.min.js'
    }
  },

  compass: {
    dist: {
      options: {
        config: 'config.rb',
        bundleExec: true,
        watch: true
      }
    }
  },

  watch: {
    scripts: {
      files: ['static/assets/javascripts/*.js'],
      tasks: ['concat', 'uglify', 'compass'],
      options: {
        spawn: false,
      },
    }
  },

  concurrent: {
    target1: ['watch', 'exec:serve']
  },

  exec: {
    build: {
      cmd: 'bower install',
      cmd: 'bundle exec compass compile'
    },
    deploy: {
      cmd: 'fab prod deploy'
    },
    serve: {
      cmd: 'bundle exec rackup config.ru'
    }
  }
});

grunt.loadNpmTasks('grunt-exec');
grunt.loadNpmTasks('grunt-concurrent');
grunt.loadNpmTasks('grunt-contrib-concat');
grunt.loadNpmTasks('grunt-contrib-uglify');
grunt.loadNpmTasks('grunt-contrib-compass');
grunt.loadNpmTasks('grunt-contrib-watch');

grunt.registerTask('default', [ 'concurrent:target1' ]);
grunt.registerTask('deploy', [ 'exec:build', 'concat', 'uglify', 'exec:deploy' ]);

};

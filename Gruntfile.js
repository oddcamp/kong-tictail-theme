module.exports = function(grunt) {

grunt.initConfig({
  pkg: grunt.file.readJSON('package.json'),

  concat: {
    dist: {
      src: [
        'static/vendor/bower_components/modernizr/modernizr.js',
        'static/vendor/bower_components/jquery/dist/jquery.js',
        'static/vendor/bower_components/velocity/velocity.min.js',
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
    serve: ['watch', 'exec:serve']
  },

  exec: {
    build: {
      cmd: 'bower install',
      cmd: 'bundle exec compass compile'
    },
    deploy: {
      cmd: "rsync -avz --delete --exclude 'stylesheets' --exclude 'javascripts' --exclude '.git*' --exclude '.DS_Store' --exclude '.sass-cache*' static/assets/ root@178.62.13.136:/var/www/cdn.konginitiative.com/static/assets/"
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

grunt.registerTask('default', [ 'concurrent:serve' ]);
grunt.registerTask('deploy', [ 'exec:build', 'concat', 'uglify', 'exec:deploy' ]);

};

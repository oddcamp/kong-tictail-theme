from __future__ import with_statement

import os.path

from fabric.api import *
from fabric.contrib.project import *


"""
Environments
"""

def prod():
  env.hosts = ['178.62.13.136']
  env.user = 'root'
  env.path = '/var/www/cdn.konginitiative.com/static'

"Default to 'dev' environment"
prod()


"""
Tasks - Deployment
"""

def deploy():
  require('path', provided_by=[prod])

  rsync_project(
    env.path,
    'static/assets',
    ['.git', '.git*', '.DS_Store', '.sass-cache*', 'stylesheets', 'javascripts'],
    True
  )


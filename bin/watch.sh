#!/bin/bash

cd /vagrant_data
# Empty log file for clean start
cat /dev/null > grunt.log
# Run grunt now. This will generate css and pattern lab
grunt 2>&1 >> grunt.log &
# Start the Grunt Watcher in background, write log
grunt watch --force 2>&1 >> grunt.log &

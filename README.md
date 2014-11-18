daisy
=============

This is a vagrant and grunt powered [Pattern Lab](https://github.com/pattern-lab/patternlab-php), an [Atomic Web Design](http://pattern-lab.info/about.html) Design Pattern library/styleguide, derivative work from hbr.org's 2014 redesign. We use [SCSS version of Foundation](https://github.com/zurb/foundation) which is installed via [bower](http://bower.io/).

Read about it here: http://hbrgtech.github.io/pattern-lab-team-workflow/

Published results can be viewed at <a href="http://daisy.pattern.lab/">http://daisy.pattern.lab/</a> (or your local domain of choice) after vagrant is up.

Edit your scss  in the `www/source/scss` folder and your html/mustache mark-up in the `www/source/_patterns` folder. Pattern Lab will automatically be generated to <a href="http://local.pattern.hbr.org/pattern-lab">http://daisy.pattern.lab/pattern-lab</a> if grunt watch is running properly (if it isn't, use vagrant ssh, cd /vagrant_data, and run grunt or grunt watch manually).

Pattern-Lab documentation:

* [Pattern-Lab documentation](http://pattern-lab.info/docs/index.html), also see [Pattern lab README here](https://github.com/pattern-lab/patternlab-php)

* [Foundation documentation](http://foundation.zurb.com/docs/), also see [Foundation README here](https://github.com/zurb/foundation)

Versions included (Updated as of April 27, 2014):
* Foundation v5.2.2 (see `bower.json`)
* Pattern-lab  v0.7.12

# Daisy

## Overview

Included within this project is a [Vagrant](http://www.vagrantup.com/) development environment.  The goal is provide you with an environment that can be cloned to allow multiple front-end developers to quickly collaborate.

## What You Get

* Ubuntu 14.04
* Apache
* PHP CLI
* Ruby 
* Node.js/npm 
* Grunt
* Pattern Lab
* Zurb Foundation
See `package.json` and `bower.json` for version information.

## Requirements

* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [Vagrant](http://www.vagrantup.com/downloads.html)
* [Git](http://git-scm.com/downloads)

## Getting Started

Download [Vagrant](http://www.vagrantup.com/downloads.html) and [VirtualBox](https://www.virtualbox.org/wiki/Downloads). After cloning [this repository](https://github.com/HBRGTech/daisy) to your computer, you'll want to start up the vagrant box by following the instructions below. The first time you run the installer will be the slowest, as it will download the Virtual Box image and provision the Virtual Machine. Each subsequent run will ensure that the Virtual Machine has the lastest tools and code available.

### Unix/Mac

If you are on a Unix based machine or an OSX based Mac, the setup is pretty easy.

1.  Clone the [daisy Github repo](https://github.com/HBRGTech/daisy)
2.  Also clone all submodules by running `git submodule update —init`
3.  Open a terminal and run the init script: `./bin/daisy-init.sh`
4.  If you get 'permission denied' run 'chmod 755 ./bin/daisy-init.sh'
5.  Go to http://daisy.pattern.lab in a web browser on the computer running vagrant.

### Windows

Daisy is only supported on Windows 7 and above.  If you are using Windows XP, please ensure that you have the [Windows Power Shell](http://support.microsoft.com/kb/968929/en-us) installed.

1.  Clone the [daisy Github repo](https://github.com/HBRGTech/daisy)
2.  Also clone all submodules by running `git submodule update —init`
3.  Run the installer batch script: `./bin/daisy-init.bat`
4.  Go to http://daisy.pattern.lab/ in a web browser on the computer running vagrant (may launch automatically).

## Vagrant Primer

The [Vagrant CLI documentation](http://docs.vagrantup.com/v2/cli/index.html) will be useful for developers that haven't used Vagrant before. Since Daisy is built on top of Vagrant, the Vagrant CLI commands will also work.

Some useful commands:

* `vagrant up` - Start and provisions the VM
* `vagrant ssh` - Logs into the VM with ssh
* `vagrant reload` - Restarts and provisions the VM
* `vagrant provision` - Provisions the VM. 
  You can also do `vagrant up --provsison` or `vagrant reload --provision`
* `vagrant suspend` and `vagrat resume` - If you don't want fully shut it down
* `vagrant halt` - Stops the VM
* `vagrant destroy` - Deletes the VM

## Working with the respository and the VM

Once the VM is up and running, any changes made to the **/source/www/resources/** will be automatically compilied. To see the output of these changes, check `grunt.log`.

If for some reason, you suspect grunt is not running (i.e. grunt.log does not update, css does not compile, or pattern lab not generated) you can go into the VM by `vagrant ssh` then `cd /vagrant_data`. There, you can see if grunt is on, `ps aux | grep grunt`. If you see a process, you can stop it by `kill [process id]`. If you do not see grunt in process, you can either run `bin/watch.sh` or `grunt watch`. 

For more information on grunt, [read this excellent tutorial by Chris Coyer titled "Grunt for People Who Think Things Like Grunt are Weird and Hard"](http://24ways.org/2013/grunt-is-not-weird-and-hard/)

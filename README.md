daisy
=============

## Introduction

Do you work on a front-end web development team?  Does your team run into challenges producing the "gold master" CSS files for your projects?  We've all seen it: one developer's changes clobbering another's; mac and windows platforms producing different output; lack of consistency/style/rigor between contributions from different team members; reconciling the desire of tech-averse designers to try hundreds of different colors with an incompatible or inflexible QA/release process... the list goes on.

Even if members of a team can come to a consensus about what tools, frameworks, and development methodologies to use together in building a project, the inherent workflow issues resulting from their choices can too easily impede development and become a costly time-sink.

*daisy* was distilled from our team's attempt to bring sanity to the workplace, and combines a version-controlled workflow with the principles of atomic web design to develop and manage a CSS layout. At its core is the very solid and responsive [SCSS version of Zurb's Foundation](https://github.com/zurb/foundation), brought to life as a continuously-updated style guide through [Pattern Lab](https://github.com/pattern-lab/patternlab-php).

As with any powerful tools, Pattern Lab and SCSS-like tools come with the overhead of maintenance - especially when it comes to their supporting components (PHP, ruby, git, bower, grunt, compass, and apache, just to name a few).  Complicate that with the different platforms, environments, editing tools, and preferred configurations that each developer on a team brings to the table, and it could be a nightmare to implement them in the first place.

That's why one of daisy's main features is that it's packaged as a vagrant box.  Start a project with daisy, and your entire team can keep its preferred tools while working with a standardized set of essentials to produce consistent, version-controlled output in a highly-adaptable workflow.  Even your designers will want to participate - and can easily do so, just by running daisy on their local environments with whatever access you give them to the git repo.

## Using daisy

You can read more about daisy and the philosophy behind it, as well as the general use case, [here](http://hbrgtech.github.io/pattern-lab-team-workflow/)
and on [Daigo's blog post](http://www.daigo.org/2014/11/introducing-daisy-a-sasspattern-lab-workflow-solution-using-vagrant/)

Once you've got daisy up and running (see documentation below), you can view your published results at <a href="http://daisy.pattern.lab/">http://daisy.pattern.lab/</a> (we're working on enabling your local domain of choice).

Edit your scss in the `www/source/scss` folder, and your html/mustache mark-up in the `www/source/_patterns` folder. Pattern Lab will automatically be regenerated and viewable at <a href="http://local.pattern.hbr.org/pattern-lab">http://daisy.pattern.lab/pattern-lab</a> if grunt watch is running properly (if it isn't, use vagrant ssh, cd /vagrant_data, and run grunt or grunt watch manually).

Useful links:

* [Pattern-Lab documentation](http://pattern-lab.info/docs/index.html), also see [Pattern lab README here](https://github.com/pattern-lab/patternlab-php)

* [Foundation documentation](http://foundation.zurb.com/docs/), also see [Foundation README here](https://github.com/zurb/foundation)

Versions included (Updated as of November, 2014):
* Foundation v5.4.7 (see `bower.json`)
* Pattern-lab  v0.7.12

# Documentation

## Overview

Included within this project is a [Vagrant](http://www.vagrantup.com/) development environment.  The goal is to provide you with an environment that can be easily cloned and version-controlled to allow multiple front-end developers to quickly collaborate.

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

Download [Vagrant](http://www.vagrantup.com/downloads.html) and [VirtualBox](https://www.virtualbox.org/wiki/Downloads). After cloning [this repository](https://github.com/HBRGTech/daisy) to your computer, you'll want to start up the vagrant box by following the instructions below. The first time you run the installer will be the slowest, as it will download the Virtual Box image and provision the Virtual Machine. Each subsequent run will ensure that the Virtual Machine has the lastest tools and code available.  To collaborate on a team, simply initialize a new git repo with the clone you've made of daisy, and start branching instantly to create new scss and mustache files.

### Unix/Mac

If you are on a Unix-based machine or an OSX-based Mac, the setup is pretty easy.

1.  Clone the [daisy Github repo](https://github.com/HBRGTech/daisy)
2.  Also clone all submodules by running `git submodule update --init`
3.  Open a terminal and run the init script: `./bin/daisy-init.sh`
4.  If you get 'permission denied' run 'chmod 755 ./bin/daisy-init.sh'
5.  Go to http://daisy.pattern.lab in a web browser on the computer running vagrant.

### Windows

daisy is only supported on Windows 7 and above.  If you are using Windows XP, please ensure that you have the [Windows Power Shell](http://support.microsoft.com/kb/968929/en-us) installed.

1.  Clone the [daisy Github repo](https://github.com/HBRGTech/daisy)
2.  Also clone all submodules by running `git submodule update --init`
3.  Run the installer batch script: `./bin/daisy-init.bat`
4.  Go to http://daisy.pattern.lab/ in a web browser on the computer running vagrant (may launch automatically).

## Vagrant Primer

The [Vagrant CLI documentation](http://docs.vagrantup.com/v2/cli/index.html) will be useful for developers that haven't used Vagrant before. Since daisy is built on top of Vagrant, the Vagrant CLI commands will also work.

Some useful commands:

* `vagrant up` - Start and provisions the VM
* `vagrant ssh` - Logs into the VM with ssh
* `vagrant reload` - Restarts and provisions the VM
* `vagrant provision` - Provisions the VM. 
  You can also do `vagrant up --provsison` or `vagrant reload --provision`
* `vagrant suspend` and `vagrat resume` - If you don't want fully shut it down
* `vagrant halt` - Stops the VM
* `vagrant destroy` - Deletes the VM

## Working with the repository and the VM

Once the VM is up and running, any changes made to the **/source/www/resources/** will be automatically compiled. To see the output of these changes, check `grunt.log`.

If for some reason, you suspect grunt is not running (i.e. grunt.log does not update, css does not compile, or pattern lab not generated) you can go into the VM by `vagrant ssh` then `cd /vagrant_data`. There, you can see if grunt is on, `ps aux | grep grunt`. If you see a process, you can stop it by `kill [process id]`. If you do not see grunt in process, you can either run `bin/watch.sh` or `grunt watch`. 

For more information on grunt, [read this excellent tutorial by Chris Coyer titled "Grunt for People Who Think Things Like Grunt are Weird and Hard"](http://24ways.org/2013/grunt-is-not-weird-and-hard/)

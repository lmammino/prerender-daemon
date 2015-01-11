prerender-daemon
================

This repository will help you to install/uninstall [prerender](https://github.com/prerender/prerender) as a system services on a linux machine using [System V init scripts](http://refspecs.linuxfoundation.org/LSB_3.1.0/LSB-Core-generic/LSB-Core-generic/iniscrptact.html).

By using this installer you will be able to start/stop a prerender instance as service (daemon):

```bash
sudo service prerender start|stop|restart
```

![Install script running example image](http://oi61.tinypic.com/os4v8k.jpg)

## Install

The installer assumes you've already installed [node.js](http://nodejs.org/), [npm](https://www.npmjs.org/)

Just clone the repository with 

```bash
git clone https://github.com/lmammino/prerender-daemon.git
```

Then run 

```bash
sudo prerender-daemon/install.sh
```

and it will do all the following **hard work** for you:

 - Install prerender as global package
 - Creates a dedicate `prerender` user that will be used to run the daemon
 - Adds an init script to start the daemon
 - Starts the daemon


The installation command support few parameters:

 - `-h` or `--help`: Display the help
 - `-v` or `--verbose`: more verbose output
 - `-u` or `--uninstall`: Act as an unistaller removing prerender-daemon


## Uninstall

Just run

```bash
sudo prerender-daemon/install.sh --uninstall
```

To clean up everything that has been installed previously


## License

This code is distributed under the MIT license. Please refer to the [LICENSE](/LICENSE) file to read the full version.

Contributions are always (and really) appreciated :wink:
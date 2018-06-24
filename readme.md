# Sysenv
It's like `virtualenv` for system packages.

[![asciicast](https://asciinema.org/a/GePBwun3Fz8sULpBhoidGP3hO.png)](https://asciinema.org/a/GePBwun3Fz8sULpBhoidGP3hO)

It creates a `chroot` with bind mounts for `/sys`, `/dev`, `/proc`, and `/home` combined with overlayfs mounts for `/usr`, `/bin`, etc. This means your project files in `/home/` are written normally, but system software is installed in the overlay.

## Installation

Copy the script to your project folder.

## Usage

    $ sudo bash activate.sh
    (env)$ sudo apt-get install everything
    (env)$ sudo make install
    (env)$ echo "Hello world" > hello.txt
    (env)$ ^D
    $ everything
    Command not found
    $ cat hello.txt
    Hello world

fortunes
========

This is a collection of fortunes I've put together myself. The `homestuck`
directory contains quotes from the _Homestuck_ webcomic by Andrew Hussie on
[MS Paint Adventures](http://mspaintadventures.com/). Each file contains quotes
from a single character, and should be a complete record of everything they have
said, not including Flash animations.

If you are not familiar with the
[command line](https://en.wikipedia.org/wiki/Command-line_interface), here is a
short introduction; otherwise feel free to skip to the **Install** section. A
terminal emulator is a program used to send commands directly to a shell,
without any GUI. Commands are run simply by typing them. Within your desktop
environment's applications menu, the terminal emulator may be listed as a system
tool or accessory with a name like "Terminal", "Command Line", "Command Prompt",
or anything else containing the fragment "term".

The purpose of fortunes is to be randomly picked and displayed on the command
line for humorous effect. I published this package in the hope that it will
motivate some users to start or continue learning about the command line, which
is a fast, effective way to use your computer. Of course, if you are reading
this, you likely already know how to use Git/GitHub at least, which puts you
ahead of most users.

The instructions listed below contain text `like this`, which is intended to be
typed verbatim into the terminal. If something is `<bracketed>` it is a
placeholder for a real argument, which should not be bracketed.

Install
-------

To install some or all fortunes on your system, follow these instructions.

1. Enter the directory where you downloaded the source. `cd
   <~/Downloads/fortunes>`
2. Edit the `configure` script with a text editor such as `nano`. It contains
   instructions on setting the user variables. `<editor> configure`
3. Execute the configure script. If you get a message such as `bash:
   ./configure: Permission denied`, the file permissions are not set correctly,
   and you must remedy this with `chmod +x configure` before retrying. If you
   get a message such as `Error: m4 not installed`, you are missing a dependency
   and must install that program from another source. `tput` is provided with
   the `ncurses` software. `./configure`
4. If you want to install all fortunes, just run `make` or `make all` and skip
   to step 7.
5. Choose which targets you want and Make will build them. For example, `make
   all-homestuck` is a predefined shortcut to process all fortunes in the
   `homestuck` directory. If you want to build a few at a time, the syntax is
   `make <dir/target.dat>`. For example, `make homestuck/karkatvantas.dat` and
   then `make homestuck/davestrider.dat homestuck/roselalonde.dat` builds those
   three strfiles. Be mindful not to omit the file extension.
6. Optionally, run `make clean` to delete all built files and start over.
7. Finally, install. Only fortune files that have had strfiles built will be
   copied over to the system-wide directories. `make install`

### Packagers ###

Using the steps above as a guide, create a package with the make dependencies
listed in `configure` and the runtime dependency `fortune-mod` or whatever the
core `fortune` package is called in your distro. Since `install` is in the GNU
coreutils, it can reasonably be omitted.

The `make install` target uses the `DESTDIR` variable, as in this example for an
Arch Linux PKGBUILD: `make DESTDIR="$pkgdir/" install`, which changes the
installation "root" to that shell-expanded directory.

Use
---

You can use the installed fortunes with the standard Unix
[`fortune`](https://en.wikipedia.org/wiki/Fortune_%28Unix%29) command. Invoking
it as `fortune -e homestuck` or `fortune -e homestuck/karkatvantas
homestuck/solluxcaptor` is recommended, as the number of fortunes in each
fortune file vary widely. This will give each file an equal probability of being
chosen, and therefore provides more variety. Add this command to the file
`~/.bashrc` to have it executed every time you open a new shell. See `man 6
fortune` for more information.

Contribute
----------

The upstream location of this package is on
[GitHub](https://github.com/HectorAE/fortunes). Pull requests containing
bugfixes, typo fixes, or new content are welcome.

Dotfiles
========

My configuration files for ZSH, vim etc. The files are best suited for Debian and derived Linux distros, but at least the ZSH config is quite adaptive.

Installation
============

To install, run `./install`. It will create symlinks in your home folder, pointing to the files and directories in the 'config' directory.

Any existing files or folders will be moved to a backup directory, stated by the script. The contents of the backup directory are ignored by git.

Update
======

The files will be kept up to date by ZSH, which will check git for updates on startup, if it hasn't done so in a week.

To manually update, run `update_dotfiles` in ZSH. That command will also reload the ZSH config if updates were found. Of course, `git pull` in the repository works equally well, but that doesn't reload any config.

One can also make sure an automatic update check is run on the next opening of ZSH by running `update_dotfiles defer`.

Local Configuration
===================

The zshrc configuration file can have a local configuration in addition to the shared one coming from this repository. This is achieved by creating a `.zshrc.local` file in your home folder.

License & Copyright
===================

All files in this repository are, unless stated otherwise, Copyright Joakim Tufvegren and free to redistribute and/or modify as long as credit is given where credit is due.

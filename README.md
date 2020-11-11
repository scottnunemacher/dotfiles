# My Dotfiles

My collection of dotfiles used for configuration.

I hope this helps someone. Enjoy.

Clone | Copy | Edit your ❤️ out.

MIT License

## .bash_aliases File

The .bash_aliases file is the default way for bash to find a user's custom added aliases and functions. The .bash_aliases file just needs to be copied to a user's home directory where the .bashrc is located. It is heavily commented and should provide good reference. 

NOTE: Some aliases & functions in the .bash_aliases file are macOS or Linux environment specific.

## .bash_fancyprompt File

The .bash_fancyprompt file is a custom-created dotfile containing the shell PS1 prompt environment details and must be referenced in the .bashrc or .bash_aliases file like this:

```
if [ -f ~/.bash_fancyprompt ]
then
  . ~/.bash_fancyprompt
fi
```

NOTE: My .bash_aliases file already has that reference so no changes are necessary if my .bash_aliases is used.

## Cloning Into a Non-Empty Home Directory

Non-destructively clone the repo into a non-empty home directory on an linux style server. 

_*WARNING:*_ Before doing the following, rename any possibly conflicting files in your home directory compared to the files in the repo.

Log into server as user and change to the user's non-empty home directory:

```
cd ~
```

Initialize an empty git repo inside the home directory:

```
git init
```

Add the remote origin to the newly created git initialization:

```
git remote add origin https://github.com/scottnunemacher/dotfiles.git
```

Fetch the newest data from the repo (this doesn't move any new files into home yet, just gets the data about the files to be moved into the home directory):

```
git fetch
```

The next command WILL move/clone data (actually just catches up the home directory with the repos remote origin/main current branch). The repo's .gitignore file will prevent tracking anything in the home directory and will only track repo files. See for yourself the .gitignore file in the repo to understand.

```
git checkout -t origin/main
```

You are now up to date with 'origin/main'.

Want to delete the LICENSE and README.md from your home folder and stop (local only) tracking them cuz... don't care about them? Fine, just run: 

```
git update-index --assume-unchanged LICENSE README.md
```

Then delete the LICENSE and README.md from your home folder. No future (local only) tracking will take place of LICENSE and README.md. Peace.

Change your mind and want to track LICENSE and README.md again? Fine, just run the following which will remove your local ignore-tracking and reset to origin/main:

NOTE: this will catch you up to origin/main too if behind, but throw away any local changes you've made. Careful.

```
git reset --hard origin/main
```

Done.

> Cloning into a non-empty directory...
>
> amiright?!
>
> —Scott

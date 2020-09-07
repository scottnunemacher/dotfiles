# My bash setup with a fancyprompt & ~/bin directory
My personal bash setup using a .bash_aliases file and accompanying ~/bin directory that includes a fun fancyprompt and space for other future useful command line scripts.

I hope this helps someone.

MIT License.

Enjoy.

## NOTE TO MYSELF: Clone Into a Non-Empty Home Directory
Non-destructively clone the repo into a non-empty home directory on an Ubuntu/Debian server with the following commands.

Log into server as user. Change to the user's home directory with:
```
cd ~
```

_*IMPORTANT:*_ Rename a possible pre-existing home `~/bin` directory to `~/binBACKUP` with:
```
mv ~/bin ~/binBACKUP
```

Initialize an empty git repo inside the home directory:
```
git init
```

Add the remote origin to the newly created git initialization:
```
git remote add origin https://github.com/scottnunemacher/bash-setup-with-bin.git
```

Fetch the newest data from the repo (this dosen't move any new files into home yet, just gets the data about the files to be moved into the home directory):
```
git fetch
```

The next command WILL move/clone data (actually just catches up the home directory with the repos remote origin/master current branch). The repo's .gitignore file will prevent tracking anything in the home directory and will only track repo files and anything added inside the new `~/bin` directory. See for yourself the .gitignore file in the repo to understand.
```
git checkout -t origin/master
```

Done.

> Cloning into a non-empty directory...
>
> amiright?!

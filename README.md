# My bash setup with a fancyprompt & ~/bin directory
My personal bash setup using a .bash_aliases file and accompanying ~/bin directory that includes a fun fancyprompt for other useful command line scripts.

I hope this helps someone. Enjoy.

## NOTE TO MYSELF: Clone Into a Non-Empty Home Directory
Clone the repo into a non-empty home directory on an Ubuntu/Debian server with the following commands.

Log into server as user. Change to user home directory with:
```
cd ~
```

Now is the time to rename any `~/bin` directory I might have to `~/binBACKUP`:
```
mv ~/bin ~/binBACKUP
```

Initialize a git repo inside the home directory:
```
git init
```

Add the remote origin to my newly created git initialization:
```
git remote add origin https://github.com/scottnunemacher/bash-setup-with-bin.git
```

Fetch the newest data from the repo:
```
git fetch
```

Checkout the origin/master from the fetch data.
```
git checkout -t origin/master
```

Done.

> Cloning into a non-empty directory...
>
> while talking to myself...
>
> amiright?!

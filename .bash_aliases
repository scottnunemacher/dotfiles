#========================================
# Use mybash for .bash_aliases
#========================================
# Edit .bash_aliases file by running 'mybash'
alias mybash='nano ~/.bash_aliases'

# Source this .bash_aliases file after modifying it by running '.mybash'.
.mybash() {
  . ~/.bash_aliases;
}

# Edit .bash_fancyprompt file by running 'fancyprompt'
alias fancyprompt='nano ~/bin/.bash_fancyprompt'

# Source this .bash_fancyprompt file after modifying it by running '.fancyprompt'.
.fancyprompt() {
  . ~/bin/.bash_fancyprompt;
}

#-------------------------
# GREP - Grep - Make grep more user-friendly by highlighting matches.
alias grep='grep --color=auto'

#-------------------------
# NANO - Nano easier
alias n='nano -r 0 $1'

#-------------------------
# CLEAR - Clear screen easier
alias c='clear && l'

#-------------------------
# RM - Force interactive argument
alias rm='rm -i'
# Delete a folder and everything in it with ONE command (interactive once)
alias rmall='rm -rI -- $1'

#-------------------------
# MV - Force interactive argument
alias mv='mv -i'

#-------------------------
# LS - List easier: color always
alias ls='LANG=C ls --color=always'

#List easier: (h)uman readable, (a)ll files, (l)ist format, directories-first
alias l='ls -hal --group-directories-first'

# List easier: (h)uman readable, (a)ll files, (l)ist format, (t)ime sorted, (r)eversed
alias lr='ls -haltr'

#-------------------------
# NAVIGATION
# CD - cd then list 
newcd() {
  builtin cd "$@" && l;
}
alias cd='newcd'

# Make directory then change into it.
mkcd() {
  mkdir "$1";
  cd "$1";
}

# Go up directories easier
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias up='cd ../'
alias up2='cd ../../'
alias up3='cd ../../../'

# Return to any previous directory easier
back() {
  cd $OLDPWD;
}
alias b='back'

# Shortcut to commonly used directories
alias ~='cd ~' # Change to the user's home direcotry (~)
alias h='cd ~' # Change to the user's home direcotry (~)
alias archive='cd ~/archive/'
alias bin='cd ~/bin/'
alias docs='cd ~/docs/'
alias home='cd /home/' # Change to the literal /home/ directory
alias log='cd /var/log/'
alias www='cd /var/www/'
alias html='cd /var/www/html/'

#-------------------------
# TMUX - Shortcuts
alias tl='tmux ls'
alias ta='tmux a'
alias t='tmux'

#-------------------------
# GIT
# git function with params
g() {
  git "$@";
}
# git status function with params
gits() {
  git status "$@";
}
# git commit function with params
gitc() {
  git commit "$@";
}
# git branch function with params
gitb() {
  git branch "$@";
}

#-------------------------
# SSH
# Edit the ssh config file
alias sshconfig='nano ~/.ssh/config'

#-------------------------
# NETWORK and HOST
# Get current public IP address in plaintext
alias whatismyip="curl http://ipecho.net/plain; echo"

# List open UDP TCP connections:
alias listopen='lsof -i | grep ESTABLISHED'

# Find the network node hostname easier
name() {
  uname -n;
}

#-------------------------
# USERS & PERMISSIONS
# List Users from /etc/passwd with getent
alias listusers='getent passwd'

# List groups with getent
alias listgroup='getent group'

# Check to see what members are part of a group.
# Usage: 'members staff' to see a list of members belonging to a group called staff
members() {
  dscl . -list /Users | while read user;
  do printf "$user ";
  dsmemberutil checkmembership -U "$user" -G "$*";
  done | grep "is a member" | cut -d " " -f 1;
}

#-------------------------
# DISK USAGE
# List size current directory ONLY
list-size() {
  du -sh .
}

# List inode count recursive current directory
list-count() {
  echo "Detailed Inode usage for: $(pwd)";
  for d in `find -maxdepth 1 -type d |cut -d\/ -f2 |grep -xv . |sort`;
    do c=$(find $d |wc -l);
    printf "$c\t\t- $d\n";
    done;
  printf "Total: \t\t$(find $(pwd) | wc -l)\n";
}

#-------------------------
# GPG 
# Verify a gpg signed file with a ASC Signature with a matching name.
gpg-verify() {
  gpg --verify $1{.asc*,};
}

#-------------------------
# MOTD - Message Of The Day
# See motd when needed
alias motd='cat /run/motd.dynamic'

#-------------------------
#

#========================================
# HISTORY
#========================================
# Disable history
unset HISTFILE
HISTFILE=/dev/null

#========================================
# ADD ~/BIN TO PATH
#========================================
# Check for ~/bin/ directory of current user and prepend to $PATH
if [ -d $(eval echo "~$different_user")/bin ]; then
  PATH="$(eval echo \"~$different_user\")/bin:$PATH"
fi

#========================================
# Fancyprompt MUST BE LAST SECTION
#========================================
# Use a cool fancy prompt
if [ -f ~/bin/.bash_fancyprompt ]; then
    . ~/bin/.bash_fancyprompt
fi

# NOTHING BELOW THIS EOF
#EOF

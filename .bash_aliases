#========================================
# MYBASH
#========================================
# Edit .bash_aliases file by running 'mybash'
alias mybash='nano ~/.bash_aliases'

# Source this .bash_aliases file after modifying it by running '.mybash'.
.mybash() {
  . ~/.bash_aliases;
}


#========================================
# FANCYPROMPT
#========================================
# Edit .bash_fancyprompt file by running 'fancyprompt'
alias fancyprompt='nano ~/bin/.bash_fancyprompt'

# Source this .bash_fancyprompt file after modifying it by running '.fancyprompt'.
.fancyprompt() {
  . ~/bin/.bash_fancyprompt;
}


#========================================
# CORE UTILITIES CHANGES
#========================================

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

# List easier: (h)uman readable, (a)ll files, (l)ist format, (t)ime sorted, (r)eversed (oldest to newest)
alias lrt='ls -haltr'

# List easier: (h)uman readable, (a)ll files, (l)ist format, (S)ize sorted, (r)eversed (smallest to largest)
alias lrs='ls -halSr'


#========================================
# USER NAVIGATION
#========================================

#-------------------------
# NAVIGATION
# CD - cd then list 
newcd() {
  builtin cd "$@" && l;
}
# This shortcuts the 'cd' utility to always 'ls' after a 'cd'
alias cd='newcd'

# Make directory then change into it
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

# Return to last directory location easier
back() {
  cd "$OLDPWD";
}
alias b='back'

#-------------------------
# USER SHORTCUTS
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
alias fail2ban='cd /etc/fail2ban/'


#========================================
# SSH & SESSION
#========================================

#-------------------------
# MOTD - MESSAGE OF THE DAY
# See motd when needed
alias motd='cat /run/motd.dynamic'

#-------------------------
# SSHCONFIG
# Edit the ssh config file
alias sshconfig='nano ~/.ssh/config'

#-------------------------
# TMUX TERMINAL SESSION MULTIPLEXER
# List available Tmux server sessions
tl() {
  tmux ls;
}

# Attach to a specific Tmux session target name/number listed from tmux ls.
# for example, the above tl produces (if you have 3 sessions running): 
#
# 0: 1 windows (created Sun Oct 21 13:37:00 2015) [158x39]
# 1: 1 windows (created Sun Oct 21 13:37:00 2015) [158x39]
# 2: 1 windows (created Sun Oct 21 13:37:00 2015) [158x39]
#
# Attach to that last session with:
# ta 2
ta() {
  tmux a -t "$@";
}

# Tmux start a new (or additional) server session
t() {
  tmux;
}


#========================================
# NETWORK & HOST
#========================================

#-------------------------
# IP
# Get current public IP address in plaintext
alias whatismyip="curl http://ipecho.net/plain; echo"

# List open UDP TCP connections:
alias listopen='lsof -i | grep ESTABLISHED'

#-------------------------
# HOST
# Find the network node hostname easier
name() {
  uname -n;
}


#========================================
# ADMIN & MANAGEMENT
#========================================

#-------------------------
# UBUNTU
# Simple check Ubuntu version
ubuntu-version() {
  lsb_release -d;
}

# Detailed release information
ubuntu-release() {
  cat /etc/os-release;
}

# Update and upgrade easier
update-upgrade(){
  apt update && apt upgrade;
}

#-------------------------
# HOSTNAMECTL
# General hostname information (for future reference)
# hostnamectl

#-------------------------
# USERS & PERMISSIONS
# List Users from /etc/passwd with getent
alias listusers='getent passwd'

# List groups with getent
alias listgroup='getent group'

# !!! MACOS ONLY !!!
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
# List size of current directory ONLY
list-size() {
  du -sh .
}

# List count of files (inodes) in current directory recursively
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
# Verify a gpg signed file with matching ASC Signature file.
# Signature file must have a matching name and be in same directory.
gpg-verify() {
  gpg --verify $1{.asc*,};
}

#-------------------------
# SYSTEMD-ANALYZE
# Analyze system startup time (for future reference)
# systemd-analyze


#========================================
# SECURITY
#========================================

#-------------------------
# FAIL2BAN (if you have it)
# Read Fail2Ban logs easier
# cd to fail2ban directory
alias f2b='cd /etc/fail2ban/'

# starts the server and the jail
f2b-start() {
  fail2ban-client start;
}

# reloads the configuration
f2b-reload() {
  fail2ban-client reload;
}

# stops all jails and terminate the server
f2b-stop() {
  fail2ban-client stop;
}

# gets the current status of the server
f2b-status() {
  fail2ban-client status;
}

# tests if the server is alive
f2b-ping() {
  fail2ban-client ping;
}

# Report from all log files, group by IP address
f2b-group-by-ip() {
  awk '($(NF-1) = /Ban/){print $NF}' /var/log/fail2ban.log* | \
  sort | \
  uniq -c | \
  sort -n;
}

# Group by IP address and hostname
f2b-group-by-ip-and-hostname() {
  awk '($(NF-1) = /Ban/){print $NF,"("$NF")"}' /var/log/fail2ban.log | \
  sort | \
  logresolve | \
  uniq -c | \
  sort -n;
}

# Group on today's activity
f2b-group-by-today() {
  grep "Ban " /var/log/fail2ban.log | \
  grep `date +%Y-%m-%d` | \
  awk '{print $NF}' | \
  sort | \
  awk '{print $1,"("$1")"}' | \
  logresolve | \
  uniq -c | \
  sort -n;
}

# Report problematic subnets
f2b-group-problem-subnets() {
  zgrep -h "Ban " /var/log/fail2ban.log* | \
  awk '{print $NF}' | \
  awk -F\. '{print $1"."$2"."}' | \
  sort | \
  uniq -c  | \
  sort -n | \
  tail;
}

# Focus on problem IP, accepts IP subnet form 255.255.
f2b-problem-ip-in-subnet-form() {
  zgrep -c "$@" /var/log/fail2ban.log*;
}

f2b-summary-of-ban-events-by-day() {
  zgrep -h "Ban " /var/log/fail2ban.log* | awk '{print $5,$1}' | sort | uniq -c;
}

# Check status of fail2ban jails
f2b-status() {
  fail2ban-client status;
}

# Check status of a specific fail2ban jail (ex: sshd)
# usage: f2b-status-jail-details sshd
f2b-status-jail-details() {
  fail2ban-client status "$@";
}

#-------------------------
# LINUX MALWARE DETECT / LMD / MALDET

#-------------------------
# RKHUNTER

#-------------------------
# ClamAV
# -i, --infected
#               Only print infected files.
#
# --bell Sound bell on virus detection.
#
# -r, --recursive
#               Scan directories recursively. All the subdirectories in the given directory will be scanned.
#
# -z, --allmatch
#               After a match, continue scanning within the file for additional matches.
# Run clamscan recursively and only return infected files
clamscan-recursive-infected() {
  clamscan -i -r -z --bell "$@";
}

#-------------------------
# WORDPRESS CLI
# Safely run wp-cli with the correct user to avoid permission denied-problems
# From: https://blog.christosoft.de/2017/06/wp-cli-run-as-correct-user/
wp() {
  sudo -u `stat -c '%U' .` -s -- wp "$@";
}

#-------------------------
# 

#-------------------------
# 

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
# FANCYPROMPT - !!! MUST BE LAST SECTION !!!
#========================================
# Use a cool fancy prompt
if [ -f ~/bin/.bash_fancyprompt ]; then
    . ~/bin/.bash_fancyprompt
fi

# NOTHING BELOW THIS EOF
#EOF

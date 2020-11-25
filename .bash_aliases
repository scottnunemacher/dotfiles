#========================================
#  HOW TO USE
#========================================

#-------------------------
# Clone into a non-empty home directory with:
#   cd ~
#   git init
#   git remote add origin https://github.com/scottnunemacher/dotfiles.git
#   git fetch
#   git checkout -t origin/main


#========================================
# MYBASH
#========================================
# Edit .bash_aliases file by running 'mybash'.
alias mybash='nano ~/.bash_aliases'

# Then source the .bash_aliases file after modification by running '.mybash'.
.mybash() {
  . ~/.bash_aliases;
}


#========================================
# CORE UTILITIES CHANGES
#========================================

#-------------------------
# GREP - Make grep more user-friendly by highlighting matches.
alias grep='grep --color=auto'

#-------------------------
# NANO - Nano easier: w(r)ap at the widest screen column (0).
alias n='nano -r 0 $1'

#-------------------------
# CLEAR - Clear the screen faster.
alias c='clear'
# Clear the screen and list faster.
alias cl='clear && l'

#-------------------------
# RM - Remove files or directories (force Interactivity).
alias rm='rm --interactive=always $@'
# Remove a folder and everything in it with ONE command (interactive once).
alias rmall='rm --interactive=once --dir --recursive $@'

#-------------------------
# MV - Move files or directories (force Interactivity).
alias mv='mv -i'

#-------------------------
# LS - List easier: color always.
alias ls='LANG=C ls --color=always'

#List easier: (h)uman readable, (a)ll files, (l)ong format, directories-first.
alias l='ls -hal --group-directories-first'

# List easier: (h)uman readable, (a)ll files, (l)ong format, (t)ime sorted, (r)eversed (oldest to newest).
alias lrt='ls -haltr'

# List easier: (h)uman readable, (a)ll files, (l)ong format, (S)ize sorted, (r)eversed (smallest to largest)
alias lrs='ls -halSr'


#========================================
# USER NAVIGATION
#========================================

#-------------------------
# NAVIGATION
# CD - Change directory then list contents of new directory.
newcd() {
  builtin cd "$@" && cl;
}
# This shortcuts the 'cd' utility with the above function to always 'ls' after a 'cd'
alias cd='newcd'

# MKDIR - Make directory then change into it
mkcd() {
  mkdir "$1";
  cd "$1";
}

# Go up directories easier.
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias up='cd ../'
alias up2='cd ../../'
alias up3='cd ../../../'

# Return to last directory easier.
back() {
  cd "$OLDPWD";
}
alias b='back'

#-------------------------
# USER SHORTCUTS
# Shortcut to commonly used directories (if exists).
alias ~='cd ~' # Change to the user's home direcotry (~).
alias h='cd ~' # Change to the user's home direcotry (~).
alias archive='cd ~/archive/'
alias bin='cd ~/bin/'
alias docs='cd ~/docs/'
alias home='cd /home/' # !!! Change to the LITERAL /home/ directory.
alias log='cd /var/log/'
alias www='cd /var/www/'
alias html='cd /var/www/html/'
alias fail2ban='cd /etc/fail2ban/'


#========================================
# SSH & SESSION
#========================================

#-------------------------
# SSH CONNECTION DETAILS
# See the connection details for your ssh session.
alias sshconnection='echo $SSH_CONNECTION'

#-------------------------
# MOTD - MESSAGE OF THE DAY
# See motd (varies in OS distributions, adjust accordingly).
alias motd='cat /run/motd.dynamic'

#-------------------------
# SSHCONFIG
# Edit the ssh config file
alias sshconfig='nano ~/.ssh/config'

#-------------------------
# TMUX TERMINAL SESSION MULTIPLEXER
# List available Tmux server sessions easier (if any).
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
# Attach to that last session in the list with:
# ta 2
ta() {
  tmux a -t "$@";
}

# Tmux start a new (or additional) server session.
t() {
  tmux;
}


#========================================
# NETWORK & HOST
#========================================

#-------------------------
# IP
# Get current public IP address in plaintext (curl must be installed).
alias whatismyip="curl http://ipecho.net/plain; echo"

# List open UDP TCP connections:
alias listopen='lsof -i | grep ESTABLISHED'

#-------------------------
# HOST
# Find the network node hostname easier.
name() {
  uname -n;
}


#========================================
# ADMIN & MANAGEMENT
#========================================

#-------------------------
# UBUNTU
# Simple check Ubuntu version.
ubuntu-version() {
  lsb_release -d;
}

# Detailed release information.
ubuntu-release() {
  cat /etc/os-release;
}

# Update and upgrade easier.
update-upgrade(){
  apt update && apt upgrade;
}

#-------------------------
# TODO HOSTNAMECTL
# General hostname information
# hostnamectl

#-------------------------
# USERS & PERMISSIONS
# List Users from /etc/passwd with getent.
alias listusers='getent passwd'

# List Password metadata details for all users.
# Doesn't un-hash passwords, that would be impossible.
alias listpasswords='passwd -S -a'

# List groups with getent.
alias listgroup='getent group'

# !!! MACOS ONLY !!!
# Check to see what members are part of a group.
# Usage: 'members staff' to see a list of members belonging to a group called staff.
macos-members() {
  dscl . -list /Users | while read user;
  do printf "$user ";
  dsmemberutil checkmembership -U "$user" -G "$*";
  done | grep "is a member" | cut -d " " -f 1;
}

#-------------------------
# DISK USAGE
# List size of current directory ONLY.
list-size() {
  du -sh .
}

# List count of files (inodes) in current directory recursively.
list-count() {
  echo "Detailed Inode usage for: $(pwd)";
  for d in `find -maxdepth 1 -type d |cut -d\/ -f2 |grep -xv . |sort`;
    do c=$(find $d |wc -l);
    printf "$c\t\t- $d\n";
    done;
  printf "Total: \t\t$(find $(pwd) | wc -l)\n";
}

#-------------------------
# WHATS EATING DISK SPACE (IN A FILE)
whats-eating-disk-space() {
  date_today=$(date +%Y%m%d.%H%M%S);
  find . -type f  -exec du -h {} + | sort -r -h > /tmp/whats-eating-disk-space-$date_today.txt;
  echo "Done. To view file: cat /tmp/whats-eating-disk-space-$date_today.txt";
}

#-------------------------
# NCDU - NCurses Disk Usage
# ncdu (NCurses Disk Usage) is a curses-based version of the well-known 'du', 
# and provides a fast way to see what directories are using your disk space.
# Install with:
#   apt install ncdu

#-------------------------
# GPG 
# Verify a gpg signed file with matching ASC Signature file.
# Signature file must have a matching name and be in same directory.
gpg-verify() {
  gpg --verify $1{.asc*,};
}

#-------------------------
# TODO SYSTEMD-ANALYZE
# Analyze system startup time
# See what is responsible for startup time
# Use: systemd-analyze blame
# See what is responsible for startup time and grep for an item like snap
# Use: systemd-analyze blame | grep snap


#========================================
# SECURITY
#========================================

#-------------------------
# FAIL2BAN (if installed)
# Read Fail2Ban logs easier.
# cd to fail2ban directory.
alias f2b='cd /etc/fail2ban/'

# tests if the server is alive.
f2b-ping() {
  fail2ban-client ping;
}

# Report from all log files, group by IP address.
f2b-group-by-ip() {
  awk '($(NF-1) = /Ban/){print $NF}' /var/log/fail2ban.log* | \
  sort | \
  uniq -c | \
  sort -n;
}

# Group by IP address and hostname.
f2b-group-by-ip-and-hostname() {
  awk '($(NF-1) = /Ban/){print $NF,"("$NF")"}' /var/log/fail2ban.log | \
  sort | \
  logresolve | \
  uniq -c | \
  sort -n;
}

# Group on today's activity.
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

# Report problematic subnets.
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

# Check status of fail2ban jails.
f2b-status() {
  fail2ban-client status;
}

# Check status of a specific fail2ban jail (ex: sshd).
# usage: f2b-status-jail-details sshd
f2b-status-jail-details() {
  fail2ban-client status "$@";
}

#-------------------------
# TODO LINUX MALWARE DETECT / LMD / MALDET

#-------------------------
# TODO RKHUNTER

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
# Run clamscan recursively and only return infected files.
clamscan-recursive-infected() {
  clamscan -i -r -z --bell "$@";
}

#-------------------------
# WORDPRESS CLI
# Safely run wp-cli with the correct user to avoid permission denied-problems.
# From: https://blog.christosoft.de/2017/06/wp-cli-run-as-correct-user/
wp() {
  sudo -u `stat -c '%U' .` -s -- wp "$@";
}

#-------------------------
# GIT
# Bash version to list git aliases from your .gitconfig file if any.
git-list() {
  git config --get-regexp ^alias\. | sed -e s/^alias\.// -e s/\ /\ =\ / | sort;
}

#-------------------------
# 
# MANUAL BACKUP OF WORDPRESS VIA COMMAND LINE
# - IMPORTANT! Change to the root of wordpress to run these commands:
#   cd /var/www/html
# 
# - Backup WP database with WP-CLI:
#   wp db export
# 
# - Copy the name of the newly created .sql file to use in the next command.
#   (might look like dfg235987234590-2020-01-10-345687fd.sql)
#  
# - Run the next command with your filname name inserted:
#   Using the example then would be:
#   tar -vczf dfg235987234590-2020-01-10-345687fd.gz .
# 
# Safely backup the newly created sql and tar file. Delete the originals.

#-------------------------
# 

#-------------------------
# 


#========================================
# HISTORY
#========================================
# Disable history by uncommenting these two lines:
# unset HISTFILE
# HISTFILE=/dev/null


#========================================
# ADD ~/BIN TO PATH (IF ANY)
#========================================
# Check for ~/bin/ directory of current user and prepend to $PATH.
if [ -d $(eval echo "~$different_user")/bin ]
then
  PATH="$(eval echo \"~$different_user\")/bin:$PATH"
fi


#========================================
# FANCYPROMPT - !!! MUST BE LAST SECTION !!!
#========================================
if [ -f ~/.bash_fancyprompt ]
then
  . ~/.bash_fancyprompt
fi


# NOTHING BELOW THIS #EOF
#EOF

# Fig pre block. Keep at the top of this file.
# [[ -f "$HOME/.fig/shell/bashrc.pre.bash" ]] && . "$HOME/.fig/shell/bashrc.pre.bash"
all_usernames="jjochen jochen Jochen pfeiffer jj"
untrusted_hosts_with_sshkey=""

AddToPath ()
# Add argument to $PATH if:
# - it is not already present
# - it is a directory
# - we have execute permission on it
#
{
  _folder=$1
  echo " $PATH " | sed 's/:/ /g' | grep " $_folder " > /dev/null
  [ $? -ne 0 ] && [ -d $_folder ] && [ -x $_folder ] && PATH=$PATH:$_folder
  export PATH
}

AddPathTo ()
# Add argument to $PATH if:
# - it is not already present
# - it is a directory
# - we have execute permission on it
{
  _folder=$1
  echo " $PATH " | sed 's/:/ /g' | grep " $_folder " > /dev/null
  [ $? -ne 0 ] && [ -d $_folder ] && [ -x $_folder ] && PATH=$_folder:$PATH
  export PATH
}

AddPathTo "/opt/homebrew/sbin"
AddPathTo "/opt/homebrew/bin"
AddPathTo "/usr/texbin"
AddPathTo "/Library/TeX/texbin"
AddToPath "$HOME/bin"
AddToPath "$HOME/fvm/default/bin"
AddToPath "$HOME/.pub-cache/bin"
AddToPath "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
AddToPath "/usr/bin"
AddToPath "/usr/sbin"
AddToPath "/bin"
AddToPath "/sw/bin"
AddToPath "/sw/sbin"
AddToPath "/sbin"

QTDIR=/opt/local/lib/qt3; export QTDIR

case " $all_usernames " in
    *" $USER "*) username=$USER ;;
    *)
        for i in $all_usernames; do
            eval [ -r ~$i/.bashrc ] && { username=$i; break; }
        done
        ;;
esac

# Setting for the new UTF-8 terminal support in Lion
export LC_CTYPE=de_DE.UTF-8
export LC_ALL=de_DE.UTF-8
export LANG=de_DE.UTF-8

#unset PROMPT_COMMAND  

#[ -z "$OLDPWD" ] && cd 

case $(uname -s) in 
    Linux) os=linux ;; 
    Darwin) os=mac ;; 
    *[bB][Ss][Dd]) os=bsd ;; 
    *) os=unix ;; 
esac

eval source "~$username/.bashrc.local" 2>/dev/null

HOSTNAME=$(hostname 2>/dev/null || hostname -f)

export HOST=${HOST:-${HOSTNAME%%.*}}
TTY=$(tty); export TTY=${TTY#/dev/}   

export HST=`hostname -s`

export LC_COLLATE=C

umask 0022

set -o vi

GPG_TTY=‘tty‘
export GPG_TTY 

###################################
# If not running interactively, end:
[ -z "$PS1" ] && return

type setterm >/dev/null 2>&1 && setterm -foreground black -background white -store

type biff >/dev/null 2>&1 && biff y
mesg y

shopt -s checkwinsize

shopt -s histappend
HISTFILESIZE=1024
HISTCONTROL=ignoreboth

shopt -s extglob
shopt -s nullglob
shopt -s dotglob

#export DISPLAY="localhost:0"

export LESS="-i"

export wgip="88.198.40.142"

# Set my inputrc
eval [ -f \~$username/.inputrc ] && eval export INPUTRC=\~$username/.inputrc

eval [ -f \~$username/.vars ] && eval source \~$username/.vars

### ps output ###
case $os in
    linux) alias psa='ps axo "user,pid,ppid,%cpu,%mem,tty,stime,state,command"' ;;
    mac) alias psa='ps axo "user,pid,ppid,%cpu,%mem,tty,stime,state,command"' ;;
    bsd) alias psa='ps axo "user,pid,ppid,%cpu,%mem,tty,start,state,command"' ;;
    unix) alias psa='ps -A -o "user,pid,ppid,tty,stime,s,comm"' ;;
esac



[ "$os" = "linux" ] && alias su="su -c 'bash -rcfile ~$username/.bashrc'"

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

### vi ###
type vim >/dev/null 2>&1 && {
    if eval [ -r "~$username/.vimrc" ]; then
        vicmd="vim -X -u ~$username/.vimrc"
    elif [ -r $HOME/.vimrc ]; then
        vicmd='vim -X -u $HOME/.vimrc'
    else
        vicmd='vim -X'
    fi
    alias vi="$vicmd"
}    
export EDITOR='vi'

function __edit_new_script () {
    text="$1"; shift
    for i; do
        [ ! -e "$i" ] && echo -e "$text" > "$i"
    done
    chmod +x "$@"
    eval $vicmd +$[$(echo -e "$text" | wc -l)] "$@"
}

alias vish='__edit_new_script "#!/bin/bash\n\n"'
alias vipy='__edit_new_script "#!/usr/bin/python\n\n"'
alias vipl='__edit_new_script "#!/usr/bin/perl -w\n\nuse strict;\n\n"'
alias vihtml="__edit_new_script '<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\"\n\t\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\n<html>\n<head>\n  <meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\" />\n  <title>\n\n  </title>\n</head>\n<body>\n\n</body>\n</html>'"
alias vibs="$vicmd $HOME/.bashrc"


### ls & other aliases###
if type gls > /dev/null 2>&1; then
    export LS_COLORS='no=00:fi=00:di=00;34:ln=00;36:pi=40;33:so=00;35:do=00;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=00;32:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.deb=00;31:*.rpm=00;31:*.jar=00;31:*.jpg=00;35:*.jpeg=00;35:*.gif=00;35:*.bmp=00;35:*.pbm=00;35:*.pgm=00;35:*.ppm=00;35:*.tga=00;35:*.xbm=00;35:*.xpm=00;35:*.tif=00;35:*.tiff=00;35:*.png=00;35:*.mov=00;35:*.mpg=00;35:*.mpeg=00;35:*.avi=00;35:*.fli=00;35:*.gl=00;35:*.dl=00;35:*.xcf=00;35:*.xwd=00;35:*.ogg=00;35:*.mp3=00;35:*.wav=00;35:';
    alias ls='gls -F --color'
elif [ "$os" = "linux" ]; then
    export LS_COLORS='no=00:fi=00:di=00;34:ln=00;36:pi=40;33:so=00;35:do=00;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=00;32:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.deb=00;31:*.rpm=00;31:*.jar=00;31:*.jpg=00;35:*.jpeg=00;35:*.gif=00;35:*.bmp=00;35:*.pbm=00;35:*.pgm=00;35:*.ppm=00;35:*.tga=00;35:*.xbm=00;35:*.xpm=00;35:*.tif=00;35:*.tiff=00;35:*.png=00;35:*.mov=00;35:*.mpg=00;35:*.mpeg=00;35:*.avi=00;35:*.fli=00;35:*.gl=00;35:*.dl=00;35:*.xcf=00;35:*.xwd=00;35:*.ogg=00;35:*.mp3=00;35:*.wav=00;35:';
    alias ls='ls -F --color'
else    
    export CLICOLOR=1
    alias ls='ls -F'
fi

alias ll="ls -lhG"
alias la="ls -A" 
alias lla="ls -lahG"
alias l="ls -C"
alias lm="lla | more"
function cl()
{
    cd $1; lla 
}
alias cdl="cl"
alias ..="cd .."
alias cd..="cd .."
alias home="cd ~"
alias h="history | more"
alias SB="source ~/.bash_profile"
alias BS="SB"
alias apache-restart="sudo /usr/sbin/apache2ctl -k restart"
alias mmdir="mkdir -m 700"
function mcdir()
{
    mkdir $1
    cd $1
}
alias rm="rm -i"
alias rmdir="rm -r"
alias remove_svn_folders="find . -name '.svn' -type d -print | xargs rm -rf {}"
function cddipl()
{
    if [ "$dipl_path" != "" ]; then
        cd "$dipl_path/latex"
        lla *.tex
    else
        echo "dipl_path nicht in .vars gesetzt!"
    fi
}
alias sudos="sudo true"
alias xumtsx="sudos & wvdial &"
function umts()
{
    sudo wvdial &
}
function now()
{
    if [ "$now" != "" ]; then
        cd "$now"
        lla 
        svn st
    else
        echo "now nicht in .vars gesetzt!"
    fi
}
alias ns="netstat -I en1 -ni 1"

alias cdsym="cd ~/Library/Application\ Support/iPhone\ Simulator/6.1/Applications/"

### SVN stuff ###

alias svnshowall="svn status | grep '^\?' | sed -e 's/? *//' | sed -e 's/ /\\ /g'"
alias svnaddallx="svn status | grep '^\?' | sed -e 's/? *//' | sed -e 's/ /\\ /g' | xargs svn add"
alias svnaddall="svn --force add ."


### SSH ALIASES AND FUNCTIONS ###
ssh="$(\which ssh)"
alias ssh="ssh-helper no $USER yes"
alias fssh="ssh-helper yes $USER yes"
alias rssh="ssh-helper no root yes"
alias frssh="ssh-helper yes root yes"
alias sexec="ssh-helper no $USER no"
ssh -V 2>&1 | grep OpenSSH > /dev/null && addlopt="Protocol 2"
alias scp="scp -o ' $addlopt'"

alias vwg="fssh jjochen@88.198.40.142"
alias mathe="fssh pfeiffer@ssh.mathematik.hu-berlin.de"
alias mac="fssh jochen@JJ-Mac.local"
alias sf="ssh jjochen@shell.sourceforge.net"

# Usage: ssh-helper [forward?] [username] [shell?]
function ssh-helper () {
    [ "$#" -lt 4 ] && { $ssh; return 1; }
    ssh-add -l 2>/dev/null | grep -i "no identities" > /dev/null && { 
        [ -f ~/.ssh/identity -o -f ~/.ssh/id_rsa ] && ssh-add >/dev/null
    }
    forward="$1"
    case "$*" in 
        *"-lroot"*|*"-l root"*|*root@*) 
            user="root" 
            ;; 
        *) 
            user="$2" 
            ;; 
    esac

    [ "$3" = "yes" ] && {
        if [ "$user" = "root" ]; then
            command="for i in $all_usernames root; do eval [ -r ~\$i/.bashrc ] && { eval bash -rcfile ~\$i/.bashrc; break; }; done;"
        else
            command='bash -rcfile $HOME/.bashrc'
        fi
        set -- "$@" "$command"
    }
    
    shift 3

    [ "$user" = "root" ] && set -- -lroot "$@"
    case "$forward" in
        [yY]*)
            $ssh -o "ForwardAgent $forward" -o " $addlopt" -t "$@"
            ;;
        *)
            $ssh -o " $addlopt" -t "$@"
            ;;
    esac
}    
alias rute='rssh -X 127.0.0.1'
######### END SSH STUFF #########

### prompt ###
# Background colors
bblack=40; bred=41; bgreen=42; byellow=43; bblue=44; bpink=45; bcyan=46; bwhite=47;
# Foreground colors
fblack=30; fred=31; fgreen=32; fyellow=33; fblue=34; fpink=35; fcyan=36; fwhite=37;

BG=$bwhite
FG=$fblack
BD='' # '1;'
case "$USER" in
    root) UC='1;31' ;;
    $username) UC='0' ;;
    *) case "$EUID" in 0) UC='1;31' ;; *) UC='0;36' ;; esac ;;
esac

function color_prompt()
{
    ps1_1="[\[\033[${UC}m\]\u\[\033[0m\]@${HST} \[\033[${fblue}m\]\w\[\033[0m\]]"
    ps1_2="\`if [ \$? = 0 ]; then echo -e \\[\\033[0\;34m\\]:\\\)\\[\\033[0m\\]; else echo -e \\[\\033[0\;31m\\]:\\\(\\[\\033[0m\\]; fi\`"
    PS1="${ps1_1} ${ps1_2} "
    export PS1

    case "$TERM" in
    xterm*|rxvt*)
        PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
        ;;
    *)
        ;;
    esac
}

function sw_prompt()
{
    PS1="[\u@${HST} \w] \`if [ \$? = 0 ]; then echo :\\\); else echo :\\\(; fi\` "
    export PS1

    case "$TERM" in
    xterm*|rxvt*)
        PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
        ;;
    *)
        ;;
    esac
}
function other_prompt()
{
    PS1='(\[\033[0;36m\]$?\[\033[0m\])(\[\033[1;$([ "$(jobs > /dev/null 2>&1; jobs 2>&1)" ])$[31-$?]m\]$(IFS="
"; set -- $(jobs); echo $#)j\[\033[0m\])[\[\033[${UC}m\]\u\[\033[0m\]@\[\033[${BG}m\033[${BD}${FG}m\]$HOST\[\033[0m\] \w]\$ '
    [ "$TERM"  = xterm -o "$TERM" = "rxvt" ] && PS1="\[\033]0;\u@\h (\$TTY): \w\007\]$PS1"
    # clock
    # PS1="\${COLUMNS:+\[\033[s\033[1;\$[\$COLUMNS-9]H\033[1;35m[\033[1;37m\t\033[1;35m]\033[0m\033[u\033[1A\]\n$PS1"
    export PS1
}
function powerprompt()
{
    _powerprompt()
    {
        LOAD=$(uptime|sed -e "s/.*: \([^,]*\).*/\1/" -e "s/ //g")
    }

    PROMPT_COMMAND=_powerprompt
    case $TERM in
        *term | rxvt  )
            PS1="${HILIT}[\A \$LOAD]$NC\n[\h \#] \W > \[\033]0;\${TERM} [\u@\h] \w\007\]" ;;
        linux )
            PS1="${HILIT}[\A - \$LOAD]$NC\n[\h \#] \w > " ;;
        * )
            PS1="[\A - \$LOAD]\n[\h \#] \w > " ;;
    esac
}

color_prompt
#sw_prompt
#other_prompt

export PS2='> '


function old-start-ssh()
{
    test "$SSH_AUTH_SOCK" || exec ssh-agent $SHELL -c "ssh-add; exec $SHELL -login" 
}

function start-ssh()
{
    
    shopt -s nullglob > /dev/null 2>&1
    allow_null_glob_expansion=1

    [ -z "$SSH_AUTH_SOCK" -a -n "$SSH2_AUTH_SOCK" ] && {
        export SSH_AUTH_SOCK=$SSH2_AUTH_SOCK
        export SSH_AGENT_PID=$SSH2_AGENT_PID
    }

    if ssh-add -l 2>/dev/null | grep "^[0-9]" > /dev/null; then
        : Do nothing
    elif [ -S "$SSH_AUTH_SOCK" -a -z "$SSH_AGENT_PID" ]; then
        echo -e "\033[1;31mWARNING: Your ssh-agent is forwarded! Log out as soon as possible.\033[0m"
    else
        # First, if we're running a valid ssh-agent, disconnect from it
        [ -S "$SSH_AUTH_SOCK" -a -n "$SSH_AGENT_PID" -a -d "/proc/$SSH_AGENT_PID" ] && 
          grep "^$$$" $SSH_AUTH_SOCK.users > /dev/null 2>&1 && {
            umask="$(umask)"
            umask 000; ctr=0
            until [ "$ctr" -ge 20 ] || mkdir $SSH_AUTH_SOCK.lock 2>/dev/null; do
                sleep 1; ctr=$[$ctr + 1]
            done
            grep -v "^$$$" $SSH_AUTH_SOCK.users > $SSH_AUTH_SOCK.users.new 2>/dev/null
            mv $SSH_AUTH_SOCK.users.new $SSH_AUTH_SOCK.users 2>/dev/null
            rmdir $SSH_AUTH_SOCK.lock
            umask $umask
        }
        # If the .users file is empty, Kill the ssh agent and remove the socket dir
        if [ -n "$SSH_AUTH_SOCK" -a ! -s "$SSH_AUTH_SOCK.users" ]; then
            rm -rf $SSH_AUTH_SOCK.{users,agentpid,lock} 2>/dev/null
            kill "$SSH_AGENT_PID" 2>/dev/null
            [ -d "$(dirname $SSH_AUTH_SOCK)" ] &&
                rm -rf "$(dirname $SSH_AUTH_SOCK)"
        fi

        # Dissociate ourselves from the agent.
        unset SSH_AUTH_SOCK SSH_AGENT_PID

        # Find a running agent.
        for i in /tmp/ssh-*/*agent*.users; do
            i=${i%.users}

            # Get the agent pid by catting the file we should have created before.
            agentpid="$(cat $i.agentpid 2>/dev/null)"

            # Otherwise, we have to use messier means to get the agent pid.
            [ -z "$agentpid" ] && {
                # Get a starting number from the pid # in the socket file name
                sockpid=$(echo $(basename "$i") | tr -c -d '[0-9]')
                curr="$[$sockpid + 1]"

                # Increment $curr until we find the ssh-agent or until we give up
                until [ "$curr" -gt "$[$sockpid + 15]" -o "$(ps -p $curr -o "comm=")" = "ssh-agent" ]; 
                do curr="$[$curr + 1]"; done

                [ "$curr" -le "$[$sockpid + 15]" ] && agentpid="$curr"
            }
            # Remove the whole directory and continue if there's no socket in it
            [ -S "$i" ] || { 
                kill "$agentpid" 2>/dev/null
                rm -rf "$(dirname "$i")" 2>/dev/null; 
                continue; 
            }
            [ -n "$agentpid" -a -t 0 ] && {
                export SSH_AUTH_SOCK=$i SSH_AGENT_PID=$agentpid
                ssh-add -l 2>/dev/null | grep $username > /dev/null && break
                unset SSH_AGENT_PID SSH_AUTH_SOCK
            }
        done

        # If unable to find an already-running agent, run one!
        { [ -z "$SSH_AGENT_PID" ] && [ -f ~/.ssh/id_rsa -o \
            -f ~/.ssh/identity -o -f ~/.ssh/id_dsa ]; } && {
            case " $untrusted_hosts_with_sshkey " in
                *" $HOST "*)
                    echo -e "\033[1;31mWARNING: Untrusted host with keyfile present. Do not ssh-add.\033[0m"
                    ;;
                *)
                    while :; do
                        if mkdir -m 700 /tmp/.ssh-add-$username 2>/dev/null; then
                            > /tmp/.ssh-add-$username/lock.$$
                            eval `ssh-agent` > /dev/null
                            [ -z "$SSH_AUTH_SOCK" -a -n "$SSH2_AUTH_SOCK" ] && {
                                export SSH_AUTH_SOCK=$SSH2_AUTH_SOCK
                                export SSH_AGENT_PID=$SSH2_AGENT_PID
                            }
                            echo "$SSH_AUTH_SOCK" > /tmp/.ssh-add-$username/auth_sock
                            # Record the agent pid so other logins can find it easily.
                            echo "$SSH_AGENT_PID" > "$SSH_AUTH_SOCK.agentpid"
                            if [ -z "$SIGUSR1" ]; then
                                ssh-add > /dev/null
                            else
                                sleep 1
                            fi
                        else
                            > /tmp/.ssh-add-$username/lock.$$
                            sleep 2
                            export SSH_AUTH_SOCK="$(head -1 /tmp/.ssh-add-$username/auth_sock 2>/dev/null)"
                            ssh-add -l 2>&1 | grep "Could not open a connection" > /dev/null && {
                                rm -rf /tmp/.ssh-add-$username
                                continue
                            }
                            export SSH_AGENT_PID="$(head -1 $SSH_AUTH_SOCK.agentpid 2>/dev/null)"
                        fi
                        break
                    done
                    rm /tmp/.ssh-add-$username/lock.$$
                    [ -z "$(echo /tmp/.ssh-add-$username/lock.*)" ] && rm -rf /tmp/.ssh-add-$username
                    ;;
            esac
        }

        if [ -n "$SSH_AUTH_SOCK" ]; then
            umask=$(umask)
            umask 000
            echo "$$" >> $SSH_AUTH_SOCK.users
            umask $umask
            trap "cleanssh excludeme" 0 EXIT 1 HUP 15 TERM
        fi 
    fi    
    
    shopt -u nullglob > /dev/null 2>&1
    unset allow_null_glob_expansion
}

function cleanssh () {
    pwd=$PWD
    umask=$(umask)
    umask 0 
    for ufile in /tmp/*ssh*/*.users; do
        dir="${ufile%/*}"
        [ -S "${ufile%.users}" ] || { rm -rf "$dir"; continue; }
        modified="0"
        pids=""
        while read pid; do
            if [ ! -d "/proc/$pid" ] || [ "$pid" = "$$" -a "$1" = "excludeme" ]; then
                modified=1
            else
                pids=${pids}${pids:+$'\n'}${pid}
            fi
        done < "$ufile"
        [ "$modified" = "0" ] && continue
        if [ -n "$pids" ]; then
            echo "$pids" > "$ufile"
        else
            pid=$(cat ${ufile%.users}.agentpid)
            [ -n "$pid" ] && kill $pid
            rm -rf "$dir"
        fi
    done
    umask $umask
    cd $pwd
}

#########################################
 
### functions ###


function vipw()
{

    if [ -e ~/pw/mypw.gpg ]
    then
        cp -f ~/pw/mypw.gpg ~/pw/mypw.gpg.bak
        gpg -o ~/pw/pw.tmp ~/pw/mypw.gpg 
        if [ "$1" = "w" ]; then
            vi ~/pw/pw.tmp
            gpg --yes -o ~/pw/mypw.gpg -se ~/pw/pw.tmp
            echo "new mypw.gpg writen!"
        else
            vi -R ~/pw/pw.tmp
        fi
        rm -f ~/pw/pw.tmp
    else
        echo "jipts nich!!!"
    fi
}

function exists()
{
    type $1 >/dev/null 2>&1
}
function wg_erreichbar()
{
    ping -c 1 takeouts.eu >/dev/null 2>&1
}
function is_workingcopy()
{
    svn=$(\which svn)
    $svn info $1 >/dev/null 2>&1
}


function x()
{
    #config-ci
    #config-up
    echo -e "\n\e[${fblue}mcu (f)\e[0m\n" 
    exit
}
alias :q='x'
alias ZZ='x'

function black()
{
    sw_prompt

    if type gls > /dev/null 2>&1; then
        export LS_COLORS='no=00:fi=00:di=00;35:ln=00;36:pi=40;33:so=00;34:do=00;34:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=00;32:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.deb=00;31:*.rpm=00;31:*.jar=00;31:*.jpg=00;34:*.jpeg=00;34:*.gif=00;34:*.bmp=00;34:*.pbm=00;34:*.pgm=00;34:*.ppm=00;34:*.tga=00;34:*.xbm=00;34:*.xpm=00;34:*.tif=00;34:*.tiff=00;34:*.png=00;34:*.mov=00;34:*.mpg=00;34:*.mpeg=00;34:*.avi=00;34:*.fli=00;34:*.gl=00;34:*.dl=00;34:*.xcf=00;34:*.xwd=00;34:*.ogg=00;34:*.mp3=00;34:*.wav=00;34:';
        alias ls='gls -F --color'
    elif [ "$os" = "linux" ]; then
        export LS_COLORS='no=00:fi=00:di=00;35:ln=00;36:pi=40;33:so=00;34:do=00;34:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=00;32:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.deb=00;31:*.rpm=00;31:*.jar=00;31:*.jpg=00;34:*.jpeg=00;34:*.gif=00;34:*.bmp=00;34:*.pbm=00;34:*.pgm=00;34:*.ppm=00;34:*.tga=00;34:*.xbm=00;34:*.xpm=00;34:*.tif=00;34:*.tiff=00;34:*.png=00;34:*.mov=00;34:*.mpg=00;34:*.mpeg=00;34:*.avi=00;34:*.fli=00;34:*.gl=00;34:*.dl=00;34:*.xcf=00;34:*.xwd=00;34:*.ogg=00;34:*.mp3=00;34:*.wav=00;34:';
        alias ls='ls -F --color'
    else    
        export CLICOLOR=1
        alias ls='ls -F'
    fi
}

### svn - config ###

function config-test()
{
    [ -e $HOME/config ] && exists svn && is_workingcopy $HOME/config && wg_erreichbar
}


function config-up()
{
    config-test && {
        svn=$(\which svn)
        rev_pre=$($svn info $HOME/config | grep Revision: | sed 's/Revision: //')
        $svn up $HOME/config
        rev_post=$($svn info $HOME/config | grep Revision: | sed 's/Revision: //')
        if [ $rev_pre -lt $rev_post ] ; then 
            config_was_updated=true && echo "$rev_pre -> $rev_post"
        fi
    }
}

function config-ci()
{
    config-test && {
        svn=$(\which svn)
        $svn ci $HOME/config/
    }
}

alias c-up='config-up'
alias c-ci='config-ci'

### sonstiges ###

function clang-format-ios {
    echo "\Clang-Format all files in current dir except ones in */libs/* folder and names containing *.framework.*\n\n"
    find . -name "*.[hm]" ! -path "*/libs/*" ! -path "*.framework*" ! -path "*/Pods/*" -print0 | xargs -0 clang-format -i
    echo "\nDONE\n"
}

function jj-test()
{
    return "hallo"
}

if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi

### startup ###

function _start-info()
{
    #echo -e "\nwho:"
    #who -Tu
    #echo -e "\e[${fblue}m"
    #type /usr/games/fortune >/dev/null 2>&1 && /usr/games/fortune
    #echo -e ""
    date "+%t %A %d/%m/%Y - %H:%M:%S"
    #echo -e "\e[0m"
}

start-ssh

#config_was_updated=false

#if [ -z $first_go ] && config-test ; then
    #config-up
    #if [ $config_was_updated == true ]
    #then
        #first_go="false"
        #eval source $HOME/.bash_profile
        #return
    #fi
#fi
#first_go=""

_start-info
test -d ~/bin



PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# Fig post block. Keep at the bottom of this file.
# [[ -f "$HOME/.fig/shell/bashrc.post.bash" ]] && . "$HOME/.fig/shell/bashrc.post.bash"

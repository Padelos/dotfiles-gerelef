# AUTHOR NOTE:
#  Treat these tutorials like you would PEP8. Read in detail.
#   https://github.com/bahamas10/bash-style-guide#bashisms
#   https://github.com/anordal/shellharden/blob/master/how_to_do_things_safely_in_bash.md
#   https://tldp.org/HOWTO/Man-Page/q2.html

REQUIRE_DEPENDENCIES+="tldr openssl bat "

#############################################################

# GLOBAL CONSTANTS
readonly DOTFILES_DIR="$HOME/dotfiles"
readonly HAS_RUN_FILE="$DOTFILES_DIR/.has-run"
readonly HAS_RUN_ZSH_FILE="$DOTFILES_DIR/.has-run-zsh"
readonly HAS_RUN_FSH_FILE="$DOTFILES_DIR/.has-run-fsh"
readonly HAS_RUN_KSH_FILE="$DOTFILES_DIR/.has-run-ksh"

# EXPORTS
# https://unix.stackexchange.com/questions/90759/where-should-i-install-manual-pages-in-user-directory
export MANPATH="$MANPATH:$DOTFILES_DIR/man"
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export HISTFILESIZE=100000
export HISTSIZE=10000
export HISTCONTROL=erasedups:ignoredups:ignorespace
export SUDO_PROMPT="$(tput setaf 4)Root password:$(tput sgr0)"
#############################################################
# package management 

install-system-pkg () (
    while :; do
        [[ -n "$(command -v dnf)" ]] && (sudo dnf install -y "$@"; break)
        [[ -n "$(command -v yum)" ]] && (sudo yum install -y "$@"; break)
        [[ -n "$(command -v apt)" ]] && (sudo apt install -y "$@"; break)
        break
    done
)

update-everything () (
    while :; do
        [[ -n "$(command -v dnf)" ]] && sudo dnf update -y --refresh && sudo dnf autoremove -y;
        [[ -n "$(command -v pacman)" ]] && sudo pacman -Syu;
        [[ -n "$(command -v yum)" ]] && sudo yum update -y;
        [[ -n "$(command -v apt)" ]] && sudo apt update -y && sudo apt autoremove -y && sudo apt clean -y && sudo apt autoclean -y;
        break
    done
    [[ -n "$(command -v flatpak)" ]] && flatpak update -y
    [[ -n "$(command -v snap)" ]] && snap refresh -y
    return 0
)

require-bashrc-packages () (
    [[ -f $HAS_RUN_FILE ]] && return 0

    echo -e "Installing essential .bashrc packages: $_FGREEN"
    echo -n "$REQUIRE_DEPENDENCIES" | tr " " "\n"
    echo -ne "$_NOCOLOUR"
    
    install-system-pkg $REQUIRE_DEPENDENCIES && touch $HAS_RUN_FILE && clear
)

require-bashrc () {
    # Source global & private definitions
    local _GLOBAL_BASHRC="/etc/bashrc"
    local _PRIVATE_BASHRC="$HOME/.bashrc-private"

    local _UTILITY_DEBUG="$DOTFILES_DIR/scripts/utils/debug.sh"
    local _UTILITY_FFMPEG="$DOTFILES_DIR/scripts/utils/ffmpeg.sh"
    local _UTILITY_YTDL="$DOTFILES_DIR/scripts/utils/ytdl.sh"
    local _UTILITY_MATH="$DOTFILES_DIR/scripts/utils/math.sh"
    local _UTILITY_PROMPT="$DOTFILES_DIR/scripts/utils/__setprompt.sh"
    
    [[ -f "$_GLOBAL_BASHRC" ]] && source "$_GLOBAL_BASHRC" 
    [[ -f "$_PRIVATE_BASHRC" ]] && source "$_PRIVATE_BASHRC"

    # SOFT DEPENDENCIES
    [[ -f "$_UTILITY_DEBUG" ]] && source "$_UTILITY_DEBUG"
    [[ -f "$_UTILITY_FFMPEG" ]] && source "$_UTILITY_FFMPEG"
    [[ -f "$_UTILITY_YTDL" ]] && source "$_UTILITY_YTDL"
    [[ -f "$_UTILITY_MATH" ]] && source "$_UTILITY_MATH"

    # HARD DEPENDENCIES
    [[ -f "$_UTILITY_PROMPT" ]] && source "$_UTILITY_PROMPT"
    
    # PACKAGE DEPENDENCIES
    require-bashrc-packages || return 1
}

dnf-installed-packages-by-size () (
    # https://forums.fedoraforum.org/showthread.php?314323-Useful-one-liners-feel-free-to-update&p=1787643
    dnf -q --disablerepo=* info installed | sed -n 's/^Name[[:space:]]*: \|^Size[[:space:]]*: //p' | sed 'N;s/\n/ /;s/ \(.\)$/\1/' | sort -hr -k 2 | less
)

_dnf-installed-packages-by-size_completions () {
    COMPREPLY=()
}

complete -F _dnf-installed-packages-by-size_completions dnf-installed-packages-by-size

#############################################################
# pure bash helpers 
# Get directory size 
gds () (
    if [[ -n "$*" ]]; then
        for arg in "$@"; do
            du -sh --apparent-size "$arg"
        done
    else
        du -sh --apparent-size .
    fi
)

complete -A directory gds

# Highlight (and not filter) text with grep
highlight () (
    [[ -z "$*" ]] && return 2
    
    grep --color=always -iE "$1|\$"
)

# Rename
rn () (
    [[ -z "$*" ]] && return 2
    [[ $# -eq 2 ]] || return 2
    
    mv -vn "$1" "$2"
)

restart-pipewire () (
    systemctl --user restart pipewire
)

_restart-pipewire_completions () {
    COMPREPLY=()
}

complete -F _restart-pipewire_completions restart-pipewire

restart-network-manager () (
    systemctl restart NetworkManager
)

_restart-network-manager_completions () {
    COMPREPLY=()
}

complete -F _restart-network-manager_completions restart-network-manager

#############################################################
# PYTHON SCRIPTS

# call lss py implementation
lss () (
    $DOTFILES_DIR/scripts/utils/lss.py "$@"
)

complete -A directory lss

update-mono-ff-theme () (
    $DOTFILES_DIR/scripts/utils/update-mono-ff-theme.py "$@"
)

update-compat-layers () (
    $DOTFILES_DIR/scripts/utils/update-compat-layers.py "$@"
)

#############################################################
# WRAPPERS TO BUILTINS OR PATH EXECUTABLES

# journalctl wrapper for ease of use
_journalctl () (
    [[ $# -eq 0 ]] && command journalctl -e -n 2000 && return
    # called with just a service name (-u)
    [[ $# -eq 1 ]] &&  command journalctl -e -n 5000 -u "$1" && return
    command journalctl "$@"
)

alias journalctl="_journalctl"
complete -A service journalctl

# tldr wrapper for ease of use
_tldr () (
    [[ $# -eq 0 ]] && (command tldr tldr) | less -R && return    
    [[ $# -eq 1 ]] && (command tldr "$1") | less -R && return
    command tldr "$@"
)

alias tldr="_tldr"
complete -A command tldr

# Automatically do an ls after each cd
cd () { 
	builtin cd "$@" && lss
}

#############################################################
# DIFFERENT SHELLS

require-ksh-packages () (
    [[ -f $HAS_RUN_KSH_FILE ]] && return 0
    
    echo -ne "$_FBROWN"
    echo -e "Installing ksh $_NOCOLOUR"
    
    install-system-pkg ksh && touch $HAS_RUN_KSH_FILE && clear
)

ksh () (
    require-ksh-packages 
    
    /usr/bin/env ksh
)

require-fsh-packages () (
    [[ -f $HAS_RUN_FSH_FILE ]] && return 0
    
    echo -ne "$_FBLUE"
    echo -e "Installing fish $_NOCOLOUR"
    
    install-system-pkg fish && touch $HAS_RUN_FSH_FILE && clear
)

fsh () (
    require-fsh-packages  
    
    /usr/bin/env fish
)

require-zsh-packages () (
    [[ -f $HAS_RUN_ZSH_FILE ]] && return 0
    
    echo -ne "$_FYELLOW"
    echo -e "Installing zsh $_NOCOLOUR"
    
    install-system-pkg zsh && touch $HAS_RUN_ZSH_FILE && clear
)

zsh () (
    require-zsh-packages 
    
    /usr/bin/env zsh
)

#############################################################
# PYTHON VENV(s)

# goal: we want to create alot of different vipN () (...) functions to call
#  for every different virtual environment that we have; e.g. python3.11 will have vip3.11
#  which calls for the activation of the virtual environment of python3.11 stored somewhere on the system
#  to do that, we're going to (1) create a mock file (2) dump all these different functions in it
#  (3) source it (4) then promptly delete it so we don't create garbage files & for (perhaps) obscure security reasons
#    these functions (which only differ by the python version they're calling) should:
#      (1) check if a venv (for this specific version) exists in the venv directory. If it doesn't, 
#        (1a) create a new venv for this specific version
#      (2) source the activation script (and enter the venv)

# important note: the statement pythonX.x -m venv \"\$venv_dir\" won't work with 2.7 or lower,
#  for that, we need the virtualenv module
prepare-pip () (
    local vip_fname="/tmp/vip-temp-$(date +%s%N).sh"
    local venv_dir="$HOME/.vpip"
    local python_versions=()
    
    # get all the appropriate versions from the filesystem 
    # https://stackoverflow.com/a/57485303
    for pv in "$(ls -1 /usr/bin/python* | grep '.*[0-9]\.\([0-9]\+\)\?$')"; do
        python_versions+=("$pv")
    done
    
    # create mock functions
    for python_version in $python_versions; do 
        # sanitize the filename and keep only the numbers at the end
        local python_version_number="$(echo $python_version | tr -d -c 0-9.)"
        
        local virtual_group="vip$python_version_number () {
            [[ \"\$EUID\" -eq 0 ]] && echo \"Do NOT run as root.\" && return 2; 
            [[ ! -d \"$venv_dir\" ]] && mkdir -p \"$venv_dir\" # create root dir if doesn't exist
            local venv_dir=\"$venv_dir/dvip$python_version_number\"
            
            # if venv dir doesn't exist for our version notify and create it
            [[ ! -d \"\$venv_dir\" ]] && echo \"\$venv_dir doesn't exist; creating venv for $python_version\"
            [[ ! -d \"\$venv_dir\" ]] && $python_version -m venv \"\$venv_dir\"
            
            source \"\$venv_dir/bin/activate\"
        }"
        
        local virtual_group_subshell="vip$python_version_number-subshell () {
            [[ \"\$EUID\" -eq 0 ]] && echo \"Do NOT run as root.\" && return 2; 
            [[ ! -d \"$venv_dir\" ]] && mkdir -p \"$venv_dir\" # create root dir if doesn't exist
            local venv_dir=\"$venv_dir/dvip$python_version_number\"
            
            # if venv dir doesn't exist for our version create it
            [[ ! -d \"\$venv_dir\" ]] && echo \"\$venv_dir doesn't exist; creating venv for $python_version\"
            [[ ! -d \"\$venv_dir\" ]] && $python_version -m venv \"\$venv_dir\"
            
            bash --init-file <(echo \"source \\\"$HOME/.bashrc\\\"; source \$venv_dir/bin/activate\")
        }"
        
        # append to the file
        echo "$virtual_group" >> $vip_fname
        echo "$virtual_group_subshell" >> $vip_fname
    done 
    
    echo $vip_fname
)

require-pip () {
    local vip_fname="$(prepare-pip)"

    # source the file & delete
    source "$vip_fname"
    rm "$vip_fname"
}

require-pip

#############################################################
# BASH OPTIONS

require-bashrc
PROMPT_COMMAND='__setprompt; history -a'

shopt -s autocd
shopt -s cdspell
shopt -s checkwinsize
shopt -s histappend

bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"

#############################################################

alias rebootsafe='sudo shutdown -r now'
alias rebootforce='sudo shutdown -r -n now'

# archives
alias mktar='tar -cvf'
alias mkbz2='tar -cvjf'
alias mkgz='tar -cvzf'
alias untar='tar -xvf'
alias unbz2='tar -xvjf'
alias ungz='tar -xvzf'
alias unxz="tar -xf"

# encryptions
alias md5="openssl md5"
alias sha1="openssl sha1"
alias sha256="openssl sha256"
alias sha512="openssl sha512"

alias bd='cd "$OLDPWD"'
alias less='less -R'

# dir up
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# substitutes for commands
alias ftrim="fstrim -v"
alias flatpak-log="flatpak remote-info --log flathub"
alias flatpak-checkout="flatpak update --commit="

# convenience alias
alias c="clear"
alias wget="\wget -c --read-timeout=5 --tries=0"
alias mkvenv="python -m venv venv" # create venv (pythonXX cvenv)

alias reverse="tac"
alias palindrome="rev"

alias grep="\grep -i"
alias rm="rm -v"
alias ccat="bat --theme Dracula"
alias gedit="gnome-text-editor" # gedit replacement of choice
alias fuck='sudo $(history -p \!\!)'

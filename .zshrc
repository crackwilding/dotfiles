# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# Avoid polluting the home dir.
export ZSH_COMPDUMP=$ZSH/.cache/.zcompdump-$HOST 

source $ZSH/oh-my-zsh.sh

export ZPLUG_HOME=/opt/homebrew/opt/zplug
source $ZPLUG_HOME/init.zsh
zplug "mafredri/zsh-async", from:github
zplug "zsh-users/zsh-autosuggestions", as:plugin, defer:2
zplug "zsh-users/zsh-syntax-highlighting", from:github
zplug load

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# User configuration

export PATH=/opt/local/libexec/gnubin/:$PATH
export PATH=$PATH:/opt/local/bin
export PATH=$PATH:/Users/fm56/Library/Python/3.9/bin
export PATH=$PATH:/Users/fm56/vendor/bin
export PATH=$PATH:./vendor/bin
export PATH=$PATH:/opt/local/lib/mysql57/bin
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/Users/fm56/.composer/vendor/bin


# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Aliases
alias ll="ls -la"

alias astart="sudo apachectl start"
alias astop="sudo apachectl stop"
alias arestart="sudo apachectl restart"
alias dbstart="sudo port load mariadb-10.11-server"
alias dbstop="sudo port unload mariadb-10.11-server"
alias dbrestart="sudo port reload mariadb-10.11-server"

alias hosts="sudo nvim /etc/hosts"
alias vhosts="sudo nvim /opt/local/etc/apache2/extra/httpd-vhosts.conf"

alias packages="cd /Volumes/DerWirt/packages"
alias personal="cd /Volumes/DerWirt/personal"
alias plesk="cd /Volumes/DerWirt/plesk"
alias gt="cd /Volumes/DerWirt/gt"
alias sandboxes="cd /Volumes/DerWirt/sandboxes"
alias tlw="cd /Volumes/DerWirt/aws"

alias gstage="find ./* -type d -name \"html\" -maxdepth 1 -exec git --git-dir={}/.git --work-tree=$PWD/{} checkout stage && say 'done' \;"
alias gsquare="find ./* -type d -name \"html\" -maxdepth 1 -execdir bash -c \"cd '{}' && pwd && git checkout stage && git pull && git checkout main && git pull && git checkout stage\" \;"
alias drebuild="sudo rm -r vendor; sudo rm -r web/core; sudo rm -r web/modules/contrib; sudo rm -r web/themes/contrib; sudo rm -r web/profiles/contrib; composer install; say 'done'"

# Functions

# Checkout stage and force clean untracked files.
function psquare() {
  find ./* -type d -name html -maxdepth 1 \
    -exec sh -c '
      dir="$1";
      echo "\n$1";
      git --git-dir="$1/.git" --work-tree=$PWD/$dir checkout -f stage;
      git --git-dir="$1/.git" --work-tree=$PWD/$dir clean -fd;
      git --git-dir="$1/.git" --work-tree=$PWD/$dir pull;
      git --git-dir="$1/.git" --work-tree=$PWD/$dir checkout -f main;
      git --git-dir="$1/.git" --work-tree=$PWD/$dir clean -fd;
      git --git-dir="$1/.git" --work-tree=$PWD/$dir pull;
      git --git-dir="$1/.git" --work-tree=$PWD/$dir checkout stage;
  ' _ {} \;
}

# Check whether stage and main are even.
function pcompare() {
  find ./* -type d -name html -maxdepth 1 \
    -exec sh -c '
      dir="$1";
      echo "\n$1"; 
      git --git-dir="$1/.git" --work-tree=$PWD/$dir checkout main;
      git --git-dir="$1/.git" --work-tree=$PWD/$dir pull;
      git --git-dir="$1/.git" --work-tree=$PWD/$dir checkout stage;
      git --git-dir="$1/.git" --work-tree=$PWD/$dir pull;
      git --git-dir="$1/.git" --work-tree=$PWD/$dir diff --quiet stage main;
  ' _ {} \;
}

# Clean all git repos. Run in plesk or tlw.
function pclean() {
  find ./* -type d -name html -maxdepth 1 \
    -exec sh -c '
      dir="$1";
      echo "\n$1"; 
      git --git-dir="$1/.git" --work-tree="$PWD/$1" gc;
    ' sh {} \;
  say "done"
}

# Starship prompt
eval "$(starship init zsh)"

# Make MySQL stop being such a dick
ulimit -n 200000
ulimit -u 2048

# Composer is a big fat hog
export COMPOSER_PROCESS_TIMEOUT=600

# output a user variable, currentDir, for iterm
function iterm2_print_user_vars() {
  fullpath=(${(@s:/:)PWD})

  if [[ $fullpath[3] = '' ]]
  then
    shortpath=$(PWD)
  elif [[ $fullpath[3] = 'plesk' ]]
  then
    shortpath=$fullpath[4]
  elif [[ $fullpath[3] = 'gt' ]]
  then
    shortpath=$fullpath[4]
  elif [[ $fullpath[3] = 'aws' ]]
  then
    shortpath=$fullpath[4]
  elif [[ $fullpath[3] = 'packages' ]]
  then
    shortpath=$fullpath[4]
  else
    shortpath=${PWD}
  fi

  iterm2_set_user_var currentDir "$shortpath"
}

# iterm command line integration
test -e /Users/fm56/.iterm2_shell_integration.zsh && source /Users/fm56/.iterm2_shell_integration.zsh || true
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/fm56/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

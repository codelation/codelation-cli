class Codelation::Development::DotFiles
  CODELATION = <<-CONTENT
# Aliases useful for Codelation development
alias desktop="cd ~/Desktop"
alias downloads="cd ~/Downloads"
alias fixopenwith="/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -kill -r -domain local -domain user"
alias gdif="git diff --color | diff-so-fancy"
alias gdiff="git diff --color | diff-so-fancy"
alias gg="git status -s"
alias gitclean='git branch --merged | grep -v "\\*" | xargs -n 1 git branch -d'
alias gitdif="git diff --color | diff-so-fancy"
alias gitdiff="git diff --color | diff-so-fancy"
alias ll="ls -lah"
alias railsclean="RAILS_ENV=development rake assets:clean; RAILS_ENV=development rake tmp:clear; RAILS_ENV=test rake assets:clean; RAILS_ENV=test rake tmp:clear"
alias ss="bundle exec rake start"

# Add Postgres commands from Postgres.app
PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.4/bin

# Add ./bin to make running Rails commands with Spring the default
PATH=./bin:$PATH

# Include chruby for switching between Ruby versions
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh

# Set the default Ruby version
chruby ruby-2.3.1

# Git Completion & Repo State
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

MAGENTA="\\[\\033[0;35m\\]"
YELLOW="\\[\\033[0;33m\\]"
BLUE="\\[\\033[34m\\]"
LIGHT_GRAY="\\[\\033[0;37m\\]"
CYAN="\\[\\033[0;36m\\]"
GREEN="\\[\\033[0;32m\\]"
GIT_PS1_SHOWDIRTYSTATE=true
export LS_OPTIONS='--color=auto'
export CLICOLOR='Yes'
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

export PS1=$LIGHT_GRAY"\\u@\\h"'$(
    if [[ $(__git_ps1) =~ \\*\\)$ ]]
    # a file has been modified but not added
    then echo "'$YELLOW'"$(__git_ps1 " (%s)")
    elif [[ $(__git_ps1) =~ \\+\\)$ ]]
    # a file has been added, but not commited
    then echo "'$MAGENTA'"$(__git_ps1 " (%s)")
    # the state is clean, changes are commited
    else echo "'$CYAN'"$(__git_ps1 " (%s)")
    fi)'$BLUE" \\w"$GREEN": "
CONTENT
end

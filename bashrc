alias cp='cp -i'
alias ls='ls --color=auto --show-control-chars'
alias ll='ls -l'
alias mv='mv -i'
alias rm='rm -i'

PS1='\[\033]2;\h:\w\a\033[00;32m\]\u@\h\[\033[00;33m\]:\W$(__git_ps1)\[\033[00m\]\$ '

export USER=$USERNAME

alias cp='cp -i'
alias ls='ls --color=auto --show-control-chars'
alias ll='ls -l'
alias mv='mv -i'
alias rm='rm -i'

if ! shopt -oq posix; then
    if [[ -f /usr/share/bash-completion/bash_completion ]]; then
        . /usr/share/bash-completion/bash_completion
    elif [[ -f /etc/bash_completion ]]; then
        . /etc/bash_completion
    fi
fi

if type -t __git_ps1 > /dev/null; then
    PS1='\[\e]0;\h:\w\a\]\[\e[0;32m\]\u\[\e[0m\]@\[\e[34;1m\]\h\[\e[0m\]:\[\e[0;33m\]\W$(__git_ps1)\[\e[0m\] \$ \[\e[0m\]'
else
    PS1='\[\e]0;\h:\w\a\]\[\e[0;32m\]\u\[\e[0m\]@\[\e[34;1m\]\h\[\e[0m\]:\[\e[0;33m\]\W\[\e[0m\] \$ \[\e[0m\]'
fi

if [[ -z "${USER}" && -n "${USERNAME}" ]]; then
    export USER="${USERNAME}"
fi

export PYENV_ROOT="${HOME}/.pyenv"
if [[ -d "${PYENV_ROOT}" ]]; then
    export PATH="${PYENV_ROOT}/bin:${PATH}"
    eval "$(pyenv init -)"
fi

export RBENV_ROOT="${HOME}/.rbenv"
if [[ -d "${RBENV_ROOT}" ]]; then
    export PATH="${RBENV_ROOT}/bin:${PATH}"
    eval "$(rbenv init -)"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

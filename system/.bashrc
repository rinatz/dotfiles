#
# aliases
#
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

if type exa &> /dev/null; then
    alias ls='exa'
    alias ll='exa -lhF --time-style=long-iso'
else
    alias ll='ls -lhF'
fi

#
# completions
#
if [[ -f /etc/profile ]]; then
    . /etc/profile
fi

if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    . /usr/share/bash-completion/bash_completion
elif [[ -f /etc/bash_completion ]]; then
    . /etc/bash_completion
elif [[ -f /usr/local/etc/profile.d/bash_completion.sh ]]; then
    . /usr/local/etc/profile.d/bash_completion.sh
fi

if [[ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]]; then
    . /usr/share/git-core/contrib/completion/git-prompt.sh
fi

#
# PS1
#
if type __git_ps1 &> /dev/null; then
    PS1='\[\e]0;\h:\w\a\]\[\e[0;32m\]\u\[\e[0m\]@\[\e[34;1m\]\h\[\e[0m\]:\[\e[0;33m\]\W$(__git_ps1)\[\e[0m\] \$ \[\e[0m\]'
else
    PS1='\[\e]0;\h:\w\a\]\[\e[0;32m\]\u\[\e[0m\]@\[\e[34;1m\]\h\[\e[0m\]:\[\e[0;33m\]\W\[\e[0m\] \$ \[\e[0m\]'
fi

#
# share history
#
function __share_history__() {
    history -a
    history -c
    history -r
}
PROMPT_COMMAND='__share_history__'
shopt -u histappend

#
# fzf
#
if [[ -f "${HOME}/.fzf.bash" ]]; then
    . "${HOME}/.fzf.bash"

    if [[ -t 1 ]]; then
        function __fzf_ghq_look__() {
            local dir
            dir="$(ghq list | fzf)" && cd "$(ghq root)/${dir}"
        }
        bind -x '"\C-g": __fzf_ghq_look__'
    fi
fi

#
# direnv
#
if type direnv &> /dev/null; then
    eval "$(direnv hook bash)"
fi

#
# pyenv
#
export PYENV_ROOT="${HOME}/.pyenv"

if [[ -d "${PYENV_ROOT}" ]]; then
    export PATH="${PYENV_ROOT}/bin:${PATH}"
    eval "$(pyenv init -)"
fi

#
# pipenv
#
export PIPENV_VENV_IN_PROJECT=1

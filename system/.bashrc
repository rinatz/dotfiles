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
[[ -r /etc/profile ]] && . /etc/profile

if [[ -r /usr/share/bash-completion/bash_completion ]]; then
    . /usr/share/bash-completion/bash_completion
elif [[ -r /etc/bash_completion ]]; then
    . /etc/bash_completion
elif [[ -r /usr/local/etc/profile.d/bash_completion.sh ]]; then
    . /usr/local/etc/profile.d/bash_completion.sh
fi

#
# PS1
#
function __ps1__() {
    if [[ -r /usr/share/git-core/contrib/completion/git-prompt.sh ]]; then
        . /usr/share/git-core/contrib/completion/git-prompt.sh
    fi

    local git_ps1=

    if type __git_ps1 &> /dev/null; then
        git_ps1='$(__git_ps1)'
    fi

    echo '\[\e]0;\h:\w\a\]\[\e[0;32m\]\u\[\e[0m\]@\[\e[34;1m\]\h\[\e[0m\]:\[\e[0;33m\]\W'"${git_ps1}"'\[\e[0m\] \$ \[\e[0m\]'
}
PS1=$(__ps1__)

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
    source "${HOME}/.fzf.bash"

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
# anyenv
#
export PATH="${HOME}/.anyenv/bin:${PATH}"
if type anyenv &> /dev/null; then
    eval "$(anyenv init -)"
fi

#
# pipenv
#
export PIPENV_VENV_IN_PROJECT=1

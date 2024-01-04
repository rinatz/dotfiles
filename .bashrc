# shellcheck shell=bash

if [[ -f /etc/profile ]]; then
    # shellcheck source=/dev/null
    . /etc/profile
fi

if [[ -f /etc/bashrc ]]; then
    # shellcheck source=/dev/null
    . /etc/bashrc
fi

#
# aliases
#
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

if type exa &>/dev/null; then
    alias ls='exa'
    alias ll='exa -lhF --time-style=long-iso --icons --git'
else
    alias ll='ls -lhF'
fi

#
# bash-completion
#
if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    # shellcheck source=/dev/null
    . /usr/share/bash-completion/bash_completion
elif [[ -f /usr/local/etc/bash_completion ]]; then
    # shellcheck source=/dev/null
    . /usr/local/etc/bash_completion
fi

#
# share history
#
PROMPT_COMMAND="history -a; history -c; history -r; ${PROMPT_COMMAND}"
shopt -u histappend

#
# PATH
#
export PATH="${HOME}/.local/bin:${PATH}"

#
# fzf
#
if [[ -f "${HOME}/.fzf.bash" ]]; then
    # shellcheck source=/dev/null
    . "${HOME}/.fzf.bash"

    if [[ -t 1 ]]; then
        function __fzf_git_repo__() {
            local dir
            dir="$(ghq list | fzf)"

            if [[ -n "${dir}" ]]; then
                cd "$(ghq root)/${dir}" || exit
            fi
        }
        bind -x '"\C-g": __fzf_git_repo__'
    fi
fi

#
# direnv
#
if type direnv &>/dev/null; then
    eval "$(direnv hook bash)"
fi

#
# python
#
if [[ -d "${HOME}/.pyenv" ]]; then
    export PATH="${HOME}/.pyenv/bin:${PATH}"
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
fi

#
# ruby
#
if [[ -d "${HOME}/.rbenv" ]]; then
    export PATH="${HOME}/.rbenv/bin:${PATH}"
    eval "$(rbenv init -)"
fi

#
# sdkman
#
if [[ -f "${HOME}/.sdkman/bin/sdkman-init.sh" ]]; then
    # shellcheck source=/dev/null
    . "${HOME}/.sdkman/bin/sdkman-init.sh"
fi

#
# rustup
#
if [[ -f "${HOME}/.cargo/env" ]]; then
    # shellcheck source=/dev/null
    . "${HOME}/.cargo/env"
fi

#
# fnm
#
export PATH="${HOME}/.local/share/fnm:${PATH}"
eval "$(fnm env)"

#
# go
#
export GOPATH="${HOME}/go"
export PATH="${GOPATH}/bin:${PATH}"

#
# BASH_SILENCE_DEPRECATION_WARNING
#
export BASH_SILENCE_DEPRECATION_WARNING=1

#
# starship
#
if type starship &>/dev/null; then
    eval "$(starship init bash)"
fi

function set_win_title() {
    echo -ne "\033]0; $(basename "${PWD}") \007"
}

starship_precmd_user_func="set_win_title"

# fnm
export PATH="/home/wsl/.local/share/fnm:$PATH"
eval "`fnm env`"

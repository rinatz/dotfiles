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
# bash-completion
#
if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    # shellcheck source=/dev/null
    . /usr/share/bash-completion/bash_completion
elif [[ -f /opt/homebrew/etc/bash_completion ]]; then
    # shellcheck source=/dev/null
    . /opt/homebrew/etc/bash_completion
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
# BASH_SILENCE_DEPRECATION_WARNING (macOS)
#
export BASH_SILENCE_DEPRECATION_WARNING=1

#
# Homebrew (macOS)
#
if [[ -f "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

#
# mise
#
if [[ -f "${HOME}/.local/bin/mise" ]]; then
    eval "$("${HOME}/.local/bin/mise" activate bash)"
fi

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
# rustup
#
if [[ -f "${HOME}/.cargo/env" ]]; then
    # shellcheck source=/dev/null
    . "${HOME}/.cargo/env"
fi

#
# go
#
export GOPATH="${HOME}/go"
export PATH="${GOPATH}/bin:${PATH}"

#
# starship
#
if type starship &>/dev/null; then
    eval "$(starship init bash)"
fi

function set_win_title() {
    echo -ne "\033]0; $(basename "${PWD}") \007"
}

# shellcheck disable=SC2034
starship_precmd_user_func="set_win_title"

#
# aliases
#
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias ll='ls -lhF'

if type lsd &>/dev/null; then
    alias ls='lsd'
    alias ll='lsd -lhF --date="+%Y-%m-%d %H:%M:%S" --git --header'
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

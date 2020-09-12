# shellcheck shell=bash

#
# aliases
#
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

if type exa &>/dev/null; then
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
    # shellcheck source=/dev/null
    . /usr/share/bash-completion/bash_completion
elif [[ -f /etc/bash_completion ]]; then
    # shellcheck source=/dev/null
    . /etc/bash_completion
elif [[ -f /usr/local/etc/profile.d/bash_completion.sh ]]; then
    # shellcheck source=/dev/null
    . /usr/local/etc/profile.d/bash_completion.sh
fi

if [[ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]]; then
    # shellcheck source=/dev/null
    . /usr/share/git-core/contrib/completion/git-prompt.sh
fi

#
# PS1
#
if type __git_ps1 &>/dev/null; then
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
    # shellcheck source=/dev/null
    . "${HOME}/.fzf.bash"

    if [[ -t 1 ]]; then
        function __fzf_ghq_look__() {
            local dir
            dir="$(ghq list | fzf)"
            cd "$(ghq root)/${dir}" || exit
        }
        bind -x '"\C-g": __fzf_ghq_look__'
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
export PYTHON_CONFIGURE_OPTS="--enable-framework --with-tcltk-includes='-I/usr/local/opt/tcl-tk/include' --with-tcltk-libs='-L/usr/local/opt/tcl-tk/lib -ltcl8.6 -ltk8.6'"

if [[ -d "${HOME}/.pyenv" ]]; then
    export PATH="${HOME}/.pyenv/bin:${PATH}"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

if [[ -f "${HOME}/.poetry/env" ]]; then
    # shellcheck source=/dev/null
    . "${HOME}/.poetry/env"
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
# nvm
#
export NVM_DIR="${HOME}/.nvm"

if [[ -f "${NVM_DIR}/nvm.sh" ]]; then
    # shellcheck source=/dev/null
    . "${NVM_DIR}/nvm.sh"
fi

if [[ -f "${NVM_DIR}/bash_completion" ]]; then
    # shellcheck source=/dev/null
    . "${NVM_DIR}/bash_completion"
fi

#
# go
#
export GOPATH="${HOME}/go"
export PATH="${GOPATH}/bin:${PATH}"

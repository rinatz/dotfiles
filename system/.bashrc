#
# aliases
#
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

if type exa &> /dev/null; then
    alias ls='exa'
    alias ll='exa -lF --time-style=long-iso'
else
    alias ll='ls -lFA'
fi

#
# completions
#
if ! shopt -oq posix; then
    if [[ -f /usr/share/bash-completion/bash_completion ]]; then
        . /usr/share/bash-completion/bash_completion
    elif [[ -f /etc/bash_completion ]]; then
        . /etc/bash_completion
    fi
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
# Base16 Shell
#
BASE16_SHELL="${HOME}/.config/base16-shell"
if [[ -n "${PS1}" ]]; then
    if [[ -s "${BASE16_SHELL}/profile_helper.sh" ]]; then
        eval "$("${BASE16_SHELL}/profile_helper.sh")"
    fi
fi

#
# share history
#
function share_history {
    history -a
    history -c
    history -r
}
PROMPT_COMMAND='share_history'
shopt -u histappend

#
# direnv
#
if type direnv &> /dev/null; then
    eval "$(direnv hook bash)"
fi

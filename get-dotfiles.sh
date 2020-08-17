#!/bin/bash
set -eu

alias rm="\rm"
alias cp="\cp"

function target_os() {
    case $(uname) in
    MINGW*) echo "windows" ;;
    MSYS*) echo "windows" ;;
    CYGWIN*) echo "windows" ;;
    Darwin*) echo "macos" ;;
    Linux*) echo "linux" ;;
    *) echo "" ;;
    esac
}

function main() {
    local url="https://github.com/rinatz/dotfiles/archive/master.tar.gz"

    local temp
    temp=$(mktemp -d /tmp/dotfiles-XXXXXX)

    curl -fsSL "${url}" | tar zxv -C "${temp}" --strip-components 1

    local dotfiles
    dotfiles=$(find "${temp}" -name ".*")

    for dotfile in ${dotfiles}; do
        if [[ $(target_os) != "windows" ]]; then
            [[ "${dotfile}" =~ ^.*\/windows\/.* ]] && continue
        fi

        cp -rfv "${dotfile}" "${HOME}"
    done

    rm -rf "${temp}"
}

main "$@"

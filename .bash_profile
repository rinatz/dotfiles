# shellcheck shell=bash

if [[ -f "${HOME}/.bashrc" ]]; then
    # shellcheck source=/dev/null
    . "${HOME}/.bashrc"
fi

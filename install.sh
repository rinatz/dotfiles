#!/bin/bash -eu

readonly REPO="https://github.com/rinatz/dotfiles.git"
readonly DEST="${HOME}/.dotfiles"

function main() {
    if [[ ! -e "${DEST}" ]]; then
        git clone "${REPO}" "${DEST}"
    fi

    cd "${HOME}"

    local files
    files=$(find "${DEST}" -type f -name ".*" | grep -v windows)

    for file in ${files[@]}; do
        ln -sf "${file}" $(basename "${file}")
    done
}

main "$@"

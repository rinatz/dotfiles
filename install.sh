#!/bin/bash -eu

readonly REPO="https://github.com/rinatz/dotfiles.git"
readonly DEST="${HOME}/.dotfiles"

function main() {
    git clone "${REPO}" "${DEST}"

    cd "${HOME}"

    local files
    files=$(find "${DEST}" -type f -name ".*" | grep -v windows)

    for file in ${files[@]}; do
        ln -sf "${file}" $(basename "${file}")
    done
}

main "$@"

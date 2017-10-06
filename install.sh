#!/bin/bash -eu

readonly SRC="https://github.com/rinatz/dotfiles/archive/master.tar.gz"
readonly DEST="${HOME}/.dotfiles"

function main() {
  mkdir -p "${DEST}"
  curl -fsSL "${SRC}" | tar zxv -C "${DEST}" --strip-components 1

  local dotfiles
  dotfiles=$(find "${DEST}" -name ".*" | grep -v windows)

  for dotfile in ${dotfiles[@]}; do
    [[ $(basename "${dotfile}") == "${DEST}" ]] && continue

    ln -svf "${dotfile}" "${HOME}"
  done
}

main "$@"

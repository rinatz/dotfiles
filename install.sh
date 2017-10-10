#!/bin/bash -eu

readonly SRC="https://github.com/rinatz/dotfiles/archive/master.tar.gz"
readonly DEST="/tmp/dotfiles"

function main() {
  mkdir -p "${DEST}"
  curl -fsSL "${SRC}" | tar zxv -C "${DEST}" --strip-components 1

  local dotfiles
  dotfiles=$(find "${DEST}" -name ".*")

  for dotfile in ${dotfiles[@]}; do
    [[ "${dotfile}" == "${DEST}" ]] && continue
    [[ "${dotfile}" == "${DEST}/.git" ]] && continue

    if [[ ! $(uname) =~ ^MINGW.*$ ]]; then
      [[ "${dotfile}" =~ ^.*\/windows\/.* ]] && continue
    fi

    \cp -rv "${dotfile}" "${HOME}"
  done

  rm -rf "${DEST}"
}

main "$@"

#!/bin/bash -eu

function main() {
  local src="https://github.com/rinatz/dotfiles/archive/master.tar.gz"

  local dest
  dest=$(mktemp -d /tmp/dotfiles-XXXXXX)

  curl -fsSL "${src}" | tar zxv -C "${dest}" --strip-components 1

  local dotfiles
  dotfiles=$(find "${dest}" -name ".*")

  for dotfile in ${dotfiles[@]}; do
    [[ "${dotfile}" == "${dest}" ]] && continue
    [[ "${dotfile}" == "${dest}/.git" ]] && continue

    if [[ ! $(uname) =~ ^MINGW.*$ ]]; then
      [[ "${dotfile}" =~ ^.*\/windows\/.* ]] && continue
    fi

    \cp -rv "${dotfile}" "${HOME}"
  done
}

main "$@"

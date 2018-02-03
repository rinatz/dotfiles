#!/bin/bash -eu

function main() {
  local url="https://github.com/rinatz/dotfiles/archive/master.tar.gz"

  local temp
  temp=$(mktemp -d /tmp/dotfiles-XXXXXX)

  curl -fsSL "${url}" | tar zxv -C "${temp}" --strip-components 1

  local dotfiles
  dotfiles=$(find "${temp}" -name ".*")

  for dotfile in ${dotfiles[@]}; do
    [[ "${dotfile}" == "${temp}" ]] && continue
    [[ "${dotfile}" == "${temp}/.git" ]] && continue

    if [[ ! $(uname) =~ ^MINGW.*$ ]]; then
      [[ "${dotfile}" =~ ^.*\/windows\/.* ]] && continue
    fi

    \cp -rv "${dotfile}" "${HOME}"
  done

  if [[ $(uname) =~ ^MINGW.*$ ]]; then
    \cp -rv "${HOME}/.config/Code" "${APPDATA}"
    \rm -rf "${HOME}/.config/Code"
  fi

  \rm -rf "${temp}"
}

main "$@"

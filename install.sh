#!/bin/bash -eu

function os_name() {
  if [[ $(uname) =~ ^MINGW.*$ ]]; then
    echo "Windows"
  elif [[ $(uname) =~ Darwin ]]; then
    echo "macOS"
  elif [[ $(uname) =~ Linux ]]; then
    echo "Linux"
  else
    echo ""
  fi
}

function vscode_location() {
  if [[ $(os_name) = "Windows" ]]; then
    echo "${APPDATA}/Code/User"
  elif [[ $(os_name) = "macOS" ]]; then
    echo "${HOME}/Library/Application\ Support/Code/User"
  elif [[ $(os_name) = "Linux" ]]; then
    echo "${HOME}/.config/Code/User"
  else
    echo ""
  fi
}

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

  mkdir -p $(vscode_location)
  \cp -rv vscode/settings.json $(vscode_location)

  \rm -rf "${temp}"
}

main "$@"

#!/bin/bash -eu

function platform() {
  local system
  system=$(uname)

  case "${system}" in
    MINGW*) echo "Windows" ;;
    MSYS*) echo "Windows" ;;
    CYGWIN*) echo "Windows" ;;
    Darwin*) echo "macOS" ;;
    Linux*) echo "Linux" ;;
    *) echo "" ;;
  esac
}

function vscode_location() {
  case "$(platform)" in
    Windows) echo "${APPDATA}/Code/User" ;;
    macOS) echo "${HOME}/Library/Application\ Support/Code/User" ;;
    Linux) echo "${HOME}/.config/Code/User" ;;
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

  for dotfile in ${dotfiles[@]}; do
    if [[ $(platform) != "Windows" ]]; then
      [[ "${dotfile}" =~ ^.*\/windows\/.* ]] && continue
    fi

    \cp -rv "${dotfile}" "${HOME}"
  done

  mkdir -p $(vscode_location)
  \cp -rv "${temp}/vscode/settings.json" $(vscode_location)

  \rm -rf "${temp}"
}

main "$@"

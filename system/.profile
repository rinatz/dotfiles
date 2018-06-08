[[ -f "${HOME}/.bashrc" ]] && . "${HOME}/.bashrc"

# Keyboard input sometimes is blocked when IBus is active
# https://youtrack.jetbrains.com/issue/IDEA-78860
export IBUS_ENABLE_SYNC_MODE=1

#
# USER
#
if [[ -z "${USER}" && -n "${USERNAME}" ]]; then
    export USER="${USERNAME}"
fi

#
# anyenv
#
export PATH="${HOME}/.anyenv/bin:${PATH}"
if type anyenv &> /dev/null; then
    eval "$(anyenv init -)"
fi

#
# ubuntu-make
#
export PATH="${HOME}/.local/share/umake/bin:${PATH}"

function __update_macvim() {
    if [[ "$(uname -a)" =~ Darwin ]] && [[ -n "(which mvim)" ]]; then
        local VIM_LOCATION="$(brew --prefix)/bin"
        local MACVIM_HOME="$(which mvim | xargs readlink | xargs dirname)"

        cd "${VIM_LOCATION}"
        cd "${MACVIM_HOME}"

        local REAL_MACVIM_HOME="$(readlink ./mvim | xargs dirname)"

        cd "${REAL_MACVIM_HOME}"
        local VIM="${PWD}/vim"
        local VIMDIFF="${PWD}/vimdiff"

        cd "${VIM_LOCATION}"

        rm -rf vim vimdiff
        ln -s $VIM vim
        ln -s $VIMDIFF vimdiff


        cd ~/
        which vim | xargs readlink
        which vimdiff | xargs readlink
    fi
}

__update_macvim

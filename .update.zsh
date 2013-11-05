#
# Dotfiles automatic update by Joakim Andersson
#
# This is run automatically by ~/.zshrc once per $update_limit days or manually
# by running update_dotfiles.
# Some minor inspiration from oh-my-zsh's upgrade code.
#

zshrc=$HOME/.zshrc
repo=${zshrc:A:h:h}
timestamp_file=$repo/.update_timestamp
update_limit=7
branch=origin/master
estatus=0

__log_print() {
    local pre="[update_dotfiles] " post
    if [[ $TERM != dumb ]]; then
        pre="\e[01;34m$pre\e[00;${1}m"
        post="\e[00m"
    fi

    shift
    for x in $@; echo $pre$x$post
}
_log_info() {
    __log_print 32 $@
}
_log_warn() {
    __log_print 33 $@ >&2
}
_error() {
    __log_print 31 $@ >&2
    exit 1
}

_current_day() {
    echo $(($(date +%s) / 60 / 60 / 24))
}
_update_timestamp() {
    local t=$1
    [[ -z $t ]] && t=$(_current_day)
    [[ -f $timestamp_file ]] || touch $timestamp_file
    echo "timestamp=$t" >| $timestamp_file
}

if [[ $1 == defer ]]; then
    _update_timestamp 0
    exit 0
fi
if [[ $1 == auto ]]; then
    # Running automatically from ~/.zshrc.
    if [[ -f $timestamp_file ]]; then
        source $timestamp_file
        if [[ -z $timestamp ]]; then
            _update_timestamp
            exit 1
        fi
    else
        _update_timestamp
        exit 1
    fi

    [[ $(($(_current_day) - $timestamp)) -lt $update_limit ]] && exit 1

    estatus=1
fi

cd $repo

_log_info "Checking for updates..."
git fetch -q || \
        _error "Fetching from git server failed."

commits_behind=$( (git log --oneline HEAD..$branch | wc -l) || \
        _error "Checking number of commits behind failed." )

if [[ $commits_behind -gt 0 ]]; then
    _log_info "Found $commits_behind new commits. Updating..."
    pushd $repo > /dev/null || \
            _error "Failed to enter '$repo'."
    git rebase -q $branch || \
            _error "Updating failed." "Manual merge in '$repo' needed."
    popd > /dev/null || \
            _error "Failed to return from '$repo'."
    _log_info "Update successful."
    estatus=0
fi

commits_ahead=$( (git log --oneline $branch..HEAD | wc -l) || \
        _error "Checking number of commits ahead failed." )
git_status=$( (git status --porcelain | wc -l) || \
        _error "Checking git file status." )

[[ $commits_ahead -gt 0 || $git_status -gt 0 ]] && \
    _log_warn "Found $commits_ahead unpushed commit(s) and $git_status uncommitted file(s)."

_update_timestamp
exit $estatus

#
# Dotfiles automatic update by Joakim Tufvegren
#
# This is run automatically by ~/.zshrc once per $update_limit days or manually
# by running update_dotfiles.
# Some minor inspiration from oh-my-zsh's upgrade code.
#
setopt nonomatch

zshrc=$HOME/.zshrc
repo=${zshrc:A:h:h}
timestamp_file=$repo/.update_timestamp
update_limit=14
branch=origin/master
exit_status=0

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
_log_error() {
    __log_print 31 $@ >&2
}
_fatal() {
    _log_error $@
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
    _log_info "Deferring update check for next ZSH launch."
    _update_timestamp 0
    exit 0

elif [[ $1 == auto ]]; then
    # Running automatically from ~/.zshrc.
    if [[ -f $timestamp_file ]]; then
        source $timestamp_file
        if [[ -z $timestamp ]]; then
            _update_timestamp
            exit 0
        fi
    else
        _update_timestamp
        exit 0
    fi

    [[ $(($(_current_day) - $timestamp)) -lt $update_limit ]] && exit 0

elif [[ $# -gt 0 ]]; then
    _fatal "Unknown argument '$1'"
fi

if [[ ! -x =git ]]; then
    _update_timestamp
    _fatal "Can't upgrade, no git found."
fi
if [[ ! -d $repo/.git ]]; then
    _update_timestamp
    _fatal "Can't upgrade, '$repo' is not a git repo."
fi

cd $repo

commits_ahead=$( (git log --oneline $branch..HEAD | wc -l) || \
        _fatal "Checking number of commits ahead failed." )
[[ $commits_ahead -gt 0 ]] && \
    _log_warn "Found $commits_ahead unpushed commit(s)."

uncommitted_files=$( (git status --porcelain | wc -l) || \
        _fatal "Checking git file status failed." )
[[ $uncommitted_files -gt 0 ]] && \
    _log_warn "Found $uncommitted_files uncommitted file(s)."

_log_info "Checking for updates..."
git fetch -q || \
        _fatal "Fetching from git server failed."

commits_behind=$( (git log --oneline HEAD..$branch | wc -l) || \
        _fatal "Checking number of commits behind failed." )

if [[ $commits_behind -gt 0 ]]; then
    file_list_pre=$(ls config)

    _log_info "Found $commits_behind new commits. Updating..."
    git rebase -q $branch || \
            _fatal "Updating failed." "Manual merge in '$repo' needed."
    _log_info "Update successful."

    if [[ $file_list_pre != $(ls config) ]]; then
        file_list_diff=$(ls config | diff --unchanged-line-format= \
                --new-line-format='+ .%L' \
                --old-line-format='- .%L' \
                =(echo $file_list_pre) -)
        # Separate and split lines into array
        file_list_new=(${(f)"$(echo $file_list_diff | grep '^+')"})
        file_list_rm=(${(f)"$(echo $file_list_diff | grep '^-')"})
        if [[ -n $file_list_new ]]; then
            _log_warn "New files:" $file_list_new
            _log_info "Re-running install script..."
            $repo/install || _log_error "Install script failed!"
        fi
        if [[ -n $file_list_rm ]]; then
             _log_warn "Removed files:" $file_list_rm \
                    "You may want to remove these symlinks."
        fi
    fi

    # Signal to reload zsh config
    exit_status=0x8
fi

_update_timestamp

[[ $exit_status -eq 0x8 ]] && _log_info "Reloading ZSH config..."
exit $exit_status

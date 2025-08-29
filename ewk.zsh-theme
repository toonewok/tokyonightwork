#based on the gnzh theme which is
# based on bira theme
# and now heavily based off refined theme with some help from chatgpt

setopt prompt_subst
return_code="%(?..%F{red}%? ↵%f)"
current_dir="%F{blue}%~%f"

#attempting to load/enable vcs(v.ersion c.ontrol s.oftware)
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable hg bzr git


#These define indicators for Git when there are:
#Unstaged changes: !
#Staged changes: +
zstyle ':vcs_info:*:*' unstagedstr '!'
zstyle ':vcs_info:*:*' stagedstr '+'


#This is the main format for displaying Git info. It defines three lines:
#$FX[bold]%r$FX[no-bold]/%S
#   %r – Root directory of the repository.
#   %S – Subdirectory relative to root (empty if in root).
#   $FX[bold] and $FX[no-bold] toggle formatting (text effects).
#   %s:%b
#   %s – VCS name (git)
#   %b – Branch name
#   %%u%c
#   %u – Staged/untracked/modified flags (e.g., + or !)
#   %c – "Unknown" (optional context info; not typically used with Git)
zstyle ':vcs_info:*:*' formats "$FX[bold]%r$FX[no-bold]/%S" "%s:%b" "%%u%c"


#This fast function checks if:
#You're in a Git repo
#There are uncommitted changes (working tree is dirty)
#If dirty, it outputs a *. This is used later in the prompt.
git_dirty() {
    command git rev-parse --is-inside-work-tree &>/dev/null || return
    command git diff --quiet --ignore-submodules HEAD &>/dev/null
    [ $? -eq 1 ] && echo "%F{yellow}*%f"
}


#This builds the actual Git info display using the three lines set in formats:
#${vcs_info_msg_0_} → root path + relative path
#${vcs_info_msg_1_} → VCS name and branch
#${vcs_info_msg_2_} → VCS flags
#`git_dirty` adds * if repo is dirty
#The %F{color} and %f are used to apply color:
#Blue for path
#Gray (color 8) for Git info
#Reset (%f) at the end

#preexec runs before a command, storing the time.
#precmd runs before the prompt:
#Runs vcs_info
#Prints Git info and execution time above the prompt
repo_information() {
    # Only show repo info if vcs_info is active
    [[ -n $vcs_info_msg_0_ ]] && echo "%F{blue}${vcs_info_msg_0_%%/.} %F{8}$vcs_info_msg_1_$(git_dirty) $vcs_info_msg_2_%f"
}

precmd() {

    local last_status=$?

    setopt localoptions nopromptsubst
    vcs_info
    local git_info="$(repo_information)"
    if [[ -n $git_info ]]; then
        print -P "\n$git_info"
    else
        print -P "\n$current_dir"
    fi

    #%B%F{red}>%f%F{yellow}>%f%F{green}>%f%b 
    # Dynamically color PR_PROMPT based on last command's exit code
    if [[ $last_status -eq 0 ]]; then
        PR_PROMPT='%B%F{red}>%f%F{yellow}>%f%F{green}>%f%b'
    else
        PR_PROMPT='%B%F{red}>>>%f%b'
    fi

    PROMPT="$PR_PROMPT "
}


() {



# Check if we are on SSH or not
 
RPROMPT="${return_code}"

}

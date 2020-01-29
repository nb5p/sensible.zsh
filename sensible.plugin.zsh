bindkey -e

bindkey '^r' history-incremental-search-backward
bindkey ' ' magic-space

# Make sure that the terminal is in application mode when zle is active
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init() {
        echoti smkx
    }
    function zle-line-finish() {
        echoti rmkx
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

# [PageUp] - Up a line of history
if [[ "${terminfo[kpp]}" != "" ]]; then
    bindkey "${terminfo[kpp]}" up-line-or-history
fi
# [PageDown] - Down a line of history
if [[ "${terminfo[knp]}" != "" ]]; then
    bindkey "${terminfo[knp]}" down-line-or-history
fi

# [Ctrl-RightArrow] - Move forward one word
bindkey '^[[1;5C' forward-word
# [Ctrl-LeftArrow] - Move backward one word
bindkey '^[[1;5D' backward-word

if [[ "${terminfo[khome]}" != "" ]]; then
    bindkey "${terminfo[khome]}" beginning-of-line
fi
if [[ "${terminfo[kend]}" != "" ]]; then
    bindkey "${terminfo[kend]}"  end-of-line
fi

# [Shift-Tab] - Move through the completion menu backwards
if [[ "${terminfo[kcbt]}" != "" ]]; then
    bindkey "${terminfo[kcbt]}" reverse-menu-complete
fi

# [Backspace] - Delete backward
bindkey '^?' backward-delete-char
# [Delete] - Delete forward
if [[ "${terminfo[kdch1]}" != "" ]]; then
    bindkey "${terminfo[kdch1]}" delete-char
else
    bindkey "^[[3~" delete-char
    bindkey "^[3;5~" delete-char
    bindkey "\e[3~" delete-char
fi

# [^X^E] - Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# Paste without highlight
zle_highlight+=(paste:none)
zstyle ':urlglobber' url-other-schema
DISABLE_MAGIC_FUNCTIONS=true

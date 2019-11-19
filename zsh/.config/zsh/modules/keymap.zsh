#
# Keymap
#

# Return if requirements are not found.
if [[ "$TERM" == 'dumb' ]]; then
  return 1
fi

# Use human-friendly identifiers.
zmodload -F zsh/terminfo +b:echoti +p:terminfo
typeset -gA key
key=(
  'Control'      '\C-'
  'ControlLeft'  '\e[1;5D \e[5D \e\e[D \eOd \eOD'
  'ControlRight' '\e[1;5C \e[5C \e\e[C \eOc \eOC'
  'Escape'       '\e'
  'Meta'         '\M-'
  'Backspace'    ${terminfo[kbs]}
  'BackTab'      ${terminfo[kcbt]}
  'Left'         ${terminfo[kcub1]}
  'Down'         ${terminfo[kcud1]}
  'Right'        ${terminfo[kcuf1]}
  'Up'           ${terminfo[kcuu1]}
  'Delete'       ${terminfo[kdch1]}
  'End'          ${terminfo[kend]}
  'F1'           ${terminfo[kf1]}
  'F2'           ${terminfo[kf2]}
  'F3'           ${terminfo[kf3]}
  'F4'           ${terminfo[kf4]}
  'F5'           ${terminfo[kf5]}
  'F6'           ${terminfo[kf6]}
  'F7'           ${terminfo[kf7]}
  'F8'           ${terminfo[kf8]}
  'F9'           ${terminfo[kf9]}
  'F10'          ${terminfo[kf10]}
  'F11'          ${terminfo[kf11]}
  'F12'          ${terminfo[kf12]}
  'Home'         ${terminfo[khome]}
  'Insert'       ${terminfo[kich1]}
  'PageDown'     ${terminfo[knp]}
  'PageUp'       ${terminfo[kpp]}
)

# Use Emacs key bindings.
bindkey -e

[[ -n "${key[Up]}"        ]] && bindkey "${key[Up]}"        up-line-or-beginning-search
[[ -n "${key[Down]}"      ]] && bindkey "${key[Down]}"      down-line-or-beginning-search
[[ -n "${key[Home]}"      ]] && bindkey "${key[Home]}"      beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey "${key[End]}"       end-of-line
[[ -n "${key[PageUp]}"    ]] && bindkey "${key[PageUp]}"    up-line-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey "${key[PageDown]}"  down-line-or-history
[[ -n "${key[BackTab]}"   ]] && bindkey "${key[BackTab]}"   reverse-menu-complete
[[ -n "${key[Backspace]}" ]] && bindkey "${key[Backspace]}" backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey "${key[Delete]}"    delete-char

bindkey ' '       magic-space
bindkey '.'       rationalise-dot
bindkey '\ew'     kill-region
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^[d'     fuzzy-search-commands
bindkey '^X^B'    fuzzy-multi-ghq-repository
bindkey '^X^E'    edit-command-line
bindkey '^X^G'    fuzzy-cd-ghq-repository
bindkey '^Xs'     insert-sudo

# Put into application mode and validate ${terminfo}.
zle-line-init() {
  (( ${+terminfo[smkx]} )) && echoti smkx
}
zle-line-finish() {
  (( ${+terminfo[rmkx]} )) && echoti rmkx
}
zle -N zle-line-init
zle -N zle-line-finish

#
# Theme
#

typeset -g ZSH_THEME
declare -a lines needle
if [[ -e $LOCALRC ]]; then
  lines=( "${(@f)"$(<$LOCALRC)"}" )
fi
needle=( ${${(M)lines:#ZSH_THEME=*}[1]} )
local theme_=${${(s:=:)"${(Q)needle}"}[2]}

ZSH_THEME="${theme_:-p9k}"

case "$TERM_PROGRAM" in
  'python2'|'terminator'|'iTerm.app'|'gnome-terminal'|'tmux'|'tilix')
    ZSH_THEME=${~ZSH_THEME}
    ;;
  'sshd')
    ZSH_THEME=${~ZSH_THEME}
    ;;
  'login')
    # This is common for linux vttys, so no symbols pls
    ZSH_THEME="fishy"
    ;;
  'zsh'|*)
    # Try to keep the same theme if it's already set.
    if [[ -z "$ZSH_THEME" ]]; then
      ZSH_THEME="fishy"
    fi
    ;;
esac
export ZSH_THEME=${~ZSH_THEME}

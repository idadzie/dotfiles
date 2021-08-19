#
# zshrc
#

foreach module (
  paths.zsh
  term.zsh
  theme.zsh
  keymap.zsh
  widgets.zsh
  env.zsh
  options.zsh
  completion.zsh
  history.zsh
  window.zsh
  zinit.zsh
  aliases.zsh
) {
  source "$ZDOTDIR/modules/$module"
}

# Local plugins, completions, functions, etc.
[[ -e $LOCALRC ]] && . $LOCALRC

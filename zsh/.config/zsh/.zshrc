#
# zshrc
#

foreach piece (
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
  zplugin.zsh
  aliases.zsh
) {
  source "$ZDOTDIR/modules/$piece"
}

# Local plugins, completions, functions, etc.
[[ -e $LOCALRC ]] && . $LOCALRC

#
# zshrc
#

foreach module (
  aliases.zsh
) {
  source "$ZDOTDIR/modules/$module"
}

# Local plugins, completions, functions, etc.
[[ -e $LOCALRC ]] && . $LOCALRC

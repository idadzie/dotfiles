#
# Widgets
#

# Return if requirements are not found.
if [[ "$TERM" == 'dumb' ]]; then
  return 1
fi

foreach widget (
  $ZDOTDIR/widgets/**/*(N:t)
  down-line-or-beginning-search
  edit-command-line
  up-line-or-beginning-search
) {
  zle -N $widget
}

zle -N self-insert url-quote-magic
if is-at-least 5.1; then
  zle -N bracketed-paste bracketed-paste-magic
fi

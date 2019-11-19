#
# Paths
#

# Ensure uniqueness.
typeset -gU path fpath cdpath

# Add custom functions to FPATH.
fpath+=( $ZDOTDIR/functions(N-/) $ZDOTDIR/widgets(N-/) )

autoload -Uz $ZDOTDIR/functions/**/*(N:t) \
  $ZDOTDIR/widgets/**/*(N:t) \
  bracketed-paste-magic \
  cdr \
  colors \
  down-line-or-beginning-search \
  edit-command-line \
  history-search-end \
  is-at-least \
  modify-current-argument \
  promptinit \
  run-help \
  smart-insert-last-word \
  terminfo \
  up-line-or-beginning-search \
  url-quote-magic \
  vcs_info \
  zcalc \
  zmv

promptinit
colors

if isosx && [[ -s /etc/paths ]]; then
  local etcpaths
  declare -a etcpaths; etcpaths=( ${(f)"$(</etc/paths)"} )
  for pathitem in ${etcpaths} ; do
    if [[ ! ${path[(r)$pathitem]} == "$pathitem" ]]; then
      path+=($pathitem)
    fi
  done
fi

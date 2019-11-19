#
# History
#

# Sets the location of the history file.
HISTFILE=$XDG_DATA_HOME/zsh/history

# Limit of history entries.
HISTSIZE=1000000
SAVEHIST=$HISTSIZE
HISTORY_IGNORE='(clear|c|pwd|exit|* —help|[bf]g *|l[alsh]#( *)#|less *)'

# Size of asking history.
LISTMAX=50

# Do not add in root.
if [[ "$UID" -eq 0 ]]; then
  unset HISTFILE
  export SAVEHIST=0
fi

#
# Aliases
#

alias -- -='cd -'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

alias md='mkdir -p'
alias rd=rmdir
alias d='dirs -v | head -10'

alias '?'='pwd'

# List directory contents.
if (( $+commands[exa] )); then
  alias ls='exa --group-directories-first --git'
  alias l='ls -l'
  alias ll='ls -lah'
  alias la='ls -lah'
  alias lx='ls -l --sort extension'
  alias lt='ls -T'
else
  alias ls='ls -F --color --group-directories-first'
  alias l='ls -lh'
  alias ll='ls -lAh'
  alias la='ls -lah'
  alias lx='ls -lXB'
  (( $+commands[tree] )) && alias lt='tree'
fi

# Push and pop directories on directory stack.
alias pu='pushd'
alias po='popd'

alias _='sudo'
alias chmox='chmod +x'

# Pretty print the path.
alias path='echo -e ${PATH//:/\\n}'

# Conditional aliases.
(( $+commands[bat] )) && alias cat='bat'
(( $+commands[nvim] )) && alias vim='nvim'
(( $+commands[python3] )) && alias server='python3 -m http.server 80'

if (( $+commands[bpytop] )); then
  alias top='bpytop'
elif (( $+commands[htop] )); then
  alias top='htop'
fi

# Convenience when pasting shell snippets.
alias '$='

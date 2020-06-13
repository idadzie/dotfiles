#
# Environment variables
#

# Term
export TERM='xterm-256color'

# Editor
export EDITOR='vim'

# Pager
export PAGER='less'

# less status line.
export LESS='-R -f -X -i -P ?f%f:(stdin). ?lb%lb?L/%L.. [?eEOF:?pb%pb\%..]'
export LESSCHARSET='utf-8'

# Poetry
# export PATH="$HOME/.poetry/bin:$PATH"

# Local binaries
export PATH="$HOME/.local/bin:$PATH"

# Yarn
if (( $+commands[yarn] )); then
  export PATH="$PATH:$HOME/.yarn/bin"
fi

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# FZF
typeset -AU __FZF
if (( $+commands[fd] )); then
  __FZF[CMD]='fd --hidden --no-ignore-vcs --exclude ".git/*" --exclude "node_modules/*"'
  __FZF[DEFAULT]="${__FZF[CMD]} --type f"
  __FZF[ALT_C]="${__FZF[CMD]} --type d ."
elif (( $+commands[rg] )); then
  __FZF[CMD]='rg --no-messages --no-ignore-vcs'
  __FZF[DEFAULT]="${__FZF[CMD]} --files"
else
  __FZF[DEFAULT]='git ls-tree -r --name-only HEAD || find .'
fi

export FZF_DEFAULT_COMMAND="${__FZF[DEFAULT]}"
export FZF_CTRL_T_COMMAND="${__FZF[CMD]}"
export FZF_ALT_C_COMMAND="${__FZF[ALT_C]}"
export FZF_DEFAULT_OPTS='--min-height 30 --height 50% --reverse --tabstop 2 --multi --margin 0,3,3,3'
export FZF_CTRL_T_OPTS='
--preview-window right:50%
--preview "(bat --style=numbers,changes --wrap never --color always {} || highlight -O ansi -l {} || cat {} || tree -C {}) 2> /dev/null | head -200"
--bind "?:toggle-preview"
'

# Set clipboard command.
if (( $+commands[xclip] )); then
  __FZF[CPCMD]='xclip -selection clipboard'
elif (( $+commands[xsel] )); then
  __FZF[CPCMD]='xsel --clipboard --input'
elif [[ "$OSTYPE" == darwin* ]]; then
  __FZF[CPCMD]='pbcopy'
fi

export FZF_CTRL_R_OPTS="
--preview 'echo {}'
--preview-window down:3:hidden:wrap
--bind '?:toggle-preview'
--bind 'ctrl-y:execute-silent(echo -n {2..} | ${__FZF[CPCMD]})+abort'
--header 'Press CTRL-Y to copy command into clipboard'
--border
"

export FZF_ALT_C_OPTS="
--preview 'tree -C {} 2> /dev/null | head -200'
--bind='alt-w:toggle-preview-wrap'
--bind='alt-k:preview-up,alt-p:preview-up'
--bind='alt-j:preview-down,alt-n:preview-down'
"

# LSCOLORS
export LSCOLORS='Gxfxcxdxbxegedabagacad'

# LS_COLORS
if [[ -z "$LS_COLORS" ]]; then
  (( $+commands[dircolors] )) && eval "$(dircolors -b)"
fi

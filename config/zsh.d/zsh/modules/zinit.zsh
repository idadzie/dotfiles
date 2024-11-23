#
# Zinit, plugins & snippets
#

typeset -A ZINIT
ZINIT_HOME=$XDG_DATA_HOME/zinit
ZINIT[HOME_DIR]=$ZINIT_HOME
ZINIT[ZCOMPDUMP_PATH]=$XDG_CACHE_HOME/zsh/compdump

if [[ ! -f $ZINIT_HOME/bin/zinit.zsh ]]; then
  git clone https://github.com/zdharma-continuum/zinit.git $ZINIT_HOME/bin
  zcompile $ZINIT_HOME/bin/zinit.zsh
fi

source $ZINIT_HOME/bin/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

autoload -Uz compinit
compinit -u -d "$XDG_CACHE_HOME/zsh/compdump"

# Zinit extensions
zinit light-mode for zdharma-continuum/zinit-annex-bin-gem-node

# Commands
zinit light rupa/z

zinit ice as'program' pick"$ZPFX/bin/git-*" \
  make"PREFIX=$ZPFX" src'etc/git-extras-completion.zsh'
zinit light tj/git-extras

zinit as'null' wait lucid light-mode for \
  sbin'bin/git-dsf;bin/diff-so-fancy' zdharma-continuum/zsh-diff-so-fancy \
  sbin'emojify;fuzzy-emoji' src'fuzzy-emoji-zle.zsh' wfxr/emoji-cli

zinit as'null' from'gh-r' lucid for \
  mv'countdown* -> countdown' ver'v1.0.0' sbin antonmedv/countdown

zinit from'gh-r' lucid for \
  mv'ghq* -> ghq' sbin'ghq/ghq' x-motemen/ghq \
  mv'pastel* -> pastel' sbin'pastel/pastel' @sharkdp/pastel

zinit wait lucid for \
  wfxr/forgit

# Plugins
zinit light MichaelAquilina/zsh-you-should-use

zinit lucid for \
  OMZL::git.zsh \
  OMZP::git \
  OMZP::extract \
  as'completion' OMZP::extract/_extract \
  OMZP::encode64 \
  OMZT::fishy


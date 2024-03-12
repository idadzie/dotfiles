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

# Zinit does not provide a straight forward way to
# install accompanying man pages. Hence the mess/"genius" below.
# At least this way I won't forget to install the completion
# files, have to go back to the repo and manually add to FPATH
# on a new PC.
# zinit from'gh-r' lucid for \
#   sbin'bin/hub' \
#   atclone'mv hub*/* .;
#     rm -rf *~*backup(/^F) (#i)install;
#     mv etc/hub.zsh* etc/_hub;
#     cp share/man/*/*.1 $ZPFX/share/man/man1' \
#   atpull'%atclone' @github/hub

zinit from'gh-r' lucid for \
  bpick'*amd64.tar.gz' sbin'**/gh' \
  atclone'cp -vf **/*.1 $ZPFX/share/man/man1' atpull'%atclone' @cli/cli

zinit as'null' wait lucid light-mode for \
  sbin'bin/git-dsf;bin/diff-so-fancy' zdharma-continuum/zsh-diff-so-fancy \
  sbin'emojify;fuzzy-emoji' src'fuzzy-emoji-zle.zsh' wfxr/emoji-cli

zinit as'null' from'gh-r' lucid for \
  mv'exa* -> exa' sbin'**/exa' ogham/exa \
  mv'jq* -> jq' sbin jqlang/jq \
  mv'shfmt* -> shfmt' sbin @mvdan/sh \
  mv'countdown* -> countdown' ver'v1.0.0' sbin antonmedv/countdown

zi for \
    from'gh-r' \
    sbin'fzf'  \
  junegunn/fzf

zi for \
    as"program" \
    atclone'./direnv hook zsh > zhook.zsh' \
    from"gh-r" \
    light-mode \
    mv"direnv* -> direnv" \
    src'zhook.zsh' \
  direnv/direnv

zinit from'gh-r' lucid for \
  mv'ghq* -> ghq' sbin'ghq/ghq' x-motemen/ghq \
  mv'pastel* -> pastel' sbin'pastel/pastel' @sharkdp/pastel \
  mv'fd* -> fd' sbin'fd/fd' \
    atclone'cp **/*.1 $ZPFX/share/man/man1' atpull'%atclone' @sharkdp/fd \
  mv'bat* -> bat' sbin'bat/bat' \
    atclone'cp **/*.1 $ZPFX/share/man/man1' atpull'%atclone' @sharkdp/bat

zinit wait lucid for \
  wfxr/forgit \
  sbin'bin/anyenv' \
    atload'export ANYENV_ROOT=$XDG_DATA_HOME/anyenv; eval "$(anyenv init -)"' anyenv/anyenv

zinit as'null' wait lucid light-mode for \
  id-as'sdkman' run-atpull \
  atclone"wget https://get.sdkman.io/\?rcupdate=false -O scr.sh;
    SDKMAN_DIR=$XDG_DATA_HOME/sdkman bash scr.sh" \
  atpull"SDKMAN_DIR=$XDG_DATA_HOME/sdkman sdk selfupdate" \
  atinit"export SDKMAN_DIR=$XDG_DATA_HOME/sdkman;
    source $XDG_DATA_HOME/sdkman/bin/sdkman-init.sh" \
  zdharma-continuum/null

# zinit wait lucid sbin'bin/anyenv' \
#   atload'export ANYENV_ROOT=$HOME/.anyenv; eval "$(anyenv init -)"'
# zinit light anyenv/anyenv

# Plugins
zinit light MichaelAquilina/zsh-you-should-use

# local omz_plugins
# omz_plugins=(
#   lib/git.zsh
#   plugins/git/git.plugin.zsh
#   plugins/extract/extract.plugin.zsh
#   plugins/encode64/encode64.plugin.zsh
#   themes/fishy.zsh-theme
# )
# zinit ice pick'dev/null' nocompletions blockf \
#   multisrc"${omz_plugins}"
# zinit light robbyrussell/oh-my-zsh

zinit lucid for \
  OMZL::git.zsh \
  OMZP::git \
  OMZP::extract \
  as'completion' OMZP::extract/_extract \
  OMZP::encode64 \
  OMZT::fishy

# Snippets
zinit ice wait lucid id-as'fzf-keybindings'
zinit snippet 'https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh'

zinit ice wait lucid id-as'fzf-completion'
zinit snippet 'https://github.com/junegunn/fzf/blob/master/shell/completion.zsh'

# Completion
zinit ice wait'1' lucid as'completion' \
  id-as'beet-completion' mv'beet-completion -> _beet'
zinit snippet 'https://github.com/beetbox/beets/blob/master/extra/_beet'

# zinit ice wait'1' lucid as'completion' \
#   id-as'docker-compose-completion' mv'docker-compose-completion -> _docker-compose'
# zinit snippet 'https://github.com/docker/compose/blob/master/contrib/completion/zsh/_docker-compose'

zinit ice wait'1' lucid as'completion' has'exiftool' \
  id-as'exiftool-completion' mv'exiftool-completion -> _exiftool'
zinit snippet 'https://github.com/HeLiBloks/exiftool-zsh-completion/blob/master/_exiftool'

zinit wait'1' as'completion' id-as'gh-completion' lucid for \
  atclone'gh completion -s zsh > _gh' atpull'%atclone' zdharma-continuum/null

# Theme
if [[ "$ZSH_THEME" == "p10k" ]]; then
  zinit ice atload'[[ -f $ZDOTDIR/.p10k.zsh ]] && source $ZDOTDIR/.p10k.zsh || true; _p9k_precmd' depth'1' \
    lucid nocd
  zinit load romkatv/powerlevel10k
fi

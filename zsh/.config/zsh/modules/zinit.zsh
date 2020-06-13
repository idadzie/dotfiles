#
# Zinit, plugins & snippets
#

typeset -A ZINIT
ZINIT_HOME=$HOME/.local/zinit
ZINIT[HOME_DIR]=$ZINIT_HOME
ZINIT[ZCOMPDUMP_PATH]=$XDG_CACHE_HOME/zsh/compdump

if [[ ! -f $ZINIT_HOME/bin/zinit.zsh ]]; then
  git clone https://github.com/zdharma/zinit.git $ZINIT_HOME/bin
  zcompile $ZINIT_HOME/bin/zinit.zsh
fi

source $ZINIT_HOME/bin/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

autoload -Uz compinit
compinit -u -d "$XDG_CACHE_HOME/zsh/compdump"

# Zinit extensions
zinit light-mode for zinit-zsh/z-a-bin-gem-node

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
zinit from'gh-r' lucid for \
  sbin'bin/hub' \
  atclone'mv hub*/* .;
    rm -rf *~*backup(/^F) (#i)install;
    mv etc/hub.zsh* etc/_hub;
    cp share/man/*/*.1 $ZPFX/share/man/man1' \
  atpull'%atclone' @github/hub

zinit as'null' wait lucid light-mode for \
  sbin"bin/git-dsf;bin/diff-so-fancy" zdharma/zsh-diff-so-fancy \
  sbin'emojify;fuzzy-emoji' src'fuzzy-emoji-zle.zsh' wfxr/emoji-cli

zinit as'null' from'gh-r' lucid for \
  mv"exa* -> exa" sbin ogham/exa \
  mv'docker* -> docker-compose' sbin docker/compose \
  mv'jq* -> jq' sbin stedolan/jq \
  mv'shfmt* -> shfmt' sbin @mvdan/sh \
  mv'countdown* -> countdown' sbin antonmedv/countdown \
  mv'subify* -> subify' sbin matcornic/subify \
  bpick'*amd64.tgz' sbin cjbassi/gotop \
  sbin junegunn/fzf-bin

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
    atload'export ANYENV_ROOT=$HOME/.local/anyenv; eval "$(anyenv init -)"' anyenv/anyenv

# zinit wait lucid sbin'bin/anyenv' \
#   atload'export ANYENV_ROOT=$HOME/.anyenv; eval "$(anyenv init -)"'
# zinit light anyenv/anyenv

# Plugins
zinit light MichaelAquilina/zsh-you-should-use

local omz_plugins
omz_plugins=(
  lib/git.zsh
  plugins/git/git.plugin.zsh
  plugins/extract/extract.plugin.zsh
  plugins/encode64/encode64.plugin.zsh
  plugins/magic-enter/magic-enter.plugin.zsh
  themes/fishy.zsh-theme
)
zinit ice pick'dev/null' nocompletions blockf \
  multisrc"${omz_plugins}"
zinit light robbyrussell/oh-my-zsh

# Snippets
zinit ice wait lucid id-as'fzf-keybindings'
zinit snippet 'https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh'

zinit ice wait lucid id-as'fzf-completion'
zinit snippet 'https://github.com/junegunn/fzf/blob/master/shell/completion.zsh'

# Completion
zinit ice wait'1' lucid as'completion' \
  id-as'beet-completion' mv'beet-completion -> _beet'
zinit snippet 'https://github.com/beetbox/beets/blob/master/extra/_beet'

zinit ice wait'1' lucid as'completion' \
  id-as'docker-compose-completion' mv'docker-compose-completion -> _docker-compose'
zinit snippet 'https://github.com/docker/compose/blob/master/contrib/completion/zsh/_docker-compose'

# Themes
if [[ "$ZSH_THEME" == "p9k" ]]; then

  POWERLEVEL9K_MODE='nerdfont-complete'
  POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
  POWERLEVEL9K_SHORTEN_STRATEGY='truncate_middle'
  POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=''
  POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=''
  POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(background_jobs root_indicator ssh dir vcs)
  POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status dir_writable ram rbenv pyenv)

  DEFAULT_USER=${USER}
  POWERLEVEL9K_DIR_HOME_BACKGROUND='033'
  POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='033'
  POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='033'
  POWERLEVEL9K_DIR_HOME_FOREGROUND='236'
  POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='236'
  POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='236'
  POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND='black'
  POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND='009'

  POWERLEVEL9K_HOME_ICON=''
  POWERLEVEL9K_HOME_SUB_ICON=''
  POWERLEVEL9K_FOLDER_ICON=''
  POWERLEVEL9K_ROOT_ICON='\uF0E7'
  POWERLEVEL9K_STATUS_VERBOSE=false
  POWERLEVEL9K_STATUS_OK_IN_NON_VERBOSE=true

  POWERLEVEL9K_VCS_GIT_GITHUB_ICON='\uF113'
  POWERLEVEL9K_VCS_CLEAN_BACKGROUND='154'
  POWERLEVEL9K_VCS_CLEAN_FOREGROUND='236'
  POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='220'
  POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='236'
  POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='227'
  POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='236'
  POWERLEVEL9K_RAM_BACKGROUND='220'
  POWERLEVEL9K_PYENV_FOREGROUND='black'
  POWERLEVEL9K_PYENV_BACKGROUND='033'
  POWERLEVEL9K_SHOW_CHANGESET=true
  POWERLEVEL9K_CHANGESET_HASH_LENGTH=6

  zinit light bhilburn/powerlevel9k

elif [[ "$ZSH_THEME" == "p10k" ]]; then

  zinit ice atload'[[ -f $ZDOTDIR/.p10k.zsh ]] && source $ZDOTDIR/.p10k.zsh || true; _p9k_precmd' \
    lucid nocd wrap-track'_p9k_precmd'
  zinit load romkatv/powerlevel10k

fi

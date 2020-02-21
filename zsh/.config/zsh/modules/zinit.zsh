#
# Zplugin, plugins & snippets
#

typeset -A ZPLGM
ZPLG_HOME=$HOME/.local/zplugin
ZPLGM[HOME_DIR]=$ZPLG_HOME
ZPLGM[ZCOMPDUMP_PATH]=$XDG_CACHE_HOME/zsh/compdump

if [[ ! -f $ZPLG_HOME/bin/zplugin.zsh ]]; then
  git clone https://github.com/zdharma/zplugin.git $ZPLG_HOME/bin
  zcompile $ZPLG_HOME/bin/zplugin.zsh
fi

source $ZPLG_HOME/bin/zplugin.zsh
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

autoload -Uz compinit
compinit -u -d "$XDG_CACHE_HOME/zsh/compdump"

# Zplugin annex
zplugin light-mode for zplugin/z-a-bin-gem-node

# Commands
zplugin light rupa/z

zplugin ice as'program' pick"$ZPFX/bin/git-*" \
  make"PREFIX=$ZPFX" src'etc/git-extras-completion.zsh'
zplugin light tj/git-extras

# Zplugin does not provide a straight forward way to
# install accompanying man pages. Hence the mess/"genius" below.
# At least this way I won't forget to install the completion
# files, have to go back to the repo and manually add to FPATH
# on a new PC.
zplugin from'gh-r' lucid for \
  sbin'bin/hub' \
  atclone'mv hub*/* .;
    rm -rf *~*backup(/^F) (#i)install;
    mv etc/hub.zsh* etc/_hub;
    cp share/man/*/*.1 $ZPFX/share/man/man1' \
  atpull'%atclone' github/hub

zplugin as'null' wait lucid light-mode for \
  sbin"bin/git-dsf;bin/diff-so-fancy" zdharma/zsh-diff-so-fancy \
  sbin'emojify;fuzzy-emoji' src'fuzzy-emoji-zle.zsh' wfxr/emoji-cli

zplugin as'null' from'gh-r' lucid for \
  mv"exa* -> exa" sbin ogham/exa \
  mv'docker* -> docker-compose' sbin docker/compose \
  mv'jq* -> jq' sbin stedolan/jq \
  mv'shfmt* -> shfmt' sbin @mvdan/sh \
  mv'countdown* -> countdown' sbin antonmedv/countdown \
  mv'subify* -> subify' sbin matcornic/subify \
  bpick'*amd64.tgz' sbin cjbassi/gotop \
  sbin junegunn/fzf-bin

zplugin from'gh-r' lucid for \
  mv'ghq* -> ghq' sbin'ghq/ghq' motemen/ghq \
  mv'pastel* -> pastel' sbin'pastel/pastel' @sharkdp/pastel \
  mv'fd* -> fd' sbin'fd/fd' \
    atclone'cp **/*.1 $ZPFX/share/man/man1' atpull'%atclone' @sharkdp/fd \
  mv'bat* -> bat' sbin'bat/bat' \
    atclone'cp **/*.1 $ZPFX/share/man/man1' atpull'%atclone' @sharkdp/bat

zplugin wait lucid for \
  wfxr/forgit \
  sbin'bin/anyenv' \
    atload'export ANYENV_ROOT=$HOME/.anyenv; eval "$(anyenv init -)"' anyenv/anyenv

# zplugin wait lucid sbin'bin/anyenv' \
#   atload'export ANYENV_ROOT=$HOME/.anyenv; eval "$(anyenv init -)"'
# zplugin light anyenv/anyenv

# Plugins
zplugin light MichaelAquilina/zsh-you-should-use

local omz_plugins
omz_plugins=(
  lib/git.zsh
  plugins/git/git.plugin.zsh
  plugins/extract/extract.plugin.zsh
  plugins/encode64/encode64.plugin.zsh
  plugins/magic-enter/magic-enter.plugin.zsh
  themes/fishy.zsh-theme
)
zplugin ice pick'dev/null' nocompletions blockf \
  multisrc"${omz_plugins}"
zplugin light robbyrussell/oh-my-zsh

# Snippets
zplugin ice wait lucid id-as'fzf-keybindings'
zplugin snippet 'https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh'

zplugin ice wait lucid id-as'fzf-completion'
zplugin snippet 'https://github.com/junegunn/fzf/blob/master/shell/completion.zsh'

# Completion
zplugin ice wait'1' lucid as'completion' \
  id-as'beet-completion' mv'beet-completion -> _beet'
zplugin snippet 'https://github.com/beetbox/beets/blob/master/extra/_beet'

zplugin ice wait'1' lucid as'completion' \
  id-as'docker-compose-completion' mv'docker-compose-completion -> _docker-compose'
zplugin snippet 'https://github.com/docker/compose/blob/master/contrib/completion/zsh/_docker-compose'

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

  zplugin light bhilburn/powerlevel9k

elif [[ "$ZSH_THEME" == "p10k" ]]; then

  zplugin ice atload'[[ -f $ZDOTDIR/.p10k.zsh ]] && source $ZDOTDIR/.p10k.zsh || true; _p9k_precmd' \
    lucid nocd wrap-track'_p9k_precmd'
  zplugin load romkatv/powerlevel10k

fi

# This is handcrafted setup to keep the same performance characteristics I had
# before using nix or even improve it. Simple rules followed here are:
#
# - Setup things as early as possible when the shell runs
# - Inline files when possible instead of souring then
# - User specific shell files are to override or for machine specific setup
{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.modules.shell;
  inherit (config.my.user) home;
  inherit (config.my) hm;
  inherit (config.my) hostConfigHome;
  inherit (pkgs.stdenv) isDarwin isLinux;

  histfile = "${hm.stateHome}/zsh/history";
  zcachefile = "${hm.cacheHome}/z/.z";
  localrc = "${hm.configHome}/zsh/local";
in {
  options = with lib; {
    my.modules.shell = {
      enable = mkEnableOption ''
        Whether to enable shell module
      '';
    };
  };

  config = with lib;
    mkIf cfg.enable (mkMerge [
      (mkIf isLinux {
        # systemd
      })

      {
        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
        environment = {
          variables = {
            LANG = "en_US.UTF-8";
            LC_TIME = "en_GB.UTF-8";
            # NOTE: Darwin doesn't set them by default, unlike NixOS. So we have to set them.
            # This is just using what's inside home-manager. Defaults are here
            # https://github.com/nix-community/home-manager/blob/a4b0a3faa4055521f2a20cfafe26eb85e6954751/modules/misc/xdg.nix#L14-L17
            XDG_CACHE_HOME = hm.cacheHome;
            XDG_CONFIG_HOME = hm.configHome;
            XDG_DATA_HOME = hm.dataHome;
            XDG_STATE_HOME = hm.stateHome;
            HOST_CONFIGS = "${hostConfigHome}";
            # https://github.blog/2022-04-12-git-security-vulnerability-announced/
            GIT_CEILING_DIRECTORIES = builtins.dirOf home;
            SHELL = "${pkgs.zsh}/bin/zsh";
            # CDPATH = ".:~:~/Sites";
          };
          systemPackages = with pkgs;
            (
              if stdenv.isDarwin
              then [openssl gawk gnused coreutils findutils]
              else [
                xclip
              ]
            )
            ++
            # Packages broken on Intel
            (
              lib.optional (stdenv.hostPlatform.system == "aarch64-darwin")
              lnav # System Log file navigator
            )
            ++ [
              ast-grep
              alejandra
              cachix
              curl
              direnv
              diskonaut
              eza
              fzf
              # grc
              htop
              # hyperfine
              jq
              nix-direnv
              pandoc
              ripgrep
              rsync
              wget
              zoxide
              zsh-powerlevel10k
            ];
        };

        my = {
          user = {
            shell = pkgs.zsh;
            packages = with pkgs; [
              # buku
              # difftastic
              # emanote # Only aarch64-darwin
              glow
              gum # https://github.com/charmbracelet/gum
              mods # https://github.com/charmbracelet/mods
              rename
              scc
              shellcheck
              shfmt # Doesn't work with zsh, only sh & bash
              slides # CLI markdown presentation tool
              tokei
              vivid
            ];
          };

          hm.file = {
            ".config/zsh" = {
              recursive = true;
              source = ../../../config/zsh.d/zsh;
            };
            # ".config/mods" = {
            #   recursive = true;
            #   source = ../../../config/mods;
            # };
            # ".terminfo" = {
            #   recursive = true;
            #   source = ../../../config/.terminfo;
            # };
            # ".config/direnv/direnvrc" = {
            #   text = lib.concatStringsSep "\n"
            #     [
            #       "source ${pkgs.nix-direnv}/share/nix-direnv/direnvrc"
            #       (builtins.readFile ../../../config/direnv/direnvrc)
            #     ];
            # };
            # This is an emptyfile that's needed to get rid of the "Last login..." message when opening a new shell
            # ".hushlogin" = {
            #   text = "";
            # };
            # ".config/vivid" = {
            #   recursive = true;
            #   source = ../../../config/vivid;
            # };
          };

          env =
            # ====================================================
            # This list gets set in alphabetical order.
            # So care needs to be taken if two env vars depend on each other
            # ====================================================
            rec {
              BROWSER =
                if pkgs.stdenv.isDarwin
                then "open"
                else "xdg-open";
              GITHUB_USER = config.my.github_username;
            };
        };

        system.activationScripts.postUserActivation.text = ''
          echo ":: -> Running shell activationScript..."
          if [ ! -e "${histfile}" ]; then
            mkdir -p $(dirname "${histfile}")
          fi

          if [ ! -e "${zcachefile}" ]; then
            mkdir -p $(dirname "${zcachefile}")
          fi

          if [ ! -e "${localrc}" ]; then
            mkdir -p $(dirname "${localrc}")

            cat > ${localrc}<< EOF
            # vim:ft=zsh:
            _Z_DATA="${zcachefile}"
          EOF
          fi
        '';

        programs.zsh = {
          enable = true;
          # This will also add nix-zsh-completions to the systemPackages.
          # https://github.com/LnL7/nix-darwin/blob/58b905ea87674592aa84c37873e6c07bc3807aba/modules/programs/zsh/default.nix#L117
          enableCompletion = true;
          # Default is the value of enableCompletion but I want to handle it myself
          # https://github.com/LnL7/nix-darwin/blob/58b905ea87674592aa84c37873e6c07bc3807aba/modules/programs/zsh/default.nix#L76
          enableGlobalCompInit = false;

          ########################################################################
          # Instead of sourcing, I can read the files & save startiup time instead
          ########################################################################

          # zshenv
          shellInit =
            lib.concatStringsSep "\n"
            (map builtins.readFile [
              ../../../config/zsh.d/zsh/modules/init.zsh
              ../../../config/zsh.d/.zshenv
            ]);

          # zshrc
          interactiveShellInit =
            lib.concatStringsSep "\n"
            (
              [
                (builtins.readFile ../../../config/zsh.d/zsh/modules/init.zsh)
              ]
              ++ [
                ''
                  # Return if requirements are not found.
                  if [[ $${TERM} == 'dumb' ]]; then
                    return 1
                  fi

                  if [[ -r "$${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-$${(%):-%n}.zsh" ]]; then
                    source "$${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-$${(%):-%n}.zsh"
                  fi
                ''
              ]
              ++ map builtins.readFile [
                ../../../config/zsh.d/zsh/modules/paths.zsh
                ../../../config/zsh.d/zsh/modules/term.zsh
                ../../../config/zsh.d/zsh/modules/theme.zsh
                ../../../config/zsh.d/zsh/modules/keymap.zsh
                ../../../config/zsh.d/zsh/modules/widgets.zsh
                ../../../config/zsh.d/zsh/modules/env.zsh
                ../../../config/zsh.d/zsh/modules/options.zsh
                ../../../config/zsh.d/zsh/modules/completion.zsh
                ../../../config/zsh.d/zsh/modules/history.zsh
                ../../../config/zsh.d/zsh/modules/window.zsh
                ../../../config/zsh.d/zsh/modules/zinit.zsh
                # "${pkgs.grc}/etc/grc.zsh"
                "${pkgs.fzf}/share/fzf/completion.zsh"
                "${pkgs.fzf}/share/fzf/key-bindings.zsh"
              ]
              ++ [
                (builtins.readFile ../../../config/zsh.d/.p10k.zsh)
              ]
            );
          promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        };
      }
    ]);
}

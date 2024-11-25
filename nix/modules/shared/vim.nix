{
  pkgs,
  lib,
  config,
  ...
}:
with config.my; let
  cfg = config.my.modules.vim;
  inherit (config.my.user) home;
  inherit (config.my) hm;
  inherit (config.my) github_username;
in {
  options = with lib; {
    my.modules.vim = {
      enable = mkEnableOption ''
        Whether to enable vim module
      '';
    };
  };

  config = with lib;
    mkIf cfg.enable {
      environment.systemPackages = with pkgs;
        [
          vim
          neovim-unwrapped
        ]
        ++ (lib.optionals (!pkgs.stdenv.isDarwin) [
          gcc # Required for treesitter parsers
        ]);

      my.env = {
        EDITOR = "${pkgs.neovim-unwrapped}/bin/nvim";
        VISUAL = "$EDITOR";
        GIT_EDITOR = "$EDITOR";
        MANPAGER = "$EDITOR +Man!";
      };

      my.user = {
        packages = with pkgs; [
          fzf
          par
          fd
          ripgrep
          # editorconfig-checker # do I use it?
          hadolint # Docker linter
          dotenv-linter
          nixpkgs-fmt
          alejandra
          vim-vint
          shellcheck
          shfmt # Doesn't work with zsh, only sh & bash
          stylua
          nodePackages.vscode-langservers-extracted # HTML, CSS, JSON & ESLint LSPs
          nodePackages.prettier
          nodePackages.bash-language-server
          nodePackages.dockerfile-language-server-nodejs
          nodePackages.typescript-language-server
          nodePackages.vim-language-server
          nodePackages.yaml-language-server
          nodePackages."@tailwindcss/language-server"
          statix
          sumneko-lua-language-server
          tree-sitter # required for treesitter "auto-install" option to work
          nil # nix lsp
          actionlint
          taplo # TOML linter and formatter
          # neovim luarocks support requires lua 5.1
          # https://github.com/folke/lazy.nvim/issues/1570#issuecomment-2194329169
          lua51Packages.luarocks
          typos
          typos-lsp
        ];
      };

      system.activationScripts.postUserActivation.text = ''
        echo ":: -> Running vim activationScript..."

        # Handle mutable configs

        if [ ! -e "${hm.configHome}/nvim/" ]; then
          echo "Linking vim folders..."
          ln -sf ${home}/Code/github.com/${github_username}/dotfiles/config/nvim ${hm.configHome}/nvim
          chown -R ${config.my.username} ${hm.configHome}/nvim
        fi
      '';
    };
}

{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.modules.git;
in {
  options = with lib; {
    my.modules.git = {
      enable = mkEnableOption ''
        Whether to enable git module
      '';
    };
  };

  config = with lib;
    mkIf cfg.enable {
      environment.systemPackages = with pkgs; [git];

      my.user = {
        packages = with pkgs; [
          # gitAndTools.diff-so-fancy
          gitAndTools.gh # Need this too https://github.com/yusukebe/gh-markdown-preview
          exiftool
        ];
      };

      my.hm.file = {
        ".config/git/config-nix" = with config.my; {
          text = ''
            ; ${nix_managed}
            ; vim: ft=gitconfig

            [user]
            ${optionalString (name != "") "  name = ${name}"}
            ${optionalString (email != "") "  email = ${email}"}
            useconfigonly = true

            ${optionalString (github_username != "") ''
              [github]
                 username = ${github_username}''}

            [diff "exif"]
                textconv = ${pkgs.exiftool}/bin/exiftool
          '';
        };

        ".config/git" = {
          recursive = true;
          source = ../../../config/git;
        };
      };
    };
}

{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.modules.mpv;
in {
  options = with lib; {
    my.modules.mpv = {
      enable = mkEnableOption ''
        Whether to enable mpv module
      '';
    };
  };

  config = with lib;
    mkIf cfg.enable (mkMerge [
      (
        if (builtins.hasAttr "homebrew" options)
        then {
          homebrew.casks = ["iina"];
        }
        else {}
      )

      {
        my.hm.file = {
          ".config/mpv" = {
            recursive = true;
            source = ../../../config/mpv;
          };
        };
      }
    ]);
}

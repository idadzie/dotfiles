{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.modules.gui;
in {
  options = with lib; {
    my.modules.gui = {
      enable = mkEnableOption ''
        Whether to enable gui module
      '';
    };
  };

  config = with lib;
    mkIf cfg.enable (mkMerge [
      (
        if (builtins.hasAttr "homebrew" options)
        then {
          homebrew.taps = ["homebrew/cask-versions"];
          homebrew.casks = [
            "1password"
            "firefox"
            "launchcontrol"
            "slack"
            "visual-studio-code"
            "zoom"
          ];
        }
        else {
          my.user = {
            packages = with pkgs; [
              dbeaver-bin
              docker
              firefox
              gparted
              inkscape
              jetbrains.pycharm-professional
              libreoffice
              mpv
              signal-desktop
              simplescreenrecorder
              slack
              typora
              vscode
              vscodium
              zoom-us
            ];
          };
        }
      )
    ]);
}

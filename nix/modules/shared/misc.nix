{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.modules.misc;
in {
  options = with lib; {
    my.modules.misc = {
      enable = mkEnableOption ''
        Whether to enable misc module
      '';
    };
  };

  config = with lib;
    mkIf cfg.enable {
      my.hm.file = {
        ".curlrc" = {source = ../../../config/.curlrc;};
        ".config/.ignore" = {source = ../../../config/.ignore;};
        ".config/fd/ignore" = {
          recursive = true;
          text = builtins.readFile ../../../config/.ignore;
        };
      };
    };
}
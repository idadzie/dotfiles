{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./settings.nix
    ./shell.nix
    ./git.nix
    ./kitty.nix
    ./bat.nix
    ./tmux.nix
    ./go.nix
  ];

  my.modules = {
    shell.enable = lib.mkDefault true;
    git.enable = lib.mkDefault true;

    kitty.enable = lib.mkDefault true;
    bat.enable = lib.mkDefault true;
    tmux.enable = lib.mkDefault true;
    go.enable = lib.mkDefault true;
  };
}

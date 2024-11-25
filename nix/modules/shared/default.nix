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
    ./mpv.nix
    ./python.nix
    ./ripgrep.nix
    ./tmux.nix
    ./misc.nix
    ./vim.nix
    ./go.nix
    ./yt-dlp.nix
  ];

  my.modules = {
    shell.enable = lib.mkDefault true;
    git.enable = lib.mkDefault true;

    kitty.enable = lib.mkDefault true;
    bat.enable = lib.mkDefault true;
    mpv.enable = lib.mkDefault true;
    python.enable = lib.mkDefault true;
    ripgrep.enable = lib.mkDefault true;
    tmux.enable = lib.mkDefault true;
    misc.enable = lib.mkDefault true;
    vim.enable = lib.mkDefault true;
    go.enable = lib.mkDefault true;
    yt-dlp.enable = lib.mkDefault true;
  };
}

# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  my = {
    # Define a user account. Don't forget to set a password with ‘passwd’.
    user = {
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel"];
    };
  };

  users.defaultUserShell = pkgs.zsh;

  nix = {
    settings.auto-optimise-store = true;
    gc = {dates = "daily";};
    registry = {
      nixos.flake = inputs.nixpkgs;
      nixpkgs.flake = inputs.nixpkgs;
    };
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-864956da-e6cc-4e31-8c64-fd436fe609e0".device = "/dev/disk/by-uuid/864956da-e6cc-4e31-8c64-fd436fe609e0";
  networking.hostName = "chadpad"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "ak_GH";
      LC_IDENTIFICATION = "ak_GH";
      LC_MEASUREMENT = "ak_GH";
      LC_MONETARY = "ak_GH";
      LC_NAME = "ak_GH";
      LC_NUMERIC = "ak_GH";
      LC_PAPER = "ak_GH";
      LC_TELEPHONE = "ak_GH";
      LC_TIME = "en_GB.UTF-8";
    };
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    # Configure keymap in X11
    xkb.layout = "us";
    xkb.variant = "";

    # Enable the GNOME Desktop Environment.
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Install PostgreSQL
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_15;
  };

  # Environment variables
  environment.sessionVariables = rec {
    # Not officially in the XDG specification
    XDG_BIN_HOME = "$HOME/.local/bin";
    PATH = [
      "${XDG_BIN_HOME}"
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    feh
    ffmpeg-full
    git
    killall
    lshw
    meld
    pdfgrep
    rsync
    stow
    usbutils
    wget
    xclip
    xdotool
    zsh

    # Compression tools
    zip
    gzip
    unar
    unzip
    p7zip
    cpio

    # Build toolchains
    autoconf
    automake
    gnumake
    scons
    cmake
    gcc8
    clang
    clang-analyzer
    clang-manpages
    clang-tools

    # Programming (Rust)
    ruby_3_3

    # Programming (Rust)
    ncurses # Library to create Text User Interfaces
    rustup # Rust toolchain manager
    cargo # Rust package manager
    rustc # Rust compiler
    pkg-config # Compiler helper tool

    # Hypr
    hyprland
    hyprpaper
    hyprpicker
    hyprlock
    hypridle
    hyprcursor
    libnotify
    wl-clipboard
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs = {
    # Hyprland
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    java.enable = true;

    # Install ZSH
    zsh.enable = true;

    # Install firefox.
    firefox.enable = true;

    # Install Neovim
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };

    # direnv
    direnv.enable = true;

    # nix-ld
    nix-ld.enable = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}

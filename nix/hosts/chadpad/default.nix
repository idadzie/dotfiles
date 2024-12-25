# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-p1-gen3
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  my = {
    # Define a user account. Don't forget to set a password with ‘passwd’.
    user = {
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel" "docker"];
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

  nixpkgs.overlays = [
    (import ./kitty-overlay.nix)
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w" # Introduced because of Sublime Text 4
  ];

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

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.powerManagement.enable = false;
  hardware.nvidia.powerManagement.finegrained = false;
  hardware.nvidia.open = false;
  hardware.nvidia.nvidiaSettings = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
    version = "550.135";
    sha256_64bit = "sha256-ESBH9WRABWkOdiFBpVtCIZXKa5DvQCSke61MnoGHiKk=";
    sha256_aarch64 = "sha256-uyBCVhGZ637wv9JAp6Bq0A4e5aQ84jz/5iBgXdPr2FU=";
    openSha256 = "sha256-426lonLlCk4jahU4waAilYiRUv6bkLMuEpOLkCwcutE=";
    settingsSha256 = "sha256-4B61Q4CxDqz/BwmDx6EOtuXV/MNJbaZX+hj/Szo1z1Q=";
    persistencedSha256 = "sha256-FXKOTLbjhoGbO3q6kRuRbHw2pVUkOYTbTX2hyL/az94=";
  };
  hardware.nvidia-container-toolkit.enable = true;

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

  # Enable PostgreSQL
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_15;
  };

  # Enable Syncthing
  services.syncthing = {
    enable = true;
    user = "${config.my.username}";
    configDir = "/home/${config.my.username}/.config/syncthing";
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
    lsof
    meld
    mosh
    pdfgrep
    rclone
    rsync
    stow
    usbutils
    wget
    xclip
    xdotool

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

    # Programming (Ruby)
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

    # direnv
    direnv.enable = true;
  };

  # nix-ld
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    cyrus_sasl.dev
    gsasl
    libsass
    openldap
    stdenv.cc.cc.lib
    zlib
  ];

  virtualisation.docker.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}

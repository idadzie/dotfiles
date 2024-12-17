{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    systems.url = "github:nix-systems/default";
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        inherit (pkgs) lib;
        pythonldlibpath = lib.makeLibraryPath (with pkgs; [
          acl
          attr
          bzip2
          curl
          cyrus_sasl
          gsasl
          libsass
          libsodium
          libssh
          libxml2
          openldap
          openssl
          stdenv.cc.cc
          systemd
          util-linux
          xz
          zlib
          zstd
        ]);
        # Darwin requires a different library path prefix
        wrapPrefix =
          if (!pkgs.stdenv.isDarwin)
          then "LD_LIBRARY_PATH"
          else "DYLD_LIBRARY_PATH";
        patchedpython = pkgs.symlinkJoin {
          name = "python";
          paths = [pkgs.python39];
          buildInputs = [pkgs.makeWrapper];
          postBuild = ''
            wrapProgram "$out/bin/python3.9" --prefix ${wrapPrefix} : "${pythonldlibpath}"
          '';
        };
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            patchedpython
          ];
        };
      }
    );
}

{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/a7ecde854aee5c4c7cd6177f54a99d2c1ff28a31";
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
        inherit (pkgs) stdenv;
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            cyrus_sasl.dev
            gsasl
            libsass
            openldap
            postgresql_14 # without this psycopg2 from the requirments txt does not build. ;(

            python39Packages.setuptools
            python39Packages.wheel

            stdenv.cc.cc.lib
          ];
        };
      }
    );
}


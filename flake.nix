{
  description = "Dev shell + runner for QMK c2json and QGF conversion";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        # nix develop
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            imagemagick # handy for pre-processing images
            keymap-drawer
          ];
        };
      }
    );
}

{
  description = "Says hello to the world";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

      in
      rec {
        packages = {
          hello = pkgs.callPackage ./default.nix { inherit pkgs; src = self; };
          default = packages.hello;
        };

        formatter = pkgs.nixpkgs-fmt;

        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.nixpkgs-fmt
            pkgs.nixpkgs-lint
            pkgs.rnix-lsp

            pkgs.act
          ];
        };

        checks = {
          flake-build = packages.default;

          test = pkgs.runCommandLocal "test-hello" { } ''
            ${packages.default}/bin/${packages.default.name} > $out
          '';
        };
      }
    );
}

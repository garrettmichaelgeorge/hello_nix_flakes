{
  description = "Says hello to the world";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system: 
      let pkgs = import nixpkgs { inherit system; };
      in {
        packages.hello = pkgs.hello;
        packages.default = pkgs.hello;
    });
}

{
  description = "Says hello to the world";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system: 
      let pkgs = import nixpkgs { inherit system; };
      in rec {
        packages.hello = pkgs.stdenv.mkDerivation {
          name = "hello";
          src = self;
          buildInputs = [ pkgs.gcc ];
          buildPhase = "gcc -o hello ./hello.c";
          installPhase = "mkdir -p $out/bin; install -t $out/bin hello";
        };
        packages.default = packages.hello;
    });
}

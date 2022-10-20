{
  description = "Says hello to the world";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: 
      let pkgs = import nixpkgs { inherit system; };
      in rec {
        packages.hello = pkgs.stdenv.mkDerivation rec {
          name = "hello";
          src = self;
          buildInputs = [ pkgs.gcc ];
          buildPhase = "gcc -o ${name} ./main.c";
          installPhase = "mkdir -p $out/bin; install -t $out/bin ${name}";
        };
        packages.default = packages.hello;
    });
}

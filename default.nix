{ pkgs ? import <nixpkgs> { }
, src ? ./.
}:

with pkgs;
stdenv.mkDerivation rec {
  name = "hello";
  inherit src;
  buildInputs = [ pkgs.gcc ];
  buildPhase = "gcc -o ${name} ./main.c";
  installPhase = "mkdir -p $out/bin; install -t $out/bin ${name}";
}

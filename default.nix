{ stdenv, SDL2, cairo, pkgconfig, pango, alex, ghc, cabal-install }:

stdenv.mkDerivation {
  name = "sdl-pango";
  # builder = ./builder.sh;
  buildInputs = [ SDL2 cairo pkgconfig pango alex ghc cabal-install ];
  src = ./.;
}

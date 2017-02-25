{ mkDerivation, base, cairo, linear, pango, profunctors, reflex
, sdl2, semigroups, stdenv
}:
mkDerivation {
  pname = "tamar";
  version = "1.0";
  src = ./.;
  libraryHaskellDepends = [
    base cairo linear pango profunctors reflex sdl2 semigroups
  ];
  homepage = "github.com/bergey/tamar";
  description = "Compositional GUI widgets without stateful objects or CSS";
  license = stdenv.lib.licenses.bsd3;
}

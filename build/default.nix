{ mkDerivation, base, linear, profunctors, reflex, semigroups
, stdenv
}:
mkDerivation {
  pname = "tamar";
  version = "1.0";
  src = ./.;
  libraryHaskellDepends = [
    base linear profunctors reflex semigroups
  ];
  homepage = "github.com/bergey/tamar";
  description = "Compositional GUI widgets without stateful objects or CSS";
  license = stdenv.lib.licenses.bsd3;
}

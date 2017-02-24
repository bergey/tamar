{ mkDerivation, base, stdenv }:
mkDerivation {
  pname = "tamarind";
  version = "1.0";
  src = ./.;
  isLibrary = true;
  isExecutable = false;
  # executableHaskellDepends = [ base ];
  license = stdenv.lib.licenses.bsd3;
}

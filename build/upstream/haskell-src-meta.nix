{ mkDerivation, base, haskell-src-exts, pretty, stdenv, syb
, template-haskell, th-orphans
}:
mkDerivation {
  pname = "haskell-src-meta";
  version = "0.6.0.14";
  sha256 = "1j90xc74wf6r1f3ig4saynnmsifb13cmq8h0r1kmcscq4cwj94bn";
  libraryHaskellDepends = [
    base haskell-src-exts pretty syb template-haskell th-orphans
  ];
  description = "Parse source to template-haskell abstract syntax";
  license = stdenv.lib.licenses.bsd3;
}

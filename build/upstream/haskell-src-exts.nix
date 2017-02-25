{ mkDerivation, array, base, containers, cpphs, directory, filepath
, ghc-prim, happy, mtl, pretty, pretty-show, smallcheck, stdenv
, syb, tasty, tasty-golden, tasty-smallcheck
}:
mkDerivation {
  pname = "haskell-src-exts";
  version = "1.17.1";
  sha256 = "1g98amhn2b76g38y3dc55nny5812gqyqmswl1fniaiai41vm8p5s";
  revision = "1";
  editedCabalFile = "c07248f2a7b4bee1c7777dc6e441e8d1f32a02fb596ea49f47074c68b3c9ea0b";
  libraryHaskellDepends = [ array base cpphs ghc-prim pretty ];
  libraryToolDepends = [ happy ];
  testHaskellDepends = [
    base containers directory filepath mtl pretty-show smallcheck syb
    tasty tasty-golden tasty-smallcheck
  ];
  doCheck = false;
  homepage = "https://github.com/haskell-suite/haskell-src-exts";
  description = "Manipulating Haskell source: abstract syntax, lexer, parser, and pretty-printer";
  license = stdenv.lib.licenses.bsd3;
}

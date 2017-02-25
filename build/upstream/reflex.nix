{ mkDerivation, base, containers, dependent-map, dependent-sum
, exception-transformers, fetchgit, haskell-src-exts
, haskell-src-meta, MemoTrie, mtl, primitive, ref-tf, semigroups
, stdenv, syb, template-haskell, these, transformers
, transformers-compat
}:
mkDerivation {
  pname = "reflex";
  version = "0.3.2";
  src = fetchgit {
    url = "https://github.com/reflex-frp/reflex.git";
    sha256 = "1nfq2dgggjh8xxid5zg40hrh5whjgrr4wvnb4rn2lxi1093q3dwy";
    rev = "1db982f69c9a068de3fddc205c87a4f86231c235";
  };
  libraryHaskellDepends = [
    base containers dependent-map dependent-sum exception-transformers
    haskell-src-exts haskell-src-meta mtl primitive ref-tf semigroups
    syb template-haskell these transformers transformers-compat
  ];
  testHaskellDepends = [
    base containers dependent-map MemoTrie mtl ref-tf
  ];
  homepage = "https://github.com/ryantrinkle/reflex";
  description = "Higher-order Functional Reactive Programming";
  license = stdenv.lib.licenses.bsd3;
}

{ mkDerivation, ansi-terminal, base, cmdargs, containers, cpphs
, directory, extra, filepath, haskell-src-exts, hscolour, process
, refact, stdenv, transformers, uniplate
}:
mkDerivation {
  pname = "hlint";
  version = "1.9.35";
  sha256 = "12ksgnlp14c9xkz6zzwnkivzs4ch0lv93h1fw4p8d83pvkd8jqjy";
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    ansi-terminal base cmdargs containers cpphs directory extra
    filepath haskell-src-exts hscolour process refact transformers
    uniplate
  ];
  executableHaskellDepends = [ base ];
  homepage = "https://github.com/ndmitchell/hlint#readme";
  description = "Source code suggestions";
  license = stdenv.lib.licenses.bsd3;
}

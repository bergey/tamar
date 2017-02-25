{ pkgs ? import <nixpkgs> {} }: # TODO stable channel

pkgs.callPackage ./. {
    inherit (pkgs) pkgconfig cairo SDL2 stdenv pango;
    inherit (pkgs.haskellPackages) alex;
    ghc = pkgs.haskell.compiler.ghc7103;
    cabal-install = pkgs.haskellPackages.cabal-install;
    }

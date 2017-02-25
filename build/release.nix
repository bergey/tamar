let
  bootstrap = import <nixpkgs> { };

  nixpkgs = builtins.fromJSON (builtins.readFile ./nixpkgs.json);

  src = bootstrap.fetchFromGitHub {
    owner = "NixOS";
    repo  = "nixpkgs";
    inherit (nixpkgs) rev sha256;
  };

  config = {
      packageOverrides = pkgs: rec {
          haskellPackages = pkgs.haskellPackages.override {
              overrides = haskellPackagesNew: haskellPackagesOld: rec {
                  haskell-src-exts = haskellPackagesNew.callPackage ./upstream/haskell-src-exts.nix { };
                  haskell-src-meta = haskellPackagesNew.callPackage ./upstream/haskell-src-meta.nix { };
                  hlint = haskellPackagesNew.callPackage ./upstream/hlint.nix { };
                  reflex = haskellPackagesNew.callPackage ../../reflex/default.nix { };
                  tamar = haskellPackagesNew.callPackage ./default.nix { };
    
                  # reflex = haskellPackagesNew.callPackage ./upstream/reflex.nix { };
              };
          };
      };
  };
      
  pkgs = import src { inherit config; };

in
  { tamar = pkgs.haskellPackages.tamar;
    reflex = pkgs.haskellPackages.reflex;
  }

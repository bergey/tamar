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
              overrides = haskellPackagesNew: haskellPackagesOld:
                let callPackage = haskellPackagesNew.callPackage; in rec {
                  haskell-src-exts = callPackage ./upstream/haskell-src-exts.nix { };
                  haskell-src-meta = callPackage ./upstream/haskell-src-meta.nix { };
                  hlint = callPackage ./upstream/hlint.nix { };
                  reflex = let
                      json = builtins.fromJSON (builtins.readFile ./upstream/reflex.json);
                      src = bootstrap.fetchFromGitHub {
                          owner = "reflex-frp";
                          repo = "reflex";
                          inherit (json) rev sha256;
                      };
                      in callPackage src { };
                  tamar = callPackage ./default.nix { };
    
                  # reflex = callPackage ./upstream/reflex.nix { };
              };
          };
      };
  };
      
  pkgs = import src { inherit config; };

in
  { tamar = pkgs.haskellPackages.tamar;
    reflex = pkgs.haskellPackages.reflex;
  }

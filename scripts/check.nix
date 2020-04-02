with import <nixpkgs> {};

# Check all versions
lib.collect lib.isDerivation (callPackage ../default.nix {})

with import <nixpkgs> {};

callPackage ./clever-tools {
  nodegit = callPackage ./nodegit {};
}

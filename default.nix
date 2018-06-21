{ pkgs ? import <nixpkgs> {} }: with pkgs;

callPackage ./clever-tools {
  nodegit = callPackage ./nodegit {};
}

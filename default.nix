{ pkgs ? import <nixpkgs> {} }: with pkgs;
{
  latest = callPackage ./clever-tools {
             nodegit = callPackage ./nodegit {};
           };
}

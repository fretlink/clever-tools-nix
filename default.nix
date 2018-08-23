{ pkgs ? import <nixpkgs> {} }: with pkgs;
let
  mkOlderVersion = { rev, sha256 }:
    let
      olderVersion = fetchFromGitHub {
        owner = "fretlink";
        repo  = "clever-tools-nix";
        inherit rev;
        inherit sha256;
      };
    in (import olderVersion {}).latest;
in
{
  latest = callPackage ./clever-tools {
             nodegit = callPackage ./nodegit {};
           };
}

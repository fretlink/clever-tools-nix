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
  v0_9_3 = mkOlderVersion {
    rev = "a60f5f961215e9a011b4a0dfe651758001f116d8";
    sha256 = "1n831iw55di0s2izbl03xivs59792swfji2n46vhi3mkdawrsjkg";
  };

  # 1.1.0
  latest = callPackage ./clever-tools {};
}

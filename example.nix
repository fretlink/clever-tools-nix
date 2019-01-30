{ pkgs ? import <nixpkgs> {} }: with pkgs;

let clever-tools = import (fetchFromGitHub {
                     owner  = "fretlink";
                     repo   = "clever-tools-nix";
                     rev    = "master";
                     sha256 = "computed_hash";
                   }) {};
   # select appropriate version (see default.nix for the supported one)
   # clever-tools.v0_9_3
in clever-tools.latest

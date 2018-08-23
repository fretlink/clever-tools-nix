{ pkgs ? import <nixpkgs> {} }: with pkgs;

let clever-tools = fetchFromGitHub {
                     owner  = "fretlink";
                     repo   = "clever-tools-nix";
                     rev    = "DESIRED_REVISION_HASH";
                     sha256 = "CONTENT_HASH";
                   };
in (import clever-tools {}).latest # select appropriate version

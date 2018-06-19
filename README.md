# clever-tools-nix

Nix derivation to install clever-tools - see https://github.com/CleverCloud/clever-tools

## What's in it

2 derivations to install
- nodegit.node 0.20.3 for node v51, from prebuilt archive
- clever-tools 0.9.3, from prebuilt archive

Main job of those derivations is to use patchelf to make it nix compliant.

## How to use it

```nix
{ pkgs ? import <nixpkgs> {} }:

let
  clever-tools = pkgs.fetchFromGitHub
                   { owner  = "fmenou";
                     repo   = "clever-tools-nix";
                     rev    = "7c2a7868b387ffd064dd14c51f7b18224cdc5c88";
                     sha256 = "0r4bc4k90xpq325djvsyix9a6hiabmd4nba14j0plgdrwgzb36rh";
                   };

in import clever-tools { inherit pkgs; }
```

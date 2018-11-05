# clever-tools-nix

Nix derivation to install clever-tools - see https://github.com/CleverCloud/clever-tools

## What's in it

2 derivations to install
- nodegit.node 0.20.3 for node v51, from prebuilt archive
- clever-tools 0.9.3, from prebuilt archive

Main job of those derivations is to use patchelf to make it nix compliant.

## How to use it

[See the example.nix](https://github.com/fretlink/clever-tools-nix/blob/master/example.nix)

# clever-tools-nix

Nix derivation to install clever-tools - see https://github.com/CleverCloud/clever-tools

## How to use it

[See the example.nix](https://github.com/fretlink/clever-tools-nix/blob/master/example.nix)

## How to publish a new version

First, edit `clever-tools/default.nix`, to update the version number. For the expected hash, you can put `0000000000000000000000000000000000000000000000000000` (52 zeroes).

Then, edit `default.nix`, update the `callPackage` line to the new version, as well as the `latest` value.

Once you've done that, add a `mkOlderVersion` for the previous latest version. Once again, you can use the null hash for `sha256`.

Then, run `nix build`. It will give you the correct values for the hashes. Correct those, run it again and you'll see `result-` directories, one per version. Go ahead and make sure they all work.

Finally, don't forget to update `scripts/check.sh` with the latest version number.

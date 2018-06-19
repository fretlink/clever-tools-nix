{ pkgs ? import <nixpkgs> {} }:

let
  clever-tools = pkgs.fetchFromGitHub
                   { owner  = "fmenou";
                     repo   = "clever-tools-nix";
                     rev    = "7c2a7868b387ffd064dd14c51f7b18224cdc5c88";
                     sha256 = "0r4bc4k90xpq325djvsyix9a6hiabmd4nba14j0plgdrwgzb36rh";
                   };

in import clever-tools { inherit pkgs; }

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
in rec {
  v0_9_3 = mkOlderVersion {
    rev = "a60f5f961215e9a011b4a0dfe651758001f116d8";
    sha256 = "1n831iw55di0s2izbl03xivs59792swfji2n46vhi3mkdawrsjkg";
  };

  v1_1_1 = mkOlderVersion {
    rev = "63d289fd2f02a4d45e60f61e11f8dd9d3b4963fc";
    sha256 = "14ni1iaygbxihihmjiv7a7cg1q83y15lpqdp54frfyymjb7y12nj";
  };

  v1_3_0 = mkOlderVersion {
    rev = "2ea3abd717a23803bb936b49791d302d08cd29a6";
    sha256 = "09nwb23cqbjm1z9rwrysqc06g9lcimrgcqw38zxs3sc4kiixdlfb";
  };

  v1_4_0 = mkOlderVersion {
    rev = "8b7c2198ffa7679394bd95c356cac8b8133d993a";
    sha256 = "1r7n6cn2hj15a9msp55bbrb4j3srpmx00dxjj8vf0h5wagy8h1r5";
  };

  v1_4_2 = mkOlderVersion {
    rev = "e3b8f435cbb59fd64743ab495dcffb3496fee8e5";
    sha256 = "1wnz52m0ilsi18yrrv4iw2629ja0kjhqf53aldyrfb32ri8zcjxg";
  };

  v1_6_2 = mkOlderVersion {
    rev = "2d492a117cf31d1a4951ae9e9dcc5dd6ebeabaa2";
    sha256 = "0k0848aik036j90myf0gqapb0qm4khkf5wxhs7yhppmnpv3xgz24";
  };

  v1_6_3 = mkOlderVersion {
    rev = "c39d5d6f8ccb880a724cff59a27c87e2da0178dd";
    sha256 = "09n5phanqyrm73mw0rpgn5zaaibhnyp4sjfiidsnwk1fcd7wxmjb";
  };

  v2_6_0 = mkOlderVersion {
    rev = "69c08dd4edd8e88235a638bb20a992283e13244b";
    sha256 = "1sqgsjchdd2mv18hnzrh26ys0iybx3qfwz7fk5j62ywapvxc4qm8";
  };

  v2_6_1 = callPackage ./clever-tools {};

  latest = v2_6_1;
}

{ stdenv, fetchurl, glibc, nodegit }:

let
  version = "0.9.3";

  libs = [ stdenv.cc.cc glibc ];
in

  stdenv.mkDerivation {
    name = "clever-tools-${version}";

    buildInputs = [ nodegit ];

    src = fetchurl {
      url = "https://clever-tools.cellar.services.clever-cloud.com/releases/${version}/clever-tools-${version}_linux.tar.gz";
      sha256 = "adcae5af912dcbdc74d996b6e94767f24d16bf1bdcd5073797f999fe75b018a4";
    };

    libPath = stdenv.lib.makeLibraryPath libs;

    nodegitLibrary = stdenv.lib.makeLibraryPath [ nodegit ];

    installPhase = ''
      tar --extract --file=$src linux/clever --transform 's/linux\///'
      bin=$out/bin/clever
      mkdir -p $out/bin
      mv clever $bin
      ln -s "$nodegitLibrary/nodegit.node" "$out/bin/nodegit.node"
    '';

    dontStrip = "true";

    preFixup = ''
      bin=$out/bin/clever
      patchelf \
        --set-rpath "$libPath" \
        --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
        "$bin"
    '';

  }

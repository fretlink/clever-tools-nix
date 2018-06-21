{ stdenv, fetchurl, glibc, nodegit }:

stdenv.mkDerivation rec {
  name = "clever-tools-${version}";
  version = "0.9.3";

  src = fetchurl {
    url = "https://clever-tools.cellar.services.clever-cloud.com/releases/${version}/clever-tools-${version}_linux.tar.gz";
    sha256 = "adcae5af912dcbdc74d996b6e94767f24d16bf1bdcd5073797f999fe75b018a4";
  };

  buildInputs = [ nodegit ];

  libPath = stdenv.lib.makeLibraryPath [ stdenv.cc.cc glibc ];

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

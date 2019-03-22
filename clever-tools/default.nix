{ stdenv, fetchurl, glibc }:

stdenv.mkDerivation rec {
  name = "clever-tools-${version}";
  version = "1.4.0";

  src = fetchurl {
    url = "https://clever-tools.cellar.services.clever-cloud.com/releases/${version}/clever-tools-${version}_linux.tar.gz";
    sha256 = "1r0zjdr20si1hlikhzbpi57zmpd29zlik2frf7w46gjy1f6d1nhw";
  };

  libPath = stdenv.lib.makeLibraryPath [ stdenv.cc.cc glibc ];

  unpackPhase = ''
    tar --extract --file=$src
  '';

  installPhase = ''
    bin=$out/bin/clever
    mkdir -p $out/bin
    mv clever-tools-${version}_linux/clever $bin
  '';

  dontStrip = "true";

  # See https://github.com/brendan-hall/nixpkgs/blob/e3b313bb59f49f10970205aafd44878d35da07e7/pkgs/development/web/now-cli/default.nix#L25
  # There is no helper in nixpkgs lib right now
  # The algorithm for zeit/pkg fix is given https://github.com/NixOS/nixpkgs/pull/48193
  # it has been used for Unity3D as well https://github.com/NixOS/nixpkgs/pull/48643
  preFixup = ''
    bin=$out/bin/clever
    orig_size=$(stat --printf=%s $bin)
    patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" $bin
    patchelf --set-rpath ${libPath} $bin
    new_size=$(stat --printf=%s $bin)
    ###### zeit-pkg fixing starts here.
    # we're replacing plaintext js code that looks like
    # PAYLOAD_POSITION = '1234                  ' | 0
    # [...]
    # PRELUDE_POSITION = '1234                  ' | 0
    # ^-----20-chars-----^^------22-chars------^
    # ^-- grep points here
    #
    # var_* are as described above
    # shift_by seems to be safe so long as all patchelf adjustments occur
    # before any locations pointed to by hardcoded offsets
    var_skip=20
    var_select=22
    shift_by=$(expr $new_size - $orig_size)
    function fix_offset {
      # $1 = name of variable to adjust
      location=$(grep -obUam1 "$1" $bin | cut -d: -f1)
      location=$(expr $location + $var_skip)
      value=$(dd if=$bin iflag=count_bytes,skip_bytes skip=$location \
                 bs=1 count=$var_select status=none)
      value=$(expr $shift_by + $value)
      echo -n $value | dd of=$bin bs=1 seek=$location conv=notrunc
    }
    fix_offset PAYLOAD_POSITION
    fix_offset PRELUDE_POSITION
  '';
}

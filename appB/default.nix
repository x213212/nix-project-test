{ stdenv, libdep }:

stdenv.mkDerivation {
  name = "appB";
  version = "1.0";

  src = ./.;

  buildInputs = [ libdep ];

  buildPhase = ''
    gcc -I${libdep}/include -L${libdep}/lib -o appB main.c -ldep -Wl,-rpath=${libdep}/lib
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp appB $out/bin/
  '';
}

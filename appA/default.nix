{ stdenv, libdep }:

stdenv.mkDerivation {
  name = "appA";
  version = "1.0";

  src = ./.;

  buildInputs = [ libdep ];


  buildPhase = ''
    gcc -I${libdep}/include -L${libdep}/lib -o appA main.c -ldep -Wl,-rpath=${libdep}/lib
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp appA $out/bin/
  '';
}

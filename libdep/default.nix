{ stdenv, lib }:

stdenv.mkDerivation {
  name = "libdep";
  version = "1.0";

  src = ./.; 

  buildInputs = [];

  buildPhase = ''
    gcc -fPIC -c libdep.c -o libdep.o -I.  
    gcc -shared -o libdep.so libdep.o
  '';

  installPhase = ''
    mkdir -p $out/lib
    mkdir -p $out/include
    cp libdep.so $out/lib/
    cp libdep.h $out/include/
  '';

  meta = with lib; {
    description = "A shared dependency library (libdep)";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}

{ pkgs ? import <nixpkgs> {} }:

let
  libdep = pkgs.callPackage ./libdep/default.nix { inherit (pkgs) lib; };
  appA = pkgs.callPackage ./appA/default.nix { inherit libdep; };
  appB = pkgs.callPackage ./appB/default.nix { inherit libdep; };
in
{
  inherit libdep appA appB;
}

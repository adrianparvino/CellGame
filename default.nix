{ pkgs ? import <nixpkgs> {config = (import ./config.nix) compiler;}
, compiler ? "ghcjsHEAD"
}:

pkgs.callPackage ./shell.nix {}

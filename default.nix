{ pkgs ? import <nixpkgs> {config = (import ./config.nix) compiler;}
, compiler ? "ghcjsHEAD"
}:
let
  paths = p: with p; [ base reflex reflex-dom clay font-awesome-type containers text ];
  
  # hlint = runCommand "hlint-1.9.0" "cabal2nix --no-check cabal://hlint-1.9.0";
  # haskellPackages' = haskellPackages.override {overrides = (self: super: {inherit hlint; }); };
#  ghc = pkgs.haskellPackages.ghcWithPackages paths;
in pkgs.haskellPackages.mkDerivation {
  pname = "CellGame";
  version = "0.1.0.0";
  src = ./.;

  executableHaskellDepends = with pkgs.haskellPackages; [
    base reflex reflex-dom clay font-awesome-type
    containers text
  ];

  buildTools = [ pkgs.closurecompiler ];
  
  postInstall = ''
    closure-compiler -O ADVANCED --js $out/bin/CellGame.jsexe/all.js --js_output_file $out/all.min.js
    echo "<html> <head> <script src=\"all.min.js\"></script> </head> </html>" > $out/index.html
    rm -r $out/bin/CellGame.jsexe
    rm $out/bin/CellGame
  '';

  license = pkgs.stdenv.lib.licenses.gpl3;

  isExecutable = true;
}

# pkgs.stdenv.mkDerivation {
#   name = "cellgame";
#   src = ./src;
# 
#   dontBuild = true;
#   buildInputs = [ ghc pkgs.closurecompiler ];
# 
#   installPhase = ''
#     mkdir -pv $out
#     ghcjs ./Main.hs -o $TMPDIR/CellGame.exejs -odir $TMPDIR -hidir $TMPDIR
#     echo "<html> <head> <script src=\"all.min.js\"></script> </head> </html>" > $out/index.html
#     closure-compiler -O ADVANCED --js $TMPDIR/CellGame.exejs/all.js --js_output_file $out/all.min.js
#   '';
# }

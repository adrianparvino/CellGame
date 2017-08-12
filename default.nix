{ pkgs ? import <nixpkgs> {config = (import ./config.nix) compiler;}
, compiler ? "ghcjsHEAD"
}:
let
  paths = p: with p; [ base reflex reflex-dom clay font-awesome-type containers text ];
  
  # hlint = runCommand "hlint-1.9.0" "cabal2nix --no-check cabal://hlint-1.9.0";
  # haskellPackages' = haskellPackages.override {overrides = (self: super: {inherit hlint; }); };
  ghc = pkgs.haskellPackages.ghcWithPackages paths;
in pkgs.stdenv.mkDerivation {
  name = "cellgame";
  src = ./src;

  dontBuild = true;
  buildInputs = [ ghc ];

  installPhase = ''
    mkdir -pv $out
    ghcjs ./Main.hs -o $out/CellGame -odir $TMPDIR -hidir $TMPDIR
    echo "<html> <head> <script src=\"CellGame.jsexe/all.js\"></script> </head> </html>" > $out/index.html
  '';
}

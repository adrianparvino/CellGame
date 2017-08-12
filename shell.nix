{ runCommand, fetchFromGitHub, haskellPackages }:

let paths = p: with p; ( let
      in [ base reflex reflex-dom clay font-awesome-type containers text ]);
    
    # hlint = runCommand "hlint-1.9.0" "cabal2nix --no-check cabal://hlint-1.9.0";
    # haskellPackages' = haskellPackages.override {overrides = (self: super: {inherit hlint; }); };
    ghc = haskellPackages.ghcWithPackages paths;
in runCommand "cellgame" { buildInputs = [ ghc ]; } ''
     mkdir -pv $out
     cd ${./src}
     ghcjs ./Main.hs -o $out/CellGame -odir $TMPDIR -hidir $TMPDIR
     echo "<html> <head> <script src=\"CellGame.jsexe/all.js\"></script> </head> </html>" > $out/index.html
   ''

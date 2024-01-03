{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {self, nixpkgs, flake-utils}: flake-utils.lib.eachDefaultSystem (system:
  let
    pkgs = import nixpkgs { inherit system; };
    ghcVersion = "ghc94";
    haskellPackages = pkgs.haskell.packages."${ghcVersion}";
    t = pkgs.lib.trivial;
  in {
    defaultPackage = haskellPackages.developPackage {
      root = ./.;
      modifier = (t.flip t.pipe)
        [
          (t.flip pkgs.haskell.lib.setBuildTarget "example")
          pkgs.haskell.lib.disableLibraryProfiling
          pkgs.haskell.lib.disableExecutableProfiling
          pkgs.haskell.lib.dontCheck
          pkgs.haskell.lib.dontHaddock
          pkgs.haskell.lib.dontBenchmark
          pkgs.haskell.lib.dontCoverage
          pkgs.haskell.lib.doStrip
          pkgs.haskell.lib.justStaticExecutables
        ];
    };
  });
}

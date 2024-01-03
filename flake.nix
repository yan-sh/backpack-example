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

    packageModifiers = (t.flip t.pipe)
      [
        pkgs.haskell.lib.disableLibraryProfiling
        pkgs.haskell.lib.disableExecutableProfiling
        pkgs.haskell.lib.dontCheck
        pkgs.haskell.lib.dontHaddock
        pkgs.haskell.lib.dontBenchmark
        pkgs.haskell.lib.dontCoverage
      ];

    callC2n = name: src: overrides:
      packageModifiers (haskellPackages.callCabal2nix name src overrides);

  in {
    packages = rec {
      default = callC2n "backpack-example" ./app { inherit models usecases prod-impl test-impl; };
      models = callC2n "models" ./src-models {};
      usecases = callC2n "usecases" ./src-usecases { inherit models; };
      prod-impl = callC2n "prod-impl" ./src-prod-impl { inherit models; };
      test-impl = callC2n "test-impl" ./src-test-impl { inherit models; };
    };

  });
}

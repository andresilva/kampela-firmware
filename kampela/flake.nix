{
  description = "Kampela hardware signer";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pilkki = {
      url = "github:andresilva/pilkki?dir=software";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = { nixpkgs, flake-utils, rust-overlay, pilkki, ... }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              rust-overlay.overlays.default
              pilkki.overlays.default
            ];
          };
        in
        {
          devShells.default = import ./shell.nix { inherit pkgs; };
        }
      );
}

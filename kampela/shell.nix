{ pkgs }:

let
  rust-toolchain = pkgs.rust-bin.stable.latest.default.override {
    targets = [ "thumbv8m.main-none-eabihf" ];
  };
in
with pkgs; pkgsCross.arm-embedded.mkShell {
  nativeBuildInputs = [
    pilkki
    rust-toolchain
    flip-link
  ];

  RUSTC_BOOTSTRAP = 1;
}

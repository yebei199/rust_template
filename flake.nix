{
  description = "Rust musl build environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = [
            # Use the explicit cross-compiler toolchain
            pkgs.pkgsCross.musl64.stdenv.cc
            pkgs.pkg-config
          ];

          # Override cargo config to disable sccache
          CARGO_BUILD_RUSTC_WRAPPER = "";

          shellHook = ''
            export CC_x86_64_unknown_linux_musl=x86_64-unknown-linux-musl-gcc
            export CXX_x86_64_unknown_linux_musl=x86_64-unknown-linux-musl-g++
            export AR_x86_64_unknown_linux_musl=x86_64-unknown-linux-musl-ar
            unset RUSTC_WRAPPER
          '';
        };
      }
    );
}

{
  description = "My Project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # 如果你不想写很多重复代码，可以使用 flake-utils (可选)
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    # 支持的系统架构
    supportedSystems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin"];

    # 这是一个简单的 helper 函数，用于在所有系统上生成属性
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

    # 获取特定系统的 pkgs 实例
    nixpkgsFor = system: import nixpkgs {inherit system;};
  in {
    # 1. 定义软件包 (nix build)
    packages = forAllSystems (system: let
      pkgs = nixpkgsFor system;
    in {
      default = pkgs.rustPlatform.buildRustPackage {
        pname = "my-rust-project"; # 包名
        version = "0.1.0"; # 版本

        # 源代码路径
        src = ./.;

        # 处理 Cargo 依赖的核心配置
        # 必须指向你的 Cargo.lock 文件
        cargoLock = {
          lockFile = ./Cargo.lock;
        };

        # 如果你有运行时依赖（比如 openssl），加在这里
        buildInputs = with pkgs; [
          # openssl
        ];

        # 如果你有编译时依赖（比如 pkg-config），加在这里
        nativeBuildInputs = with pkgs; [
          # pkg-config
        ];
      };
    });

    # 2. 定义开发环境 (nix develop)
    devShells = forAllSystems (system: let
      pkgs = nixpkgsFor system;
    in {
      default = pkgs.mkShell {
        # 引入构建所需的依赖
        inputsFrom = [self.packages.${system}.default];

        # 开发时需要的额外工具 (比如 rust-analyzer, clippy)
        packages = with pkgs; [
          rust-analyzer
          clippy
          rustfmt
        ];

        # 环境变量配置 (解决之前的 linker 问题或者库路径问题)
        RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
      };
    });
  };
}

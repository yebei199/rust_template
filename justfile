set shell := ["fish", "-c"]
set dotenv-load := true
set export := true

release:
    cargo build --release

musl_release:
    cargo build --release --target x86_64-unknown-linux-musl

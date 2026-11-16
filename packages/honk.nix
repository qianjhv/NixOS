{ pkgs }:

let
  version = "0.1.0-beta.3";
in
pkgs.stdenvNoCC.mkDerivation {
  pname = "honk-core";
  inherit version;

  src = pkgs.fetchurl {
    url = "https://github.com/daeuniverse/honk/releases/download/v${version}/honk-core-v${version}-x86_64-unknown-linux-gnu-stock-full.tar.gz";
    hash = "sha256:b1e9c27c31a89d539556bf8cac092bcc47bf6a7da56d83d66fc1d0873bc58505";
  };

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p "$out/bin"
    tar -xzf "$src" --strip-components=1 -C "$TMPDIR"
    install -m755 "$TMPDIR/honk-core" "$out/bin/honk-core"
  '';

  meta = {
    description = "Experimental eBPF transparent proxy engine";
    homepage = "https://github.com/daeuniverse/honk";
    license = pkgs.lib.licenses.gpl3Only;
    platforms = [ "x86_64-linux" ];
  };
}


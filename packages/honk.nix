{ pkgs }:

let
  version = "0.1.0-beta.6";
in
pkgs.stdenvNoCC.mkDerivation {
  pname = "honk";
  inherit version;

  src = pkgs.fetchurl {
    url = "https://github.com/daeuniverse/honk/releases/download/v${version}/honk-core-v${version}-x86_64-unknown-linux-gnu-stock-full.tar.gz";
    hash = "sha256:d3ef30b52015e0b741fc7e442067f76f27d535923e3faef0f98ea3c70acf0581";
  };

  nativeBuildInputs = [
    pkgs.autoPatchelfHook
  ];

  buildInputs = [
    pkgs.stdenv.cc.cc.lib
  ];

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall
    install -Dm755 honk-core "$out/bin/honk"
    runHook postInstall
  '';

  meta = {
    description = "Experimental eBPF transparent proxy engine";
    homepage = "https://github.com/daeuniverse/honk";
    license = pkgs.lib.licenses.gpl3Only;
    platforms = [ "x86_64-linux" ];
  };
}


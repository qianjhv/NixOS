{ lib, stdenv, fetchurl, autoPatchelfHook }:

stdenv.mkDerivation rec {
  pname = "bbdown";
  version = "0.11.0";

  src = fetchurl {
    url = "https://github.com/Joey-Project/BBDown-rust/releases/download/v${version}/bbdown-v${version}-linux-x86_64.tar.gz";
    hash = "sha256:f36fa26b206f24e28a122d226e73559e89ceec76a77113d6e2fbb05356e2c548";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    stdenv.cc.cc.lib
  ];

  installPhase = ''
    runHook preInstall

    install -Dm755 bbdown $out/bin/bbdown

    runHook postInstall
  '';

  meta = {
    description = "Bilibili command-line downloader";
    homepage = "https://github.com/Joey-Project/BBDown-rust";
    license = lib.licenses.mit;
    platforms = [ "x86_64-linux" ];
    mainProgram = "bbdown";
  };
}

{ lib
, stdenv
, fetchurl
}:

stdenv.mkDerivation rec {
  pname = "bbdown";
  version = "0.5.0";

  src = fetchurl {
    url = "https://github.com/Joey-Project/BBDown-rust/releases/download/v${version}/bbdown-v${version}-linux-x86_64.tar.gz";
    hash = "sha256-a371d7678563544616a2b51f46b424a08c85c1a6ba4a443381bf64dba1730eef";
  };

  installPhase = ''
    install -Dm755 bbdown $out/bin/bbdown
  '';

  meta = {
    description = "Bilibili command-line downloader";
    homepage = "https://github.com/Joey-Project/BBDown-rust";
    license = lib.licenses.mit;
    platforms = [ "x86_64-linux" ];
    mainProgram = "bbdown";
  };
}

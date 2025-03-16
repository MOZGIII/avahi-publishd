{ stdenv, lib, makeWrapper,

jq, procps, systemd, iproute2, avahi,

... }:

let version = "0.1";

in stdenv.mkDerivation {
  pname = "avahi-publishd";
  inherit version;

  src = ../../bin;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp avahi-publishd $out/bin/

    runHook postInstall
  '';

  postInstall = ''
    wrapProgram "$out/bin/avahi-publishd" \
      --prefix PATH : "${lib.makeBinPath [ jq procps systemd iproute2 avahi ]}"
  '';
}

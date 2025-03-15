{ stdenv, lib, makeWrapper,

jq, procps, systemd, iproute2, avahi,

... }:

let version = "0.1";

in stdenv.mkDerivation {
  pname = "avahi-subdomains";
  inherit version;

  src = ../../bin;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp avahi-subdomains $out/bin/

    runHook postInstall
  '';

  postInstall = ''
    wrapProgram "$out/bin/avahi-subdomains" \
      --prefix PATH : "${lib.makeBinPath [ jq procps systemd iproute2 avahi ]}"
  '';
}

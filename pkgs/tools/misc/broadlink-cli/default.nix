{ lib, python3Packages, fetchFromGitHub }:

python3Packages.buildPythonApplication rec {
  pname = "broadlink-cli";
  version = "0.18.1";

  # the tools are available as part of the source distribution from GH but
  # not pypi, so we have to fetch them here.
  src = fetchFromGitHub {
    owner  = "mjg59";
    repo   = "python-broadlink";
    rev    = version;
    sha256 = "sha256-x7RVCu5xOwhUOxXIHP7ZAe1/9F9ecf9RgL9I53e9Mcw=";
  };

  format = "other";

  propagatedBuildInputs = with python3Packages; [
    broadlink
  ];

  installPhase = ''
    runHook preInstall

    install -Dm555 -t $out/bin cli/broadlink_{cli,discovery}
    install -Dm444 -t $out/share/doc/broadlink cli/README.md

    runHook postInstall
  '';

  meta = with lib; {
    description = "Tools for interfacing with Broadlink RM2/3 (Pro) remote controls, A1 sensor platforms and SP2/3 smartplugs";
    maintainers = with maintainers; [ peterhoeg ];
    inherit (python3Packages.broadlink.meta) homepage license;
  };
}

{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      ...
    }@inputs:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      rec {
        packages.default = pkgs.stdenv.mkDerivation {
          pname = "thesis";
          version = "0.1.0";
          src = pkgs.lib.cleanSource ./.;
          strictDeps = true;
          nativeBuildInputs = with pkgs; [
            tinymist
            typst
          ];
          buildPhase = ''
            typst compile thesis.typ
            typst compile proposal.typ
            typst compile registration_certificate.typ
            typst compile feedbacklog.typ
          '';
          installPhase = ''
            mkdir -p $out
            cp *.pdf $out/
          '';
          env = {
            TYPST_FONT_PATHS = pkgs.newcomputermodern;
          };
        };
      }
    );
}

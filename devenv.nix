{ pkgs, inputs, ... }:
let
  pkgs-unstable = import inputs.nixpkgs-unstable { system = pkgs.stdenv.system; };
in
{
  packages = [
    pkgs.which
    pkgs.git
    pkgs.elmPackages.lamdera
    pkgs-unstable.elmPackages.elm-test-rs
    pkgs.nodejs
  ];

  enterTest = ''
    lamdera make src/Backend.elm
    elm-test-rs --compiler $(which lamdera)
  '';

}

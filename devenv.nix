{ pkgs, inputs, ... }:
let
  pkgs-unstable = import inputs.nixpkgs-unstable { system = pkgs.stdenv.system; };
in
{
  packages = [
    pkgs.which
    pkgs.elmPackages.lamdera
    pkgs-unstable.elmPackages.elm-test-rs
    pkgs.nodejs
  ];

  enterTest = ''
    elm-test-rs --compiler $(which lamdera)
  '';

}

# let
#   # point to a lokal nixpkgs checkout in ~/work/nixpkgs
#   nixpkgs = builtins.fetchTarball {
#     # https://status.nixos.org/ -> nixos-23.05 on 2023-10-04
#     url = "https://github.com/zupo/nixpkgs/archive/044e50b331310361b26829e2f5bb8b787d1c7aeb.tar.gz";
#   };
#   pkgs = import nixpkgs {};

# in

{ pkgs ? import /Users/zupo/work/nixpkgs {} }:

pkgs.mkShell {
  name = "dev-shell";
  buildInputs = [
    pkgs.elmPackages.lamdera
    pkgs.elmPackages.elm-review
    pkgs.elmPackages.elm-test
    pkgs.elmPackages.elm-format
    # pkgs.elmPackages.elm-land
  ];

}

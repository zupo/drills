let
  nixpkgs = builtins.fetchTarball {
    # https://status.nixos.org/ -> nixos-23.05 on 2023-10-04
    url = "https://github.com/nixos/nixpkgs/archive/621f51253edffa1d6f08d5fce4f08614c852d17e.tar.gz";
  };
  pkgs = import nixpkgs {};

in

pkgs.mkShell {
  name = "dev-shell";
  buildInputs = [
    pkgs.elmPackages.lamdera
    pkgs.elmPackages.elm-review
    pkgs.elmPackages.elm-test
    pkgs.elmPackages.elm-format
  ];

}

let
  nixpkgs = builtins.fetchTarball {
    # https://status.nixos.org/ -> nixpkgs-unstable on 2023-11-13
    url = "https://github.com/nixos/nixpkgs/archive/911ad1e67f458b6bcf0278fa85e33bb9924fed7e.tar.gz";
  };
  pkgs = import nixpkgs {};

in

pkgs.mkShell {
  name = "dev-shell";
  buildInputs = [
    pkgs.nodejs
    pkgs.elmPackages.lamdera
    pkgs.elmPackages.elm-review
    pkgs.elmPackages.elm-format
  ];

}

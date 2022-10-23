let
  nixpkgs = builtins.fetchTarball {
    # https://status.nixos.org/ -> nixos-22.05 on 2022-10-23
    url = "https://github.com/nixos/nixpkgs/archive/3933d8bb9120573c0d8d49dc5e890cb211681490.tar.gz";
  };
  pkgs = import nixpkgs {};

in

pkgs.mkShell {
  name = "dev-shell";
  buildInputs = [
    pkgs.nodejs
  ];

}

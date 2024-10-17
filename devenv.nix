{ pkgs, inputs, ... }:

let
  pkgs-unstable = import inputs.nixpkgs-unstable { system = pkgs.stdenv.system; };
in
{
  packages = [
    pkgs.elmPackages.lamdera
    pkgs-unstable.elmPackages.elm-test-rs
    pkgs.nodejs
  ];

  languages.elm.enable = true;

  pre-commit.hooks = {
    actionlint.enable = true;
    check-added-large-files.enable = true;
    check-case-conflicts.enable = true;
    check-executables-have-shebangs.enable = true;
    check-merge-conflicts.enable = true;
    check-shebang-scripts-are-executable.enable = true;
    check-yaml.enable = true;
    typos.enable = true;
    deadnix.enable = true;
    detect-private-keys.enable = true;
    elm-format.enable = true;
    elm-review.enable = true;
    end-of-file-fixer.enable = true;
    html-tidy.enable = true;
    ripsecrets.enable = true;
    trim-trailing-whitespace.enable = true;

    shellcheck.enable = true;
    shellcheck.excludes = [".yml" ".yaml"];

    denofmt.enable = true;
    denofmt.excludes = ["elm.json" "review/elm.json"];
  };

  enterTest = ''
    npx elm-test-rs --compiler $(which lamdera)
  '';

}

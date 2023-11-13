# spellings
A simple Elm app to train word spellings.


# Developing

* You need nix and direnv.
* cd spellings
* npm install
* npm run build:css -- --watch
* lamdera live


TODO: Auto-deployed on each commit to `main` to https://spellings.lamdera.app/.


## Troubleshooting


### Something is wrong with commands in `package.json` and I need to run them manually.

You may need to prepend them with `npx`. For example, `npx elm make`.

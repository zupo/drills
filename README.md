# spellings

A simple Elm app I built to help my kids train word spellings for school.

Inspirations:
* https://github.com/lamdera/example-apps/
* https://github.com/supermario/lamdera-realworld/
* https://github.com/tristanpendergrass/shipgame/


# Develop

## Initial start

You need nix and direnv.

```console
$ cd spellings
$ npm install
$ lamdera live
```

## Tooling

* Auto-reload CSS changes: `npm run build:css -- --watch`
* Verify deployment: `lamdera check`
* CI: https://github.com/zupo/spellings/actions/workflows/ci.yml

## Deployment

TODO: Auto-deployed on each commit to `main` to https://spellings.lamdera.app/.


## Troubleshooting


### Something is wrong with commands in `package.json` and I need to run them manually

You may need to prepend them with `npx`. For example, `npx elm make`.

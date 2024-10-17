# spellings

A simple Elm app I built to help my kids train word spellings for school.

Inspirations:

- https://github.com/lamdera/example-apps/
- https://github.com/supermario/lamdera-realworld/
- https://github.com/tristanpendergrass/shipgame/

# Develop

## Initial start

You need [devenv](https://devenv.sh/) and [direnv](https://direnv.net/).

```console
$ cd spellings
$ lamdera live
```

## Tooling

- Auto-reload CSS changes: `npm run build:css -- --watch`
- Verify deployment: `lamdera check`
- Run tests & linters: `devenv test`
- CI: https://github.com/zupo/spellings/actions/workflows/ci.yml

## Deployment

Each commit to `main` is auto-deployed to https://spellings.lamdera.app/.

Each Pull Request gets a preview app at
https://spellings-<BRANCH_NAME>.lamdera.app/.

## Troubleshooting

### Something is wrong with commands in `package.json` and I need to run them manually

You may need to prepend them with `npx`. For example, `npx elm make`.

### Help with Lamdera types

https://github.com/jmpavlick/segakcap

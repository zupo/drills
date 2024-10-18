# spellings

A simple Elm app I built to help my kids train word spellings for school.

Inspirations:

- https://github.com/lamdera/example-apps/
- https://github.com/supermario/lamdera-realworld/
- https://github.com/tristanpendergrass/shipgame/
- https://github.com/kraklin/elm-land-lamdera-auth-tailwind-template

# Develop

## Initial start

You need [devenv](https://devenv.sh/) and [direnv](https://direnv.net/).

```console
$ cd spellings
$ devenv up
$ open http://localhost:8000
```

## Tooling

- TODO: Auto-reload CSS changes: `npm run build:css -- --watch`
- Run unit tests: `test`
- Run linters: `lint`
- Run all checks: `devenv test`
- Verify deployment: `lamdera check`
- CI: https://github.com/zupo/spellings/actions/workflows/ci.yml

## Deployment

Each commit to `main` is auto-deployed to https://spellings.lamdera.app/.

Each Pull Request gets a preview app at
https://spellings-<BRANCH_NAME>.lamdera.app/.

## Troubleshooting

### Help with Lamdera types

https://github.com/jmpavlick/segakcap

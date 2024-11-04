# Drills

A simple Elm app I built to help my kids do homework drills for school.

Inspirations:

- https://github.com/lamdera/example-apps/
- https://github.com/supermario/lamdera-realworld/
- https://github.com/tristanpendergrass/shipgame/
- https://github.com/kraklin/elm-land-lamdera-auth-tailwind-template

# Develop

## Initial start

You need [devenv](https://devenv.sh/) and [direnv](https://direnv.net/).

```console
$ cd drills
$ devenv up
$ open http://localhost:8000
```

## Tooling

- Run unit tests: `test`
- Run linters: `lint`
- Run all checks: `devenv test`
- Verify deployment: `lamdera check`
- CI: https://github.com/zupo/drills/actions/workflows/ci.yml
- Recommended VSCode extensions:
  - https://marketplace.visualstudio.com/items?itemName=elm-land.elm-land
    - `"elmLand.compilerFilepath": "lamdera",`
  - https://marketplace.visualstudio.com/items?itemName=bradlc.vscode-tailwindcss

## Deployment

Each commit to `main` is auto-deployed to https://drills.lamdera.app/.

Each Pull Request gets a preview app at
https://drills-<BRANCH_NAME>.lamdera.app/.

## Troubleshooting

### Creating Evergreen Migrations

Sometimes your PR's CI will fail with `UNIMPLEMENTED MIGRATION` error in the
`Lamdera Check` step. This means that you need to create a new migration for the
changes you've made:

```bash
$ git branch -D master
$ git checkout -b master
$ lamdera check
```

More info on https://dashboard.lamdera.app/docs/evergreen.

### Help with Lamdera types

https://github.com/jmpavlick/segakcap

TODO:

- randomize words
- leaderboard of best times

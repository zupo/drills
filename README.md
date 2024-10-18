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
$ open http://localhost:1234
```

## Tooling

- TODO: Auto-reload CSS changes: `npm run build:css -- --watch`
- Run unit tests: `test`
- Run linters: `lint`
- Run all checks: `devenv test`
- Verify deployment: `lamdera check`
- CI: https://github.com/zupo/drills/actions/workflows/ci.yml

## Deployment

Each commit to `main` is auto-deployed to https://drills.lamdera.app/.

Each Pull Request gets a preview app at
https://drills-<BRANCH_NAME>.lamdera.app/.

## Troubleshooting

### Help with Lamdera types

https://github.com/jmpavlick/segakcap

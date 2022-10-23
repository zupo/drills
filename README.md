# spellings
A simple Elm app to train word spellings.


# Developing

* You need nix and direnv.
* cd spellings
* npm install
* npm run start  # local dev (tailwind and elm-live server)
* npm run build  # build the CSS/HTML/JS files in public/ folder


Auto-deployed on each commit to `main` to https://spellings.netlify.app/.


## Troubleshooting


### Something is wrong with commands in `package.json` and I need to run them manually.

You need to prepend them with `npx`. For example, `npx elm make`.

# api-docs

Doxygen API reference for ps2build packages, published at https://api.ps2build.dev.

## How it works

A package repository sends a `docs-released` repository dispatch to this repo when it publishes a release. The workflow checks out that tag, builds the repository's `Doxyfile`, and publishes the HTML to the `gh-pages` branch under `<repo>/<tag>/` and `<repo>/latest/`. The five newest tags per repository are kept.

## Add a package

1. Add a `Doxyfile` to the package repository.
2. Add its name to `repos.txt`.
3. Add this step to the end of its release workflow:

```yaml
- name: Update API docs
  env:
    GH_TOKEN: ${{ secrets.MANIFEST_DISPATCH_TOKEN }}
  run: |
    gh api repos/ps2build/api-docs/dispatches \
      -f event_type=docs-released \
      -f 'client_payload[repo]=<package>' \
      -f "client_payload[tag]=$GITHUB_REF_NAME"
```

## Rebuild by hand

Run the "Build API docs" workflow from the Actions tab with the repository name and tag.

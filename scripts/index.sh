#!/bin/sh
# Prints the landing page for the site tree given as $1.
set -eu
root="$1"
cat <<'H'
<!doctype html>
<html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>PS2BUILD API reference</title>
<style>
body{font:16px/1.5 system-ui,sans-serif;max-width:46rem;margin:3rem auto;padding:0 1rem;color:#1d2433}
h1{font-size:1.6rem}h2{font-size:1.1rem;margin:1.6rem 0 .3rem}
a{color:#1d5b76}.v{margin-right:.8rem}
</style></head><body>
<h1>PS2BUILD API reference</h1>
<p>Generated from each package's latest release. <a href="https://ps2build.dev">Documentation</a></p>
H
for d in "$root"/*/; do
  name=$(basename "$d")
  [ -f "$d/latest/index.html" ] || continue
  printf '<h2>%s</h2>\n<a class="v" href="%s/latest/">latest</a>' "$name" "$name"
  ls -1 "$d" | grep -vx latest | sort -Vr | while read -r v; do
    printf '<a class="v" href="%s/%s/">%s</a>' "$name" "$v" "$v"
  done
  printf '\n'
done
echo '</body></html>'

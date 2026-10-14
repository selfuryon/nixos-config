# List flake.modules aspects: how many files define each one and which
# files import it. Aspects come from `nix eval`; usages are found by
# searching modules/ for `<class>.<name>` references and `with <class>; [ ... ]`
# lists, so a reference built some other way would show up as unused.
set -euo pipefail

cd "${PRJ_ROOT:-$(git rev-parse --show-toplevel)}"

aspects=$(nix eval --json .#modules --apply 'builtins.mapAttrs (_: builtins.attrNames)' 2>/dev/null)

# "<class>.<name> <file>:<line>" for every usage of an aspect.
usages=$(
  {
    # direct references, excluding definitions (flake.modules.<class>.<name>)
    rg --no-heading -n -o -P '(?<!modules\.)\b(nixos|homeManager)\.[\w-]+' modules |
      awk -F: '{ print $3, $1 ":" $2 }'
    # names listed in `with <class>; [ ... ]`
    rg -l -P 'with (nixos|homeManager);' modules | xargs awk '
      FNR == 1 { inlist = 0 }
      match($0, /with (nixos|homeManager);/) {
        class = substr($0, RSTART + 5, RLENGTH - 6); line = FNR; inlist = 1
        $0 = substr($0, RSTART + RLENGTH)
      }
      inlist {
        text = $0; done = sub(/\].*/, "", text)
        gsub(/#.*/, "", text); gsub(/[\[;]/, " ", text)
        n = split(text, words, /[[:space:]]+/)
        for (i = 1; i <= n; i++) if (words[i] != "") print class "." words[i], FILENAME ":" line
        if (done) inlist = 0
      }'
  } | sort -u
)

jq -r 'to_entries[] | .key as $c | .value[] | "\($c) \(.)"' <<<"$aspects" |
  while read -r class name; do
    defs=$({ rg -l -F "flake.modules.${class}.${name}" modules || true; } | wc -l)
    users=$(awk -v a="${class}.${name}" '$1 == a { print $2 }' <<<"$usages" | paste -sd ' ')
    printf '%s\t%s\t%s\t%s\n' "$class" "$name" "$defs" "${users:-UNUSED}"
  done |
  awk -F'\t' '
    $1 != prev { printf "%s%s\n", (NR > 1 ? "\n" : ""), $1; prev = $1 }
    { files = ($3 == 0 ? "?" : $3) " file" ($3 == 1 ? " " : "s")
      printf "  %-14s %-9s %s\n", $2, files, ($4 == "UNUSED" ? "UNUSED" : "<- " $4) }'

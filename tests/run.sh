#!/usr/bin/env bash
# Functional tests for sloth-bash. Run from repo root: bash tests/run.sh
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PASS=0
FAIL=0
failures=()

assert_eq() {
  local name="$1" expected="$2" actual="$3"
  if [[ "$expected" == "$actual" ]]; then
    PASS=$((PASS + 1))
    echo "  OK  $name"
  else
    FAIL=$((FAIL + 1))
    failures+=("$name: expected='$expected' actual='$actual'")
    echo "  FAIL $name (expected='$expected' actual='$actual')"
  fi
}

assert_ok() {
  local name="$1"; shift
  if "$@"; then
    PASS=$((PASS + 1))
    echo "  OK  $name"
  else
    FAIL=$((FAIL + 1))
    failures+=("$name")
    echo "  FAIL $name"
  fi
}

assert_fail() {
  local name="$1"; shift
  if "$@"; then
    FAIL=$((FAIL + 1))
    failures+=("$name (expected failure)")
    echo "  FAIL $name (expected failure)"
  else
    PASS=$((PASS + 1))
    echo "  OK  $name"
  fi
}

# Isolated home so alias-list / interactive bits stay quiet
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT
export HOME="$TMP"
mkdir -p "$HOME"
# Minimal alias-list so associative array exists
cat > "$HOME/.alias-list" <<'EOF'
declare -A FLATPAK_ALIASES=(
  [obs]="com.obsproject.Studio"
)
alias md='mkdir -p'
EOF

# Non-interactive source
# shellcheck source=/dev/null
source "$ROOT/sloth-bash"

WORKDIR=$(mktemp -d "$TMP/work-XXXX")
cd "$WORKDIR"

echo "== cd =="
mkdir -p nest/a/b
cd nest/a/b >/dev/null
cd ... >/dev/null
assert_eq "cd ... lands in nest" "$WORKDIR/nest" "$(pwd)"
cd "$WORKDIR" >/dev/null
cd >/dev/null
assert_eq "cd with no args goes HOME" "$HOME" "$(pwd)"
cd "$WORKDIR" >/dev/null

echo "== executables / python =="
printf '#!/bin/sh\necho RAN_REL\n' > rel.sh
chmod +x rel.sh
out=$(command_not_found_handle rel.sh)
assert_eq "relative executable runs" "RAN_REL" "$out"

printf '#!/bin/sh\necho RAN_ABS\n' > "$WORKDIR/abs.sh"
chmod +x "$WORKDIR/abs.sh"
out=$(command_not_found_handle "$WORKDIR/abs.sh")
assert_eq "absolute executable runs" "RAN_ABS" "$out"

mkdir -p pyproj/venv/bin
printf '#!/bin/sh\necho VENV_PY "$@"\n' > pyproj/venv/bin/python3
chmod +x pyproj/venv/bin/python3
printf 'print("hi")\n' > pyproj/script.py
# poison activate to detect accidental source
printf 'export VIRTUAL_ENV=LEAKED\necho ACTIVATED\n' > pyproj/venv/bin/activate
unset VIRTUAL_ENV || true
out=$(command_not_found_handle pyproj/script.py)
assert_eq "py uses venv python without activate" "VENV_PY pyproj/script.py" "$out"
assert_eq "VIRTUAL_ENV not leaked" "" "${VIRTUAL_ENV:-}"

status=0
command_not_found_handle pyproj/missing.py >/dev/null 2>&1 || status=$?
assert_eq "missing py returns 127" "127" "$status"
assert_eq "missing py does not leak venv" "" "${VIRTUAL_ENV:-}"

echo "== case-insensitive exact match =="
# Should find 'true' via True (builtin/command)
out=$(command_not_found_handle True && echo ok)
assert_eq "True resolves to true" "ok" "$out"
# Regex metachar must NOT match everything
status=0
command_not_found_handle '.*' >/dev/null 2>&1 || status=$?
assert_eq "regex metachar is not a command" "127" "$status"

echo "== rd (rmdir) =="
mkdir empty_dir
rd empty_dir
assert_fail "empty_dir removed" test -d empty_dir

mkdir -p full_dir/nested
echo x > full_dir/nested/f
status=0
rd full_dir >/dev/null 2>&1 || status=$?
assert_ok "rd refuses non-empty" test "$status" -ne 0
assert_ok "non-empty dir still there" test -d full_dir

status=0
rd definitely-missing >/dev/null 2>&1 || status=$?
assert_ok "rd missing is non-zero" test "$status" -ne 0

mkdir e1 e2
# only empties succeed; non-empty dirs in cwd make rd all return non-zero
status=0
rd all >/dev/null 2>&1 || status=$?
assert_fail "rd all removed e1" test -d e1
assert_fail "rd all removed e2" test -d e2
assert_ok "rd all left full_dir" test -d full_dir
assert_ok "rd all non-zero when some fail" test "$status" -ne 0

echo "== cp =="
echo hello > cfile
mkdir -p cdest
cp cfile cdest/cfile
assert_eq "cp file content" "hello" "$(cat cdest/cfile)"

mkdir csrc
echo x > csrc/f
status=0
cp csrc cdest2 >/dev/null 2>&1 || status=$?
assert_ok "cp dir without -r fails" test "$status" -ne 0
assert_fail "cp did not invent cdest2 tree" test -e cdest2

echo target > realfile
ln -s realfile linkfile
mkdir copydest
cp linkfile copydest/
# GNU cp without -P follows symlink by default on Linux for file content
assert_ok "cp symlink produced a file" test -f copydest/linkfile

echo "== mv =="
echo a > rename-me
mv rename-me renamed
assert_ok "same-dir rename" test -f renamed
assert_fail "old name gone" test -e rename-me

mkdir -p srcA/sub other
echo hello > srcA/sub/file.txt
mv srcA/sub other/
assert_ok "mv dir completed" test -f other/sub/file.txt
assert_fail "mv dir left no empty source" test -e srcA/sub

mkdir -p a b
echo hello > a/f
mv a/f b/f
assert_ok "mv file across dirs" test -f b/f
assert_fail "mv file removed source" test -e a/f

echo "== all / rm =="
# Expand 'all' into concrete paths then remove without relying on rm -i / tty
mkdir -p onlyfiles
cd onlyfiles >/dev/null
echo 1 > one
echo 2 > two
mapfile -d '' -t expanded < <(_expand_all_keyword all)
assert_eq "all expands 2 entries" "2" "${#expanded[@]}"
command rm -f -- "${expanded[@]}"
assert_fail "rm all removed one" test -e one
assert_fail "rm all removed two" test -e two
cd "$WORKDIR" >/dev/null

echo "== mkcd / take =="
mkcd taken_dir >/dev/null
assert_eq "mkcd enters dir" "$WORKDIR/taken_dir" "$(pwd)"
cd "$WORKDIR" >/dev/null

mkdir -p payload
echo hi > payload/inside.txt
tar -czf sample.tar.gz payload
take sample.tar.gz >/dev/null
assert_ok "take local archive cds into content" test -f inside.txt
assert_fail "no double-wrapped payload" test -d payload
cd "$WORKDIR" >/dev/null
assert_ok "promoted payload dir remains" test -f payload/inside.txt
assert_fail "archive consumed" test -e sample.tar.gz

echo "== helpers =="
assert_ok "same filesystem detects self" _sloth_same_filesystem "$WORKDIR" "$WORKDIR/renamed"
out=$(_sloth_find_ci_command LS)
assert_eq "find_ci_command finds ls" "ls" "$out"

echo "== install.sh syntax =="
assert_ok "install.sh bash -n" bash -n "$ROOT/install.sh"
assert_ok "sloth-bash bash -n" bash -n "$ROOT/sloth-bash"

echo
echo "Passed: $PASS  Failed: $FAIL"
if [[ $FAIL -gt 0 ]]; then
  printf '  - %s\n' "${failures[@]}"
  exit 1
fi
exit 0

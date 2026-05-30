#!/usr/bin/env zsh
# title: palindrome
# description: Palindrome check in Bash/zsh — readable, shortest, and cultural examples
# author: tonimaxx
# repo: https://github.com/tonimaxx/tonisnippets

# --- Clean helper (ASCII-safe) ---
clean() {
  echo "$1" | tr '[:upper:]' '[:lower:]' | tr -cd '[:alnum:]'
}

# --- Readable ---
is_palindrome() {
  local t
  t=$(clean "$1")
  local r
  r=$(echo "$t" | rev)
  [[ "$t" == "$r" ]]
}

# --- Shortest (zsh one-liner) ---
# p() { local t=$(clean "$1"); [[ $t == $(rev<<<$t) ]]; }

# Note: `rev` reverses byte order, not Unicode runes.
# Works for ASCII palindromes. For full Unicode, use Python or Ruby.

# --- Cultural examples ---
examples=(
  "racecar:English"
  "A man a plan a canal Panama:English classic"
  "racecar:English"
  "Malayalam:India — the language name itself"
  "Anita lava la tina:Spanish — Anita washes the tub"
)

# Unicode examples (display only — rev handles bytes, not runes)
unicode_examples=(
  "우영우:Korean — Woo Young-woo"
  "기러기:Korean — wild goose"
  "たけやぶやけた:Japanese — the bamboo grove burned"
  "ยาย:Thai — grandmother"
)

echo "=== ASCII palindromes ==="
for entry in "${examples[@]}"; do
  text="${entry%%:*}"
  label="${entry#*:}"
  if is_palindrome "$text"; then
    echo "  ✓  $label: $text"
  else
    echo "  ✗  $label: $text"
  fi
done

echo ""
echo "=== Unicode palindromes (display only — use Python for accurate check) ==="
for entry in "${unicode_examples[@]}"; do
  text="${entry%%:*}"
  label="${entry#*:}"
  echo "  ?  $label: $text"
done

# Palindrome

## A love letter to the question that outlived the interview

Back when I was at Google, a close friend of mine — a recruiter who had pulled me in there — would regularly call me to help prep candidates. Not formal training. Just "hey, can you talk to a few people this week?" And almost every time, without fail, one question came up in those sessions:

*"How do you check if a string is a palindrome?"*

It was the perfect warm-up question. Simple enough that a nervous candidate could breathe. Rich enough to show how they think — do they reach for a language shortcut, or do they build it from first principles? Do they handle edge cases without being asked?

That was before the AI era. Before you could ask a model to write it in 50 languages in 10 seconds. Before palindrome became a running joke in tech interviews precisely because everyone had memorized the answer.

But here's what made those conversations genuinely interesting: the cultural angle. When I'd ask candidates to think of a real-world palindrome, the answers were a window into where they came from. A Korean developer immediately said 우영우. A candidate from Kerala said "Malayalam — the language itself is a palindrome." Someone from Shanghai wrote 上海自来水来自海上 on the whiteboard without blinking.

*That's* the part that no AI answer captures. So this collection is both a technical reference and a small cultural archive.

---

## What is a palindrome?

A string that reads the same forwards and backwards.

`racecar` → `racecar` reversed → same. Palindrome.

When you ignore spaces and case: `"A man a plan a canal Panama"` → strip and lowercase → `amanaplanacanalpanama` → same reversed. Palindrome.

---

## Cultural Palindromes

### English
`racecar` — the classic single word
`Never odd or even` — reads same ignoring spaces
`A man, a plan, a canal: Panama` — the most famous, referencing the canal's construction
`Was it a car or a cat I saw` — elegant

### Korean 한국어
`우영우` — Woo Young-woo (우-영-우), the brilliant lawyer from the hit drama *Extraordinary Attorney Woo*. The character's name was deliberately chosen as a palindrome — her father explains it in the show as something special, something that works both ways, just like her.
`기러기` — wild goose (기-러-기)
`토마토` — tomato (borrowed word, but palindrome in Korean script)
`수박이박수` — watermelon is applause

### Japanese 日本語
`たけやぶやけた` — "the bamboo grove burned" (ta-ke-ya-bu-ya-ke-ta) — one of the most cited Japanese palindromes
`トマト` — tomato, same as Korean
`やや` — a little / somewhat

### Chinese 中文
`上海自来水来自海上` — "Shanghai's tap water comes from Shanghai" — a classical Chinese palindrome that also makes complete grammatical sense, which is rare and beautiful
`人过大佛寺，寺佛大过人` — "People pass the great Buddha temple, the temple Buddha is greater than people"

### Thai ภาษาไทย
`ยาย` — grandmother (ย-า-ย) — the simplest and most elegant
Thai palindromes are genuinely rare due to the tonal and script structure of the language, which makes `ยาย` all the more delightful as a palindrome that every Thai child knows.

### Hindi / Sanskrit
`नयन` — nayan, meaning *eye* — poetic in both meaning and form
`कनक` — kanak, meaning *gold*
`Malayalam` — the South Indian language name itself is a perfect palindrome (m-a-l-a-y-a-l-a-m). This one always gets a reaction.

### Spanish
`Anita lava la tina` — "Anita washes the tub" — flows naturally in speech
`Yo soy` — I am (short but satisfying)

### French
`Élu par cette crapule` — "Elected by this scoundrel" — a bitter political palindrome that has aged well

### Arabic
`داد` — dad (father in some dialects) — d-a-d, same across cultures

---

## The Two Versions That Matter

Every language file in this folder has two implementations:

**Readable** — for understanding, interviews, teaching. Clear variable names, explicit steps.

**Shortest** — one-liner code golf. For fun, for showing language idioms, for the "wait, you can do that?" moment.

Both handle: lowercase normalization, strip spaces and punctuation, Unicode support.

---

## Shortest implementations by language

| Language | One-liner | Chars |
|---|---|---|
| Python | `s==s[::-1]` (after clean) | ~12 |
| Ruby | `s==s.reverse` | 13 |
| Swift | `s==String(s.reversed())` | 24 |
| JavaScript | `s===[...s].reverse().join('')` | 30 |
| PHP | `$s==strrev($s)` | 15 |
| Bash | `[[ $s == $(rev<<<$s) ]]` | 22 |
| Go | requires loop (no built-in reverse) | ~80 |
| Java | requires loop or StringBuilder | ~60 |

Python and Ruby win. Go and Java remind you that brevity is a language feature, not a given.

---

## Files in this folder

| File | Language |
|---|---|
| `palindrome.py` | Python |
| `palindrome.js` | JavaScript |
| `palindrome.rb` | Ruby |
| `palindrome.go` | Go |
| `palindrome.sh` | Bash/zsh |
| `palindrome.java` | Java |
| `palindrome.php` | PHP |
| `palindrome.swift` | Swift |

---

*Some things don't need to be useful to be worth keeping. This is one of them.*

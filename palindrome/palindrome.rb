# title: palindrome
# description: Palindrome check in Ruby — readable, shortest, and cultural examples
# author: tonimaxx
# repo: https://github.com/tonimaxx/tonisnippets

# --- Clean helper ---
def clean(s)
  s.downcase.gsub(/[^\p{L}\p{N}]/, '')
end

# --- Readable ---
def palindrome?(s)
  t = clean(s)
  t == t.reverse
end

# --- Shortest (Ruby wins this category) ---
p = ->(s) { (t = clean(s)) == t.reverse }

# --- Absolute shortest (no cleaning) ---
f = ->(s) { s == s.reverse }

# --- Cultural examples ---
examples = [
  ["racecar",                     "English"],
  ["A man a plan a canal Panama", "English classic"],
  ["Never odd or even",           "English"],
  ["우영우",                       "Korean — Woo Young-woo (Extraordinary Attorney Woo)"],
  ["기러기",                       "Korean — wild goose"],
  ["たけやぶやけた",                "Japanese — the bamboo grove burned"],
  ["上海自来水来自海上",             "Chinese — Shanghai's tap water comes from Shanghai"],
  ["ยาย",                         "Thai — grandmother"],
  ["नयन",                         "Hindi — eye"],
  ["Malayalam",                   "India — the language name itself"],
  ["Anita lava la tina",          "Spanish — Anita washes the tub"],
]

examples.each do |text, label|
  result = palindrome?(text) ? "✓" : "✗"
  puts "  #{result}  #{label}: #{text}"
end

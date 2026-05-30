// title: palindrome
// description: Palindrome check in JavaScript — readable, shortest, and cultural examples
// author: tonimaxx
// repo: https://github.com/tonimaxx/tonisnippets

// --- Clean helper ---
const clean = s => s.toLowerCase().replace(/[^a-z0-9À-ɏ가-힣぀-ヿ一-鿿ऀ-ॿ฀-๿]/gi, '')

// --- Readable ---
function isPalindrome(s) {
  const t = clean(s)
  return t === t.split('').reverse().join('')
}

// --- Shortest ---
const p = s => (t => t === [...t].reverse().join(''))(clean(s))

// --- Absolute shortest (no cleaning) ---
const f = s => s === [...s].reverse().join('')

// --- Cultural examples ---
const examples = [
  ["racecar",                     "English"],
  ["A man a plan a canal Panama", "English classic"],
  ["Never odd or even",           "English"],
  ["우영우",                       "Korean — Woo Young-woo (Extraordinary Attorney Woo)"],
  ["기러기",                       "Korean — wild goose"],
  ["토마토",                       "Korean — tomato"],
  ["たけやぶやけた",                "Japanese — the bamboo grove burned"],
  ["トマト",                       "Japanese — tomato"],
  ["上海自来水来自海上",             "Chinese — Shanghai's tap water comes from Shanghai"],
  ["ยาย",                         "Thai — grandmother"],
  ["नयन",                         "Hindi — eye"],
  ["Malayalam",                   "India — the language name itself"],
  ["Anita lava la tina",          "Spanish — Anita washes the tub"],
]

examples.forEach(([text, label]) => {
  const result = isPalindrome(text) ? "✓" : "✗"
  console.log(`  ${result}  ${label}: ${text}`)
})

// title: palindrome
// description: Palindrome check in Swift — readable, shortest, and cultural examples
// author: tonimaxx
// repo: https://github.com/tonimaxx/tonisnippets

import Foundation

// --- Clean helper (Unicode-safe) ---
func clean(_ s: String) -> String {
    s.lowercased()
     .unicodeScalars
     .filter { CharacterSet.alphanumerics.contains($0) }
     .map { String($0) }
     .joined()
}

// --- Readable ---
func isPalindrome(_ s: String) -> Bool {
    let t = clean(s)
    return t == String(t.reversed())
}

// --- Shortest ---
let p: (String) -> Bool = { s in
    let t = clean(s); return t == String(t.reversed())
}

// --- Absolute shortest (no cleaning) ---
let f: (String) -> Bool = { $0 == String($0.reversed()) }

// --- Cultural examples ---
let examples: [(String, String)] = [
    ("racecar",                     "English"),
    ("A man a plan a canal Panama", "English classic"),
    ("Never odd or even",           "English"),
    ("우영우",                        "Korean — Woo Young-woo (Extraordinary Attorney Woo)"),
    ("기러기",                        "Korean — wild goose"),
    ("たけやぶやけた",                 "Japanese — the bamboo grove burned"),
    ("上海自来水来自海上",              "Chinese — Shanghai's tap water comes from Shanghai"),
    ("ยาย",                          "Thai — grandmother"),
    ("नयन",                          "Hindi — eye"),
    ("Malayalam",                   "India — the language name itself"),
    ("Anita lava la tina",          "Spanish — Anita washes the tub"),
]

for (text, label) in examples {
    let mark = isPalindrome(text) ? "✓" : "✗"
    print("  \(mark)  \(label): \(text)")
}

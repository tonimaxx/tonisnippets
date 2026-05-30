// title: palindrome
// description: Palindrome check in Go — readable, shortest, and cultural examples
// author: tonimaxx
// repo: https://github.com/tonimaxx/tonisnippets

package main

import (
	"fmt"
	"strings"
	"unicode"
)

// clean lowercases and strips non-alphanumeric runes (Unicode-safe)
func clean(s string) string {
	var b strings.Builder
	for _, r := range strings.ToLower(s) {
		if unicode.IsLetter(r) || unicode.IsDigit(r) {
			b.WriteRune(r)
		}
	}
	return b.String()
}

// reverse reverses a Unicode string rune by rune
func reverse(s string) string {
	runes := []rune(s)
	for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
		runes[i], runes[j] = runes[j], runes[i]
	}
	return string(runes)
}

// --- Readable ---
func isPalindrome(s string) bool {
	t := clean(s)
	return t == reverse(t)
}

// Go has no built-in reverse — this is intentional.
// It reminds you that brevity is a language feature, not a given.
// The readable version IS the idiomatic version here.

func main() {
	examples := [][2]string{
		{"racecar",                     "English"},
		{"A man a plan a canal Panama", "English classic"},
		{"Never odd or even",           "English"},
		{"우영우",                        "Korean — Woo Young-woo (Extraordinary Attorney Woo)"},
		{"기러기",                        "Korean — wild goose"},
		{"たけやぶやけた",                 "Japanese — the bamboo grove burned"},
		{"上海自来水来自海上",              "Chinese — Shanghai's tap water comes from Shanghai"},
		{"ยาย",                          "Thai — grandmother"},
		{"नयन",                          "Hindi — eye"},
		{"Malayalam",                   "India — the language name itself"},
		{"Anita lava la tina",          "Spanish — Anita washes the tub"},
	}

	for _, e := range examples {
		mark := "✗"
		if isPalindrome(e[0]) {
			mark = "✓"
		}
		fmt.Printf("  %s  %s: %s\n", mark, e[1], e[0])
	}
}

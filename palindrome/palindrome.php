<?php
// title: palindrome
// description: Palindrome check in PHP — readable, shortest, and cultural examples
// author: tonimaxx
// repo: https://github.com/tonimaxx/tonisnippets

// --- Clean helper (Unicode-safe via mb_ functions) ---
function clean(string $s): string {
    $s = mb_strtolower($s, 'UTF-8');
    $s = preg_replace('/[^\p{L}\p{N}]/u', '', $s);
    return $s;
}

// --- Readable ---
function isPalindrome(string $s): bool {
    $t = clean($s);
    return $t === strrev_unicode($t);
}

// PHP strrev() is byte-based — use this for Unicode
function strrev_unicode(string $s): string {
    preg_match_all('/./us', $s, $matches);
    return implode('', array_reverse($matches[0]));
}

// --- Shortest (ASCII only) ---
// $p = fn($s) => ($t = clean($s)) === strrev($t);  // ASCII only

// --- Cultural examples ---
$examples = [
    ["racecar",                     "English"],
    ["A man a plan a canal Panama", "English classic"],
    ["Never odd or even",           "English"],
    ["우영우",                        "Korean — Woo Young-woo (Extraordinary Attorney Woo)"],
    ["기러기",                        "Korean — wild goose"],
    ["たけやぶやけた",                 "Japanese — the bamboo grove burned"],
    ["上海自来水来自海上",              "Chinese — Shanghai's tap water comes from Shanghai"],
    ["ยาย",                          "Thai — grandmother"],
    ["नयन",                          "Hindi — eye"],
    ["Malayalam",                   "India — the language name itself"],
    ["Anita lava la tina",          "Spanish — Anita washes the tub"],
];

foreach ($examples as [$text, $label]) {
    $mark = isPalindrome($text) ? "✓" : "✗";
    echo "  {$mark}  {$label}: {$text}\n";
}

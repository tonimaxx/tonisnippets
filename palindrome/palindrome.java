// title: palindrome
// description: Palindrome check in Java — readable, shortest, and cultural examples
// author: tonimaxx
// repo: https://github.com/tonimaxx/tonisnippets

public class palindrome {

    // --- Clean helper (Unicode-safe) ---
    static String clean(String s) {
        return s.toLowerCase()
                .codePoints()
                .filter(Character::isLetterOrDigit)
                .collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append)
                .toString();
    }

    // --- Readable ---
    static boolean isPalindrome(String s) {
        String t = clean(s);
        return t.equals(new StringBuilder(t).reverse().toString());
    }

    // --- Shortest (still needs StringBuilder — Java has no built-in reverse) ---
    // static boolean p(String s){String t=clean(s);return t.equals(new StringBuilder(t).reverse().toString());}

    public static void main(String[] args) {
        String[][] examples = {
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
        };

        for (String[] e : examples) {
            System.out.printf("  %s  %s: %s%n",
                isPalindrome(e[0]) ? "✓" : "✗", e[1], e[0]);
        }
    }
}

# title: palindrome
# description: Palindrome check in Python — readable, shortest, and cultural examples
# author: tonimaxx
# repo: https://github.com/tonimaxx/tonisnippets

import unicodedata

def clean(s: str) -> str:
    """Lowercase, strip spaces and punctuation, normalize unicode."""
    return ''.join(
        c.lower() for c in unicodedata.normalize('NFC', s)
        if c.isalnum()
    )

# --- Readable ---
def is_palindrome(s: str) -> bool:
    t = clean(s)
    return t == t[::-1]

# --- Shortest (after cleaning) ---
p = lambda s: (t := clean(s)) == t[::-1]

# --- Absolute shortest (no cleaning, ASCII only) ---
f = lambda s: s == s[::-1]

# --- Cultural examples ---
examples = [
    ("racecar",                    "English"),
    ("A man a plan a canal Panama","English classic"),
    ("Never odd or even",          "English"),
    ("우영우",                      "Korean — Woo Young-woo (Extraordinary Attorney Woo)"),
    ("기러기",                      "Korean — wild goose"),
    ("토마토",                      "Korean — tomato"),
    ("たけやぶやけた",               "Japanese — the bamboo grove burned"),
    ("トマト",                      "Japanese — tomato"),
    ("上海自来水来自海上",            "Chinese — Shanghai's tap water comes from Shanghai"),
    ("ยาย",                        "Thai — grandmother"),
    ("नयन",                        "Hindi — eye"),
    ("Malayalam",                  "India — the language name itself"),
    ("Anita lava la tina",         "Spanish — Anita washes the tub"),
    ("Élu par cette crapule",      "French — elected by this scoundrel"),
]

if __name__ == "__main__":
    for text, label in examples:
        result = "✓" if is_palindrome(text) else "✗"
        print(f"  {result}  {label}: {text}")

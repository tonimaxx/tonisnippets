# shellman

A lightweight CLI for managing custom zsh shell functions stored in `~/.zsh_functions`.

Write a function once, give it a name, use it forever — from the terminal or via Claude Code's `/shellman` skill.

---

## Setup

**1. Copy the functions file**

```zsh
curl -o ~/.zsh_functions https://raw.githubusercontent.com/tonimaxx/tonisnippets/main/shell/dev-process-manager.zsh
```

Or copy manually from [`dev-process-manager.zsh`](./dev-process-manager.zsh).

**2. Source it from `~/.zshrc`**

```zsh
# Custom shell functions (managed by shellman)
source ~/.zsh_functions
```

**3. Install the shellman CLI**

Download [`shellman`](./shellman) to somewhere in your `$PATH`:

```zsh
curl -o ~/.local/bin/shellman https://raw.githubusercontent.com/tonimaxx/tonisnippets/main/shell/shellman
chmod +x ~/.local/bin/shellman
```

**4. Reload**

```zsh
source ~/.zshrc
```

---

## CLI Commands

```
shellman list              Show all functions with descriptions
shellman show <name>       Print full source of a function
shellman new <name>        Scaffold and add a new function (interactive)
shellman edit <name>       Open function in $EDITOR
shellman delete <name>     Remove a function (with confirmation)
shellman sync              Push ~/.zsh_functions to GitHub
shellman reload            Print the source ~/.zshrc reminder
shellman help              Show usage
```

---

## Included Functions

| Function | Description |
|---|---|
| `auditdev` | List running dev servers — Expo, Node, Python, ports. `--all` includes MCP servers. |
| `auditmcp` | List Claude Code MCP background servers with PID and count. |
| `killexpo` | Kill all running Expo and Metro bundler processes. |
| `killnode` | Kill all running Node and Nodemon processes. |
| `killport <port>` | Kill whatever process is holding a specific port. |

---

## Function File Convention

All functions live in `~/.zsh_functions`. Each function requires a `# description:` comment on the line immediately before its definition — this powers `shellman list`.

```zsh
# description: One-line summary shown by shellman list.
myfunc() {
  # body
}
```

---

## Claude Code Skill

If you use Claude Code, the `/shellman` skill mirrors all CLI commands — useful when you want Claude to scaffold or edit functions for you.

Skill file: `~/.claude/skills/shellman/SKILL.md`

---

## Related

- Full article: [Shell Functions From Scratch — Medium](https://medium.com/)
- All snippets: [tonimaxx/tonisnippets](https://github.com/tonimaxx/tonisnippets)

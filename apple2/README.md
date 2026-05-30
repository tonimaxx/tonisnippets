# Apple II — The Shortest Game

## Before school had computers, we had a group

This was early. Too early for computers to be in classrooms. A small group of kids had found each other the way kids find each other around anything unusual — word of mouth, curiosity, showing up at the same place. Someone's older brother had an Apple II. Someone else had access to one at a shop that sold them. We gathered.

There were no formal lessons. Nobody was teaching us. We were reading manuals, sharing printouts, copying programs by hand from magazines. The machine was a mystery and the mystery was the point.

At some point someone said: let's see who can write the shortest working game.

The rules were loose. It had to run. It had to be a game. It had to be as short as possible.

---

## AppleSoft BASIC and the colon trick

AppleSoft BASIC — the Microsoft-developed BASIC that Apple II shipped with — required line numbers. Every line started with a number: 10, 20, 30. You pressed Return after each one. The interpreter executed them in order.

What most beginners didn't know was the colon.

You could chain multiple statements on a single line using `:` as a separator. This wasn't just a style choice — it was the key to the whole competition. One line number. Everything after it. As long as it ran.

```
10 HOME:X=20:Y=12:DX=1:DY=0
```

That's one line. Four assignments. In the competition, that wasn't impressive enough. The goal was one line number and everything — the entire game — after the colon.

---

## The game: snake with a V

The game I remember most was a snake-style game. Not the modern smooth snake — a text-mode snake where the head was the letter `V` and the trail it left behind marked where it had been.

The playing field was plain ASCII characters. A border. Spaces inside. You pressed arrow keys to steer the V through the open path. The longer you survived without hitting the wall or your own trail, the better your score.

It sounds simple. It was simple. That was the challenge — fitting something that felt like a real game into as few characters as possible, chained together with colons on one line.

Arrow keys in AppleSoft BASIC came back as specific character codes from `GET K$`:
- Left: `CHR$(8)`
- Right: `CHR$(21)`
- Up: `CHR$(11)`
- Down: `CHR$(10)`

`VTAB` and `HTAB` positioned the cursor. `POKE` could write characters directly to screen memory if you really wanted speed. `PEEK` could read what was already there — that was how you detected a collision. If the position you were about to move into didn't contain a space, you'd hit something.

The code files here show both versions: the readable multi-line version that explains how it works, and the compressed one-liner competition form.

---

## Assembly: talking directly to the machine

At some point BASIC wasn't enough. The group started learning 6502 assembly.

The Apple II's processor was the MOS 6502 — an 8-bit chip running at about 1 MHz. Assembly meant writing the actual instructions the processor executed, one by one. No interpreter. No safety net. You wrote to memory addresses directly.

The screen text memory on the Apple II started at address `$0400`. If you wanted to draw a character at a specific position on screen, you calculated the memory address and wrote the character's ASCII value there — with the high bit set, which was how the Apple II represented normal display characters.

Keyboard input lived at `$C000`. You'd loop checking that address until bit 7 went high, which meant a key had been pressed. Then you'd clear the strobe at `$C010` and look at what character code came back.

The shortest assembly game was a different kind of challenge from BASIC. You weren't counting colons. You were counting bytes. Every instruction had a size — one byte, two bytes, three bytes. The competition was: how few bytes could you use and still have something that ran and responded and felt like a game.

This is the file that I can only partially reconstruct from memory. The structure is right. The instructions are real 6502. The addresses are correct for Apple II text mode. But I won't pretend I remember the exact bytes I wrote as a kid. What I remember is the feeling — that moment when the V appeared on screen and moved when I pressed a key, and I had made that happen at the closest possible level to the hardware.

---

## What this was really about

Looking back, the competition wasn't about games. It was about constraints.

When you have infinite lines and infinite characters, you don't think carefully. When you have one line and a colon, you think about every character. You combine things. You find the minimum. You discover that a variable can serve two purposes, that a single PEEK can replace an entire IF block, that the right structure makes everything else smaller.

That instinct — find the smallest version of the thing that still works — never left. I've seen it in every good programmer I've worked with since, from those group sessions on an Apple II to engineering floors at some of the largest tech companies in the world.

The snake game was a few hundred characters of BASIC and maybe 50 bytes of assembly.

It was also the beginning of everything.

---

## Files in this folder

| File | Contents |
|---|---|
| `shortest-game.bas` | AppleSoft BASIC — readable version + one-liner competition form |
| `6502.asm` | 6502 Assembly — annotated snake movement for Apple II text mode |

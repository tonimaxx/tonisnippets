; 6502 Assembly — Snake Head Movement for Apple II Text Mode
; author: tonimaxx
; repo: https://github.com/tonimaxx/tonisnippets
;
; Assembler: Merlin 8 / S-C Assembler (era-accurate)
; Run on:    AppleWin emulator with DOS 3.3
;
; ============================================================
; Apple II Memory Map (what matters here)
; ============================================================
;
; Text Screen Page 1:  $0400 - $07FF  (1024 bytes, non-linear)
; Keyboard Register:   $C000          (bit 7 set = key waiting)
; Keyboard Strobe:     $C010          (read/write to clear)
; Zero Page:           $00-$FF        (fast 2-cycle access)
;
; Screen layout is NON-LINEAR on the Apple II.
; Rows don't sit at neat $0400 + (row * 40) offsets.
; The actual row base addresses are:
;
;   Row 0:  $0400   Row 8:  $0428   Row 16: $0450
;   Row 1:  $0480   Row 9:  $04A8   Row 17: $04D0
;   Row 2:  $0500   Row 10: $0528   Row 18: $0550
;   Row 3:  $0580   Row 11: $05A8   Row 19: $05D0
;   Row 4:  $0600   Row 12: $0628   Row 20: $0650
;   Row 5:  $0680   Row 13: $06A8   Row 21: $06D0
;   Row 6:  $0700   Row 14: $0728   Row 22: $0750
;   Row 7:  $0780   Row 15: $07A8   Row 23: $07D0
;
; Characters display with high bit SET ($80 OR'd in)
; So 'V' (ASCII $56) becomes $D6 on screen
; Space ($20) becomes $A0 — used to clear / detect empty cell
;
; ============================================================
; Zero Page variables (fastest memory on 6502)
; ============================================================

XPOS    EQU  $06        ; snake head X position (0-39)
YPOS    EQU  $07        ; snake head Y position (0-23)
DX      EQU  $08        ; X direction: $01=right, $FF=left, $00=none
DY      EQU  $09        ; Y direction: $01=down,  $FF=up,   $00=none
SCRLO   EQU  $0A        ; screen address low byte (calculated)
SCRHI   EQU  $0B        ; screen address high byte

; ============================================================
; ROM routines we borrow
; ============================================================

HOME    EQU  $FC58      ; clear screen
COUT    EQU  $FDED      ; output character in A to screen
VTAB    EQU  $FC22      ; set vertical position (CV=$25)
CV      EQU  $25        ; cursor vertical (zero page)
CH      EQU  $24        ; cursor horizontal (zero page)

; Key codes (Apple II with high bit stripped)
KEY_LEFT  EQU $08
KEY_RIGHT EQU $15
KEY_UP    EQU $0B
KEY_DOWN  EQU $0A

KYBD    EQU  $C000
KSTB    EQU  $C010

; ============================================================
; Program start
; ============================================================

        ORG  $0800      ; load at $0800 (safe area, above BASIC)

INIT:
        JSR  HOME       ; clear screen

        LDA  #20
        STA  XPOS       ; start X = 20 (center-ish)
        LDA  #12
        STA  YPOS       ; start Y = 12 (middle row)
        LDA  #$01
        STA  DX         ; initial direction: right
        LDA  #$00
        STA  DY

; ============================================================
; DRAW_HEAD — place 'V' at (XPOS, YPOS)
; ============================================================

DRAW_HEAD:
        LDA  YPOS
        STA  CV         ; set cursor row
        LDA  XPOS
        STA  CH         ; set cursor column
        LDA  #$D6       ; 'V' with high bit set ($56 OR $80)
        JSR  COUT       ; draw it

; ============================================================
; WAIT_KEY — poll $C000 until bit 7 is set
; ============================================================

WAIT_KEY:
        LDA  KYBD       ; read keyboard
        BPL  WAIT_KEY   ; bit 7 clear = no key yet, keep looping
        STA  KSTB       ; clear the strobe (acknowledge keypress)
        AND  #$7F       ; strip high bit to get clean ASCII

; ============================================================
; HANDLE_INPUT — set DX/DY based on key pressed
; ============================================================

        CMP  #KEY_LEFT
        BNE  CHK_RIGHT
        LDA  #$FF       ; $FF = -1 in unsigned byte = move left
        STA  DX
        LDA  #$00
        STA  DY
        JMP  MOVE

CHK_RIGHT:
        CMP  #KEY_RIGHT
        BNE  CHK_UP
        LDA  #$01
        STA  DX
        LDA  #$00
        STA  DY
        JMP  MOVE

CHK_UP:
        CMP  #KEY_UP
        BNE  CHK_DOWN
        LDA  #$00
        STA  DX
        LDA  #$FF       ; $FF = -1 = move up
        STA  DY
        JMP  MOVE

CHK_DOWN:
        CMP  #KEY_DOWN
        BNE  MOVE       ; unknown key — just move in current direction
        LDA  #$00
        STA  DX
        LDA  #$01
        STA  DY

; ============================================================
; MOVE — leave trail dot, advance position
; ============================================================

MOVE:
        LDA  YPOS       ; position cursor at current head
        STA  CV
        LDA  XPOS
        STA  CH
        LDA  #$AE       ; '.' with high bit set ($2E OR $80) — trail
        JSR  COUT       ; write trail character

        ; advance X
        LDA  XPOS
        CLC
        ADC  DX         ; XPOS = XPOS + DX
        STA  XPOS

        ; advance Y
        LDA  YPOS
        CLC
        ADC  DY         ; YPOS = YPOS + DY
        STA  YPOS

; ============================================================
; COLLISION CHECK — hit border?
; ============================================================

        CMP  #24        ; Y >= 24? (below screen)
        BCS  GAME_OVER
        LDA  XPOS
        CMP  #40        ; X >= 40? (off right edge)
        BCS  GAME_OVER

        JMP  DRAW_HEAD  ; loop back

; ============================================================
; GAME OVER
; ============================================================

GAME_OVER:
        LDA  #12
        STA  CV
        LDA  #14
        STA  CH
        ; print "GAME OVER" by outputting each char via COUT
        LDX  #$00
GOLOOP: LDA  MSG,X
        BEQ  DONE
        JSR  COUT
        INX
        BNE  GOLOOP
DONE:   BRK             ; stop execution

MSG:    ASC  "GAME OVER"   ; Merlin syntax for ASCII string
        DB   $00           ; null terminator

; ============================================================
; NOTES ON SHORTEST FORM
; ============================================================
;
; In the competition, we'd count bytes. This annotated version
; is educational — the real competition code had:
;
;   - No labels (use relative branch offsets directly)
;   - No comments
;   - Variables packed into lowest zero page addresses
;   - ROM routines called by address, not symbol
;   - Trail character sometimes skipped (saving 3 bytes)
;
; Minimum viable moving-V on Apple II screen: ~35-40 bytes.
; With trail and border collision: ~70-80 bytes.
; With trail collision detection: ~120 bytes.
;
; The kid who got closest to 40 bytes in our group won.
; I came in second. I've been thinking about it since.

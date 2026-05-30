]  AppleSoft BASIC — Snake Game with V
]  Apple II (1977-1993)
]  author: tonimaxx
]  repo: https://github.com/tonimaxx/tonisnippets
]
]  Run on: AppleWin emulator, or real Apple II
]  Type NEW first, then enter each line.
]
]  Arrow key codes on Apple II:
]    Left  = CHR$(8)
]    Right = CHR$(21)
]    Up    = CHR$(11)
]    Down  = CHR$(10)
]
]  PEEK(addr) reads screen memory — used for collision detection
]  Screen text page 1 starts at $400 (decimal 1024)
]  VTAB sets vertical position (1-24), HTAB sets horizontal (1-40)

] ============================================================
] READABLE VERSION — multi-line, with comments
] ============================================================

10  REM SNAKE GAME - READABLE VERSION
20  HOME
30  X = 20: Y = 12: DX = 1: DY = 0: SC = 0
40  REM DRAW BORDER
50  FOR I = 1 TO 40: VTAB 1: HTAB I: PRINT "-": VTAB 24: HTAB I: PRINT "-": NEXT I
60  FOR I = 1 TO 24: VTAB I: HTAB 1: PRINT "|": VTAB I: HTAB 40: PRINT "|": NEXT I
70  REM GAME LOOP
80  VTAB Y: HTAB X: PRINT "V"
90  GET K$
100 REM HANDLE ARROW KEYS
110 IF K$ = CHR$(8)  THEN DX = -1: DY = 0
120 IF K$ = CHR$(21) THEN DX =  1: DY = 0
130 IF K$ = CHR$(11) THEN DY = -1: DX = 0
140 IF K$ = CHR$(10) THEN DY =  1: DX = 0
150 REM LEAVE TRAIL
160 VTAB Y: HTAB X: PRINT "."
170 X = X + DX: Y = Y + DY
180 REM COLLISION — READ SCREEN MEMORY
190 REM SCREEN ROW ADDRESSES VARY (APPLE II NON-LINEAR LAYOUT)
200 REM SIMPLE BORDER CHECK:
210 IF X < 2 OR X > 39 OR Y < 2 OR Y > 23 THEN GOTO 300
220 SC = SC + 1: GOTO 80
300 REM GAME OVER
310 VTAB 12: HTAB 15: PRINT "GAME OVER"
320 VTAB 13: HTAB 15: PRINT "SCORE: "; SC
330 END


] ============================================================
] ONE-LINER COMPETITION VERSION
] Chain everything with : on a single line number
] This is the form the competition demanded
] ============================================================

1 HOME:X=20:Y=12:DX=1:DY=0:S=0:FOR I=1 TO 40:VTAB 1:HTAB I:PRINT"-":VTAB 24:HTAB I:PRINT"-":NEXT:FOR I=1 TO 24:VTAB I:HTAB 1:PRINT"|":VTAB I:HTAB 40:PRINT"|":NEXT
2 VTAB Y:HTAB X:PRINT"V":GET K$:IF K$=CHR$(8) THEN DX=-1:DY=0
3 IF K$=CHR$(21) THEN DX=1:DY=0
4 IF K$=CHR$(11) THEN DY=-1:DX=0
5 IF K$=CHR$(10) THEN DY=1:DX=0
6 VTAB Y:HTAB X:PRINT".":X=X+DX:Y=Y+DY:IF X<2 OR X>39 OR Y<2 OR Y>23 THEN VTAB 12:HTAB 15:PRINT"GAME OVER  SCORE:";S:END
7 S=S+1:GOTO 2


] ============================================================
] ABSOLUTE SHORTEST — one logical block, maximum colon chaining
] The spirit of the competition: everything after line 1
] (Split here for readability — in competition, line 2 onward
]  would also be crushed together)
] ============================================================

] Shortest printable loop that moves V and leaves a trail:
]
] 1 HOME:X=20:Y=12:DX=1:DY=0
] 2 VTAB Y:HTAB X:PRINT"V":GET K$:VTAB Y:HTAB X:PRINT".":IF K$=CHR$(8) THEN DX=-1:DY=0
] 3 IF K$=CHR$(21) THEN DX=1:DY=0:IF K$=CHR$(11) THEN DY=-1:DX=0
] 4 X=X+DX:Y=Y+DY:IF X<1 OR X>40 OR Y<1 OR Y>24 THEN END
] 5 GOTO 2


] ============================================================
] THE REAL ONE-LINER — What the competition actually demanded
] ============================================================
]
] Line 1: setup only (border, init vars, precompute CHR$ once)
] Line 2: THE GAME — entire loop in one line, 213 characters
]         under the Apple II limit of 239 chars per line
]
] The key insight: no IF statements for direction.
] Pure boolean arithmetic instead.
]
] How the direction math works:
]   In AppleSoft BASIC, a true comparison returns 1, false = 0
]
]   DX = (right pressed) - (left pressed)
]        + DX * (not right) * (not left) * (not down) * (not up)
]
]   Right pressed:  DX = 1-0 + DX*0*1*1*1 = 1          (set right)
]   Left pressed:   DX = 0-1 + DX*1*0*1*1 = -1         (set left)
]   Down pressed:   DX = 0-0 + DX*1*1*0*1 = 0          (reset horizontal!)
]   No dir key:     DX = 0-0 + DX*1*1*1*1 = DX         (keep direction)
]
]   Same logic for DY — pressing left/right zeros out DY automatically.
]   Result: perfect 4-direction movement, no IF needed.
]
] Precomputing L$,R$,U$,D$ on line 1 saves ~80 chars on line 2.
] Without that trick, line 2 would be ~290 chars — over the limit.
] ============================================================

1 HOME:X=20:Y=12:DX=1:DY=0:L$=CHR$(8):R$=CHR$(21):U$=CHR$(11):D$=CHR$(10):FOR I=1TO40:VTAB1:HTABI:PRINT"-":VTAB24:HTABI:PRINT"-":NEXT:FOR I=1TO24:VTABI:HTAB1:PRINT"|":VTABI:HTAB40:PRINT"|":NEXT
2 VTABY:HTABX:PRINT"V":GETK$:VTABY:HTABX:PRINT".":DX=(K$=R$)-(K$=L$)+DX*(K$<>R$)*(K$<>L$)*(K$<>D$)*(K$<>U$):DY=(K$=D$)-(K$=U$)+DY*(K$<>D$)*(K$<>U$)*(K$<>R$)*(K$<>L$):X=X+DX:Y=Y+DY:IFX<2ORX>39ORY<2ORY>23THENEND:GOTO2

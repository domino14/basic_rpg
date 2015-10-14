'Tile Editor by Cesar
DECLARE SUB options (derf$)
DECLARE SUB drawongrid ()
DECLARE SUB helpmenu ()

RANDOMIZE TIMER
DIM SHARED penmode, file$
DIM SHARED x, y, size, bgcol, col, current, curx, cury
DIM SHARED tilesize, y2, x2, x1, y1, PixPerTile
DIM SHARED chasmurf(tilesize, tilesize) AS INTEGER
SCREEN 12
dederf:
INPUT "Enter tilesize you'd like(1 - 100) - Enter 1000 to load a file: ", tilesize
IF tilesize < 1 OR tilesize > 100 OR INT(tilesize) <> tilesize AND tilesize <> 1000 THEN GOTO dederf
IF tilesize = 1000 THEN lo = 1: CALL options("l")
FOR a = 350 TO 1 STEP -1
 PixPerTile = tilesize * a
 IF PixPerTile < 350 THEN a = 1
NEXT
PixPerTile = PixPerTile / tilesize

x2 = 450 + (tilesize - 1)
x1 = 450
y2 = 100 + (tilesize - 1)
y1 = 100
size = 4 + INT(((x2 - x1 + 1) + 7) / 8) * 4 * ((y2 - y1) + 1)
size = INT(size / 2)
IF lo = 0 THEN DIM SHARED smurf(1 TO size) AS INTEGER
col = 0


x = 450
y = 100
IF lo = 0 THEN
INPUT "What background color would you like?", bgcol
CLS
LINE (x, y)-(x2, y2), bgcol, BF
LOCATE 1, 1
PRINT "tilesize: "; tilesize; " pix: "; PixPerTile

'*************************************************
'large grid
'top left = 40, 40
  FOR a = 0 TO tilesize
    LINE (40, (PixPerTile * a) + 40)-((PixPerTile * tilesize) + 40, (PixPerTile * a) + 40), 15
    LINE ((PixPerTile * a) + 40, 40)-((PixPerTile * a) + 40, (PixPerTile * tilesize) + 40), 15

  NEXT

  FOR x = 450 TO x2
   FOR y = 100 TO y2
    CALL drawongrid
   NEXT
  NEXT
 x = 450
 y = 100
'large grid
'************************************************
END IF
penmode = 0

'initialize cursor
 LINE (40, 40)-(40 + PixPerTile, 40 + PixPerTile), col
 LINE (40, 40 + PixPerTile)-(40 + PixPerTile, 40), col
  curx = 40
  cury = 40
startedit:
 'paint to grid

current = POINT(x, y)

LOCATE 1, 1
PRINT x - 449; ","; y - 99; "Color at this position: "; current

IF penmode = 0 THEN pen$ = "off"
IF penmode = 1 THEN pen$ = "on"
LOCATE 1, 50
PRINT "Tile Size: "; tilesize


LOCATE 15, 50: PRINT "<C>olor"; "  Color being used: "; col
LOCATE 16, 50: PRINT "Sa<v>e "
LOCATE 17, 50: PRINT "<L>oad "
LOCATE 18, 50: PRINT "<Q>uit"
LOCATE 19, 50: PRINT "<.>Set Pixel"
LOCATE 20, 50: PRINT "<P>en "; "(currently "; pen$; ") "
LOCATE 21, 50: PRINT "Clea<r>"
LOCATE 22, 50: PRINT "1) Random Dots"
LOCATE 23, 50: PRINT "2) Replace Colors"
LOCATE 24, 50: PRINT "3) Horizontal"
LOCATE 25, 50: PRINT "4) Vertical"
LOCATE 26, 50: PRINT "<H>elp"
LOCATE 27, 50: PRINT "<D>elete File"
derf$ = INKEY$
CALL options(derf$)


GOTO startedit

SUB drawongrid ()
    col1 = POINT(x, y)
      FOR c = 1 TO PixPerTile - 1
       FOR d = 1 TO PixPerTile - 1
        PSET (PixPerTile * (x - 450) + 40 + c, PixPerTile * (y - 100) + 40 + d), col1
       NEXT
      NEXT

END SUB

SUB helpmenu ()
  LOCATE 26, 1
  PRINT "You have to save before entering help menu. Is that okay? (y/n)"
  perf$ = ""
   DO WHILE perf$ <> "y" AND perf$ <> "n"
    perf$ = INKEY$
   LOOP
  IF perf$ = "n" THEN
   LOCATE 26, 1
   PRINT "                                                               "
   EXIT SUB
  END IF
  IF perf$ = "y" THEN
   CALL options("v")
   CLS
   LOCATE 1, 30
   PRINT "Help menu! (Page 1)"
   LOCATE 3, 3
    COLOR 4
    PRINT "Drawing pixels"
   LOCATE 4, 4
    COLOR 1
    PRINT "Drawing pixels on the screen is very simple. Use the arrow keys "
    PRINT "to move the cursor around the grid. The cursor will be the color"
    PRINT "currently being used. To set the pixel at that location in the grid, "
    PRINT "press": LOCATE 7, 6: COLOR 10: PRINT " ."
   LOCATE 9, 4
    COLOR 1
    PRINT "You can also automatically set pixels as you move the cursor around"
    PRINT "the screen. To do this, press "
    LOCATE 10, 31: COLOR 10: PRINT "p"
    LOCATE 10, 32: COLOR 1: PRINT ". This turns on pen mode, which can be turned"
    PRINT "off by pressing ": LOCATE 11, 17: COLOR 10: PRINT "p": LOCATE 11, 18: COLOR 1: PRINT " again."
   LOCATE 11, 3
    COLOR 4
    PRINT "Changing colors"
   LOCATE 12, 4
    COLOR 1
    PRINT "To change the color currently being used, press "
    LOCATE 12, 52: COLOR 10: PRINT "c": LOCATE 12, 53: COLOR 1: PRINT ". "
    PRINT "Type a number from 1 to 15 at the prompt representing the color you want to use."
    PRINT "Here's a list of the colors:"
    DO WHILE INKEY$ = ""
    LOOP
    PRINT "0   Black"
    COLOR 1: PRINT "1   Blue"
    COLOR 2: PRINT "2   Green"
    COLOR 3: PRINT "3   Cyan"
    COLOR 4: PRINT "4   Red"
    COLOR 5: PRINT "5   Magenta"
    COLOR 6: PRINT "6   Brown"
    COLOR 7: PRINT "7   White"
    COLOR 8: PRINT "8   Gray"
    COLOR 9: PRINT "9   Bright Blue"
    COLOR 10: PRINT "10  Bright Green"
    COLOR 11: PRINT "11  Bright Cyan"
    COLOR 12: PRINT "12  Bright Red"
    COLOR 13: PRINT "13  Pink"
    COLOR 14: PRINT "14  Yellow"
    COLOR 15: PRINT "15  Bright White"
   DO WHILE INKEY$ = ""
   LOOP
   CLS
   LOCATE 1, 1
   PRINT "Page 2"
   COLOR 4
   LOCATE 3, 3
   PRINT "Storing and loading files, implementing them in an RPG"
   COLOR 1
   LOCATE 4, 4
   PRINT "After you're done with a tile, you can save it by pressing v. When you're "
   PRINT "prompted to type a filename, type it in the format *.tle"
   PRINT ""
   PRINT "Example:     grass.tle         shop.tle"
   PRINT "To load a tile for editing, press l. A list of *.tle files in the current "
   PRINT "directory will show up. Type one of them in (don't make up a filename because "
   PRINT "this will crash the program) and wait for it to load. Don't press anything "
   PRINT "while it's loading because this might cause the cursor to become misaligned."
   PRINT ""
   PRINT "To load a tile to use into your game, use the following series of commands: "
   PRINT ""
   COLOR 15
   PRINT "    SCREEN 12: CLS"
   PRINT "    OPEN ""*.tle"" FOR INPUT AS #1"
   PRINT "     INPUT #1, tilesize"
   PRINT "     size = 4 + INT(((tilesize + 1) + 7) / 8) * 4 * ((tilesize) + 1)"
   PRINT "     size = INT(size / 2)"
   PRINT "     DIM whatever(1 to size) AS INTEGER"
   PRINT "     FOR a = 1 to size"
   PRINT "      INPUT #1, whatever(a)"
   PRINT "     NEXT"
   PRINT "     CLOSE #1"
  DO WHILE INKEY$ = ""
  LOOP

  END IF
END SUB

SUB options (derf$)
 SELECT CASE derf$
 '************************************************
  CASE CHR$(0) + "K"  'left
   IF x > 450 THEN
    LINE (curx, cury)-(curx + PixPerTile, cury + PixPerTile), 15, B
    CALL drawongrid
    curx = curx - PixPerTile
    x = x - 1
    LINE (curx, cury)-(curx + PixPerTile, cury + PixPerTile), col
    LINE (curx, cury + PixPerTile)-(curx + PixPerTile, cury), col

    IF penmode = 1 THEN
     PSET (x, y), col
     CALL drawongrid
    END IF
   END IF
 '************************************************
  CASE CHR$(0) + "P"
   IF y < y2 THEN
    LINE (curx, cury)-(curx + PixPerTile, cury + PixPerTile), 15, B
    CALL drawongrid
    cury = cury + PixPerTile
    y = y + 1              'down
    LINE (curx, cury)-(curx + PixPerTile, cury + PixPerTile), col
    LINE (curx, cury + PixPerTile)-(curx + PixPerTile, cury), col
    IF penmode = 1 THEN
     PSET (x, y), col
     CALL drawongrid
    END IF
   END IF
 '************************************************
  CASE CHR$(0) + "M"
   IF x < x2 THEN             'right
    LINE (curx, cury)-(curx + PixPerTile, cury + PixPerTile), 15, B
    CALL drawongrid
    curx = curx + PixPerTile
    x = x + 1
    LINE (curx, cury)-(curx + PixPerTile, cury + PixPerTile), col
    LINE (curx, cury + PixPerTile)-(curx + PixPerTile, cury), col
    IF penmode = 1 THEN
     PSET (x, y), col
     CALL drawongrid
    END IF
  END IF
 '************************************************
  CASE CHR$(0) + "H"
   IF y > 100 THEN            'up
    LINE (curx, cury)-(curx + PixPerTile, cury + PixPerTile), 15, B
    CALL drawongrid
    cury = cury - PixPerTile
    y = y - 1
    LINE (curx, cury)-(curx + PixPerTile, cury + PixPerTile), col
    LINE (curx, cury + PixPerTile)-(curx + PixPerTile, cury), col
    IF penmode = 1 THEN
     PSET (x, y), col
     CALL drawongrid
    END IF
   END IF
 '************************************************
  CASE "c"
   LOCATE 25, 1
   INPUT "What color do you want: ", col
   LOCATE 25, 1
   PRINT "                                    "
 '************************************************
  CASE "q"
   CLS
    LOCATE 2, 30: COLOR 1
    PRINT "Tile Editor V 1.0"
    LOCATE 3, 30: COLOR 4
    PRINT "By CesarWare (C) 1999"
    LOCATE 5, 10: COLOR 1
    PRINT "Email me at CesarSa1ad@aol.com for information on new releases!"
   
     STOP
 '************************************************
  CASE "."
   PSET (x, y), col
    FOR c = 1 TO PixPerTile
     FOR d = 1 TO PixPerTile
      PSET (PixPerTile * (x - 450) + 40 + c, PixPerTile * (y - 100) + 40 + d), col
     NEXT
    NEXT
 '************************************************
 CASE "v"
   LOCATE 27, 1
   PRINT "Save as a TILE file or as a CHARACTER file?"
   LOCATE 28, 1
   INPUT "Type t or c: ", CharOrTile$
   IF CharOrTile$ <> "t" AND CharOrTile$ <> "c" THEN
   LOCATE 27, 1
   PRINT "                                           "
   LOCATE 28, 1
   PRINT "                        "
   EXIT SUB
   END IF
   IF CharOrTile$ = "t" THEN
     ' TILE FILE
   LOCATE 27, 1
   PRINT "                                           "
   LOCATE 28, 1
   PRINT "                        "

   LOCATE 27, 1
   INPUT "Type filename:", file$
   LOCATE 27, 1
   PRINT "                               "

   GET (450, 100)-(x2, y2), smurf
   OPEN file$ FOR OUTPUT AS #1
    PRINT #1, tilesize
    FOR a = 1 TO size
     PRINT #1, smurf(a)

    NEXT
   CLOSE #1
  END IF
   IF CharOrTile$ = "c" THEN

    ' CHARACTER FILE
   LOCATE 27, 1
   PRINT "                                           "
   LOCATE 28, 1
   PRINT "                        "

    LOCATE 27, 1
    INPUT "Type filename:", file$
    LOCATE 27, 1
    PRINT "                           "
    OPEN file$ FOR OUTPUT AS #1
     PRINT #1, tilesize
      FOR a = 1 TO tilesize
       FOR b = 1 TO tilesize
        PRINT #1, POINT(449 + a, 99 + b)
       NEXT
      NEXT
     CLOSE #1
   END IF

 '************************************************
  CASE "l"
   LOCATE 27, 1
   PRINT "Load as a TILE file or as a CHARACTER file?"
   LOCATE 28, 1
   INPUT "Type t or c: ", CharOrTile$
   IF CharOrTile$ <> "t" AND CharOrTile$ <> "c" THEN
    LOCATE 27, 1
    PRINT "                                           "
    LOCATE 28, 1
    PRINT "                        "
    EXIT SUB
   END IF
   
 ' _____________________LOAD TILE_____________
   IF CharOrTile$ = "t" THEN
   LOCATE 29, 1
   SHELL "dir *.tle"
   PRINT "Type filename:"
   INPUT file$
   CLS
   OPEN file$ FOR INPUT AS #1
   INPUT #1, tilesize
   x2 = 450 + (tilesize - 1)
   x1 = 450
   y2 = 100 + (tilesize - 1)
   y1 = 100
   size = 4 + INT(((x2 - x1 + 1) + 7) / 8) * 4 * ((y2 - y1) + 1)
   size = INT(size / 2)
    FOR a = 350 TO 1 STEP -1
      PixPerTile = tilesize * a
      IF PixPerTile < 350 THEN a = 1
    NEXT
     PixPerTile = PixPerTile / tilesize
    REDIM smurf(1 TO size) AS INTEGER
    FOR a = 1 TO size
     INPUT #1, smurf(a)
    NEXT
   PUT (450, 100), smurf
   CLOSE #1
  FOR a = 0 TO tilesize
    LINE (40, (PixPerTile * a) + 40)-((PixPerTile * tilesize) + 40, (PixPerTile * a) + 40), 15
    LINE ((PixPerTile * a) + 40, 40)-((PixPerTile * a) + 40, (PixPerTile * tilesize) + 40), 15

  NEXT

  PRINT "Loading..."
  FOR x = 450 TO x2
   FOR y = 100 TO y2
    CALL drawongrid
   NEXT
  NEXT
 x = 450
 y = 100
 curx = 40: cury = 40

 END IF

' --------------------LOAD CHARACTER ----------

 IF CharOrTile$ = "c" THEN
   LOCATE 29, 1
   SHELL "dir *.cha"
   PRINT "Type filename:"
   INPUT file$
   CLS
   OPEN file$ FOR INPUT AS #1
   INPUT #1, tilesize
   REDIM chasmurf(tilesize, tilesize) AS INTEGER
   FOR a = 1 TO tilesize
    FOR b = 1 TO tilesize
     INPUT #1, chasmurf(a, b)
    NEXT
   NEXT
  CLOSE #1
   x2 = 450 + (tilesize - 1)
   x1 = 450
   y2 = 100 + (tilesize - 1)
   y1 = 100

 'draw on grid and screen
  FOR a = 1 TO tilesize
   FOR b = 1 TO tilesize
    PSET (449 + a, 99 + b), chasmurf(a, b)
   NEXT
  NEXT

 ' .......
    FOR a = 350 TO 1 STEP -1
      PixPerTile = tilesize * a
      IF PixPerTile < 350 THEN a = 1
    NEXT
     PixPerTile = PixPerTile / tilesize

  FOR a = 0 TO tilesize
    LINE (40, (PixPerTile * a) + 40)-((PixPerTile * tilesize) + 40, (PixPerTile * a) + 40), 15
    LINE ((PixPerTile * a) + 40, 40)-((PixPerTile * a) + 40, (PixPerTile * tilesize) + 40), 15

  NEXT


  PRINT "Loading..."
  FOR x = 450 TO x2
   FOR y = 100 TO y2
    CALL drawongrid
   NEXT
  NEXT
 x = 450
 y = 100
 curx = 40: cury = 40

END IF


'************************************************
  CASE "p"
   IF penmode = 1 THEN penmode = 0: GOTO churf
   IF penmode = 0 THEN penmode = 1
 '************************************************
  CASE "r"
   GOTO beber
 '************************************************
  CASE "1"
   LOCATE 27, 1
   INPUT "How many dots would you like?", numdots
   LOCATE 27, 1
   PRINT "                                     "
   LOCATE 27, 1
   INPUT "What color dots?", dotcol
   LOCATE 27, 1
   PRINT "                                       "
   defx = x: defy = y
   FOR a = 1 TO numdots
    LOCATE 27, 1
    PRINT "Percent done: "; INT(a / numdots * 100)
    ranx = INT(RND * tilesize) + 450
    rany = INT(RND * tilesize) + 100
    PSET (ranx, rany), dotcol
    x = ranx
    y = rany
    CALL drawongrid
   NEXT
  LOCATE 27, 1
  PRINT "                         "
  x = defx
  y = defy
churf:
 '************************************************
  CASE "2"
   LOCATE 25, 1
   INPUT "Color to replace: ", col1
   LOCATE 25, 1
   PRINT "                         "
   LOCATE 25, 1
   INPUT "Change to: ", col2
   LOCATE 25, 1
   PRINT "                         "
    FOR a = 450 TO x2
     FOR b = 100 TO y2
      IF POINT(a, b) = col1 THEN
       PSET (a, b), col2
        FOR c = 1 TO (PixPerTile - 1)
         FOR d = 1 TO (PixPerTile - 1)
          PSET (PixPerTile * (a - 450) + 40 + c, PixPerTile * (b - 100) + 40 + d), col2
         NEXT
        NEXT
      END IF
     NEXT
    NEXT
 '************************************************
  CASE "3"
   FOR a = 450 TO x2
    PSET (a, y), col
      FOR c = 1 TO PixPerTile - 1
       FOR d = 1 TO PixPerTile - 1
        PSET (PixPerTile * (a - 450) + 40 + c, PixPerTile * (y - 100) + 40 + d), col
       NEXT
      NEXT

   NEXT
 '************************************************
  CASE "4"
   FOR a = 100 TO y2
    PSET (x, a), col
      FOR c = 1 TO PixPerTile - 1
       FOR d = 1 TO PixPerTile - 1
        PSET (PixPerTile * (x - 450) + 40 + c, PixPerTile * (a - 100) + 40 + d), col
       NEXT
      NEXT

   NEXT
'***************************************************
CASE "h"
  CALL helpmenu
  
'************************************************
CASE "d"
 'Delete files
 LOCATE 27, 1
 INPUT "Type filename to delete: ", delfile$
 LOCATE 27, 1
 PRINT "Are you sure that you want to delete "; delfile$; "? (y/n)"
 INPUT "", sure$
 IF sure$ <> "y" THEN
  LOCATE 27, 1
 PRINT "                                                                 "
 EXIT SUB
 END IF
  KILL delfile$
  LOCATE 27, 1
 PRINT "                                                                 "
  LOCATE 27, 1
  PRINT delfile$; " successfully deleted. "
  DO WHILE INKEY$ = ""
  LOOP
  LOCATE 27, 1
  PRINT "                                        "
 EXIT SUB

'*************************
END SELECT
GOTO getmeouttahere

beber:
SCREEN 12
x = 450
y = 100
CLS
merf:
INPUT "Enter tilesize you'd like(1 - 100): ", tilesize
IF tilesize < 1 OR tilesize > 100 THEN GOTO merf

FOR a = 350 TO 1 STEP -1
 PixPerTile = tilesize * a
 IF PixPerTile < 350 THEN a = 1
NEXT
PixPerTile = PixPerTile / tilesize

x2 = 450 + (tilesize - 1)
x1 = 450
y2 = 100 + (tilesize - 1)
y1 = 100
size = 4 + INT(((x2 - x1 + 1) + 7) / 8) * 4 * ((y2 - y1) + 1)
size = INT(size / 2)
REDIM smurf(1 TO size) AS INTEGER
INPUT "What background color would you like?", bgcol
CLS
LINE (x, y)-(x2, y2), bgcol, BF

penmode = 0
  FOR a = 0 TO tilesize
    LINE (40, (PixPerTile * a) + 40)-((PixPerTile * tilesize) + 40, (PixPerTile * a) + 40), 15
    LINE ((PixPerTile * a) + 40, 40)-((PixPerTile * a) + 40, (PixPerTile * tilesize) + 40), 15

  NEXT

  FOR x = 450 TO x2
   FOR y = 100 TO y2
    CALL drawongrid
   NEXT
  NEXT
 x = 450
 y = 100
 curx = 40: cury = 40
getmeouttahere:
END SUB


'map editor
DECLARE SUB puttiles ()
DECLARE SUB savemap ()
DECLARE SUB puttile (x, y)
SCREEN 12
CLS
DIM SHARED tiles(16, 12)  AS INTEGER
DIM SHARED a
a = 18
DIM SHARED tilenames(0 TO a) AS STRING
der:
'INPUT "Enter how many tiles you will use in this screen:  ", a
INPUT "Default tile: ", defaulttile
FOR churf = 0 TO 15
 FOR lurf = 0 TO 11
  tiles(churf, lurf) = defaulttile
 NEXT
NEXT

FOR x = 0 TO a
 IF x = 0 THEN tilenames(x) = "tiles/grass.tle"
 IF x = 1 THEN tilenames(x) = "tiles/sand.tle"
 IF x = 2 THEN tilenames(x) = "tiles/cave.tle"
 IF x = 3 THEN tilenames(x) = "tiles/forest.tle"
 IF x = 4 THEN tilenames(x) = "tiles/floor.tle"
 IF x = 5 THEN tilenames(x) = "tiles/bridge.tle"
 IF x = 6 THEN tilenames(x) = "tiles/house.tle"
 IF x = 7 THEN tilenames(x) = "tiles/wallh.tle"
 IF x = 8 THEN tilenames(x) = "tiles/tree.tle"
 IF x = 9 THEN tilenames(x) = "tiles/water.tle"
 IF x = 10 THEN tilenames(x) = "tiles/counter.tle"
 IF x = 11 THEN tilenames(x) = "tiles/wallh.tle"
 IF x = 12 THEN tilenames(x) = "tiles/fortree.tle"
 IF x = 13 THEN tilenames(x) = "tiles/track.tle"
 IF x = 14 THEN tilenames(x) = "tiles/inn.tle"
 IF x = 15 THEN tilenames(x) = "tiles/reghouse.tle"
 IF x = 16 THEN tilenames(x) = "tiles/caveent.tle"
 IF x = 17 THEN tilenames(x) = "tiles/table.tle"
 IF x = 18 THEN tilenames(x) = "tiles/rocks.tle"
NEXT

posx = 0
posy = 0
CLS
COLOR 15
CALL puttiles
start:
 smurf$ = INKEY$
 SELECT CASE smurf$
 CASE "w"
    CALL puttile(posx, posy)
   IF posy > 0 THEN
      posy = posy - 1
     END IF
    CALL puttile(posx, posy)
    LINE (posx * 40 + 1, posy * 40 + 1)-(posx * 40 + 39, posy * 40 + 39), 15
    LINE (posx * 40 + 39, posy * 40 + 1)-(posx * 40 + 1, posy * 40 + 39), 15
 CASE "s"
    CALL puttile(posx, posy)
   IF posy < 11 THEN
      posy = posy + 1
     END IF
    CALL puttile(posx, posy)
    LINE (posx * 40 + 1, posy * 40 + 1)-(posx * 40 + 39, posy * 40 + 39), 15
    LINE (posx * 40 + 39, posy * 40 + 1)-(posx * 40 + 1, posy * 40 + 39), 15
 CASE "d"
   CALL puttile(posx, posy)
   IF posx < 15 THEN
    posx = posx + 1
   END IF
   CALL puttile(posx, posy)
    LINE (posx * 40 + 1, posy * 40 + 1)-(posx * 40 + 39, posy * 40 + 39), 15
    LINE (posx * 40 + 39, posy * 40 + 1)-(posx * 40 + 1, posy * 40 + 39), 15
 CASE "a"
   CALL puttile(posx, posy)
   IF posx > 0 THEN
    posx = posx - 1
   END IF
   CALL puttile(posx, posy)
    LINE (posx * 40 + 1, posy * 40 + 1)-(posx * 40 + 39, posy * 40 + 39), 15
    LINE (posx * 40 + 39, posy * 40 + 1)-(posx * 40 + 1, posy * 40 + 39), 15
 CASE "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"
   tiles(posx, posy) = ASC(smurf$) - 48
     CALL puttile(posx, posy)
 CASE "r"
  GOTO der
 CASE "t"
   CLS
   FOR x = 1 TO a
   PRINT "Tile "; x; ": "; tilenames(x)
   NEXT
   DO WHILE INKEY$ = "": LOOP
   CLS
   CALL puttiles
  CASE "v"
   CALL savemap
   CLS
   CALL puttiles
  CASE "p"
   LOCATE 1, 1
   INPUT "Tile #: ", tiles(posx, posy)
   CALL puttile(0, 0)
   CALL puttile(posx, posy)
  CASE "q"
   STOP
 CASE "l"
  CLS
  INPUT "Filename to load: ", file$
   OPEN file$ FOR INPUT AS #1
    FOR churf = 0 TO 15
     FOR lurf = 0 TO 11
      INPUT #1, deder
      tiles(churf, lurf) = deder
     NEXT
    NEXT
   CLOSE #1
   CLS
   CALL puttiles

  END SELECT
GOTO start

SUB puttile (x, y)
    tilesize = 40
    size = 4 + INT(((tilesize) + 7) / 8) * 4 * ((tilesize))
    size = INT(size / 2)
    DIM tile(1 TO size) AS INTEGER

   file$ = tilenames(tiles(x, y))
    OPEN file$ FOR INPUT AS #1
    INPUT #1, tilesize
   FOR b = 1 TO size
    INPUT #1, tile(b)
   NEXT
   CLOSE #1

PUT (x * 40, y * 40), tile, PSET


END SUB

SUB puttiles ()
    tilesize = 40
    size = 4 + INT(((tilesize) + 7) / 8) * 4 * ((tilesize))
    size = INT(size / 2)
    DIM tile(1 TO size) AS INTEGER

FOR x = 0 TO a
    file$ = tilenames(x)
    OPEN file$ FOR INPUT AS #1
    INPUT #1, tilesize
   FOR b = 1 TO size
    INPUT #1, tile(b)
   NEXT
   CLOSE #1

FOR churf = 0 TO 15
FOR lurf = 0 TO 11
 IF tiles(churf, lurf) = x THEN PUT (churf * 40, lurf * 40), tile, PSET
NEXT
NEXT
NEXT
END SUB

SUB savemap ()
 CLS
 INPUT "Type filename to save as: "; file$
 INPUT "Type 1 for RPG readable, 2 for QBasic code", m
 IF m = 1 THEN
 DIM temp(16, 12) AS INTEGER
 FOR c = 0 TO 15
  FOR d = 0 TO 11
   temp(c, d) = tiles(c, d)
  NEXT
 NEXT
  PRINT "Saving..."
OPEN file$ FOR OUTPUT AS #1
 FOR x = 0 TO 15
  FOR y = 0 TO 11
   PRINT #1, temp(x, y)
  NEXT
 NEXT
CLOSE #1
PRINT "Save done"
DO WHILE INKEY$ = "": LOOP
END IF

IF m = 2 THEN
OPEN file$ FOR OUTPUT AS #1
 FOR x = 0 TO 15
  FOR y = 0 TO 11
   text$ = "tiles(" + FORMAT$(x) + "," + FORMAT$(y) + ") = " + FORMAT$(tiles(x, y))
   PRINT #1, text$
  NEXT
 NEXT
CLOSE #1
PRINT "Save done"
DO WHILE INKEY$ = "": LOOP
END IF


END SUB


DECLARE SUB chaput (x, y, chatile() AS INTEGER, tilesize, ignore)
DECLARE SUB delayer ()
DECLARE SUB intro ()
DECLARE SUB movearound (smurf$, inbat)
DECLARE SUB landmark (screenx, screeny)
DECLARE SUB putalltiles ()
DECLARE SUB putthesetiles (x, y)
DECLARE SUB slowtalk (say$, r, c, col, newbox, waite)
DECLARE SUB checkaction ()
DECLARE SUB options ()
DECLARE SUB equip ()
DECLARE SUB useitems ()
DECLARE SUB status ()
DECLARE SUB saveg ()
DECLARE SUB loadg ()
DECLARE SUB shop (num)
DECLARE SUB video (num)
DECLARE SUB battle (monster$)
DECLARE SUB fight (techs() AS INTEGER, pic() AS INTEGER, thissize, id$, monhp, attack, defense, evade, numat, ign, bg)
DECLARE SUB levelup (num)
DECLARE SUB batanim (num)
DECLARE SUB loadscr (x, y)
DECLARE SUB loadchar ()


RANDOMIZE TIMER

DIM SHARED tiles(16, 12) AS INTEGER
DIM SHARED wspeed, tspeed
DIM SHARED delce(1 TO 10) AS INTEGER
DIM SHARED dzipe(1 TO 10) AS INTEGER
DIM SHARED items(1 TO 10) AS INTEGER
DIM SHARED equipm(1 TO 10) AS INTEGER
DIM SHARED party(1 TO 4) AS INTEGER
DIM SHARED people(1 TO 100) AS INTEGER
party(1) = 1
party(2) = 0
wspeed = 3
tspeed = 3

DIM SHARED manposx, tempsx, tempsy, manposy, smurf$, screenx, screeny
DIM SHARED tilesize, facing$, lostb, lostbat

 DIM SHARED money, magic, poison

'define tile arrays
tilesize = 40
size = 4 + INT(((tilesize) + 7) / 8) * 4 * ((tilesize))
size = INT(size / 2)
GOSUB loadtiles


'shell "start /m over.mid"

'***********
DIM SHARED delay
start = TIMER
DO UNTIL TIMER > start + 1
 delay = delay + 1
LOOP
delay = delay / 2

CALL intro

'****************
RANDOMIZE TIMER
delce(1) = 20 'hp
delce(2) = 20 'max hp
delce(3) = 4  'attack
delce(4) = 4  'defense
delce(5) = 0  'exp
delce(6) = 1  'exp level
delce(7) = 0  'weapon power
delce(8) = 0  'armor power
delce(9) = 0 'magic points
dzipe(1) = 50
dzipe(2) = 50
dzipe(3) = 13
dzipe(4) = 14
dzipe(5) = 2500
dzipe(6) = 5
dzipe(7) = 0
dzipe(8) = 0
dzipe(9) = 0

manposx = 1: manposy = 1
screenx = 1: screeny = 1

poison = 0
facing$ = "d"
magic = 0
CALL landmark(screenx, screeny)
start:

smurf$ = INKEY$
tempsx = screenx: tempsy = screeny
CALL movearound(smurf$, 0)
 IF tempsx <> screenx OR tempsy <> screeny THEN
 CLS
 CALL landmark(screenx, screeny)
END IF

GOTO start



loadtiles:

    SCREEN 12
    OPEN "tiles/grass.tle" FOR INPUT AS #1
    INPUT #1, tilesize
    grasssize = 4 + INT(((tilesize) + 7) / 8) * 4 * ((tilesize))
    grasssize = INT(grasssize / 2)
    DIM SHARED grass(1 TO grasssize) AS INTEGER
   FOR a = 1 TO grasssize
    INPUT #1, grass(a)
   NEXT
   CLOSE #1

    OPEN "tiles/sand.tle" FOR INPUT AS #1
    INPUT #1, tilesize
    sandsize = 4 + INT(((tilesize) + 7) / 8) * 4 * ((tilesize))
    sandsize = INT(sandsize / 2)
    DIM SHARED sand(1 TO sandsize) AS INTEGER
   FOR a = 1 TO sandsize
    INPUT #1, sand(a)
   NEXT
   CLOSE #1

    OPEN "tiles/forest.tle" FOR INPUT AS #1
    INPUT #1, tilesize
    sandsize = 4 + INT(((tilesize) + 7) / 8) * 4 * ((tilesize))
    sandsize = INT(sandsize / 2)
    DIM SHARED forest(1 TO sandsize) AS INTEGER
     FOR a = 1 TO sandsize
      INPUT #1, forest(a)
     NEXT
    CLOSE #1
    
    OPEN "tiles/bridge.tle" FOR INPUT AS #1
    INPUT #1, tilesize
    housesize = 4 + INT(((tilesize) + 7) / 8) * 4 * ((tilesize))
    housesize = INT(housesize / 2)
    DIM SHARED bridge(1 TO housesize) AS INTEGER
   FOR a = 1 TO housesize
    INPUT #1, bridge(a)
   NEXT
   CLOSE #1

    OPEN "tiles/water.tle" FOR INPUT AS #1
    INPUT #1, tilesize
    watersize = 4 + INT(((tilesize) + 7) / 8) * 4 * ((tilesize))
    watersize = INT(watersize / 2)
    DIM SHARED water(1 TO watersize) AS INTEGER
   FOR a = 1 TO watersize
    INPUT #1, water(a)
   NEXT
   CLOSE #1

    
    OPEN "tiles/house.tle" FOR INPUT AS #1
    INPUT #1, tilesize
    housesize = 4 + INT(((tilesize) + 7) / 8) * 4 * ((tilesize))
    housesize = INT(housesize / 2)
    DIM SHARED house(1 TO housesize) AS INTEGER
   FOR a = 1 TO housesize
    INPUT #1, house(a)
   NEXT
   CLOSE #1

    OPEN "tiles/tree.tle" FOR INPUT AS #1
    INPUT #1, tilesize
    treesize = 4 + INT(((tilesize) + 7) / 8) * 4 * ((tilesize))
    treesize = INT(treesize / 2)
    DIM SHARED tree(1 TO treesize)  AS INTEGER
   FOR a = 1 TO treesize
    INPUT #1, tree(a)
   NEXT
   CLOSE #1

    OPEN "tiles/fortree.tle" FOR INPUT AS #1
    INPUT #1, tilesize
    treesize = 4 + INT(((tilesize) + 7) / 8) * 4 * ((tilesize))
    treesize = INT(treesize / 2)
    DIM SHARED fortree(1 TO treesize)  AS INTEGER
   FOR a = 1 TO treesize
    INPUT #1, fortree(a)
   NEXT
   CLOSE #1

     
    OPEN "tiles/counter.tle" FOR INPUT AS #1
    INPUT #1, tilesize
    treesize = 4 + INT(((tilesize) + 7) / 8) * 4 * ((tilesize))

    treesize = INT(treesize / 2)
    DIM SHARED counter(1 TO treesize)  AS INTEGER
   FOR a = 1 TO treesize
    INPUT #1, counter(a)
   NEXT
   CLOSE #1


   OPEN "tiles/wallh.tle" FOR INPUT AS #1
    INPUT #1, tilesize
    treesize = 4 + INT(((tilesize) + 7) / 8) * 4 * ((tilesize))
    treesize = INT(treesize / 2)
    DIM SHARED wallh(1 TO treesize)  AS INTEGER
   FOR a = 1 TO treesize
    INPUT #1, wallh(a)
   NEXT
   CLOSE #1

   OPEN "tiles/floor.tle" FOR INPUT AS #1
    INPUT #1, tilesize
    treesize = 4 + INT(((tilesize) + 7) / 8) * 4 * ((tilesize))
    treesize = INT(treesize / 2)
    DIM SHARED floor(1 TO treesize)  AS INTEGER
   FOR a = 1 TO treesize
    INPUT #1, floor(a)
   NEXT
   CLOSE #1

   OPEN "tiles/track.tle" FOR INPUT AS #1
    INPUT #1, tilesize
    treesize = 4 + INT(((tilesize) + 7) / 8) * 4 * ((tilesize))
    treesize = INT(treesize / 2)
    DIM SHARED track(1 TO treesize)  AS INTEGER
   FOR a = 1 TO treesize
    INPUT #1, track(a)
   NEXT
   CLOSE #1

   OPEN "tiles/inn.tle" FOR INPUT AS #1
    INPUT #1, tilesize
    treesize = 4 + INT(((tilesize) + 7) / 8) * 4 * ((tilesize))
    treesize = INT(treesize / 2)
    DIM SHARED inn(1 TO treesize)  AS INTEGER
   FOR a = 1 TO treesize
    INPUT #1, inn(a)
   NEXT
   CLOSE #1

    OPEN "tiles/reghouse.tle" FOR INPUT AS #1
    INPUT #1, tilesize
    treesize = 4 + INT(((tilesize) + 7) / 8) * 4 * ((tilesize))
    treesize = INT(treesize / 2)
    DIM SHARED reghouse(1 TO treesize)  AS INTEGER
   FOR a = 1 TO treesize
    INPUT #1, reghouse(a)
   NEXT
   CLOSE #1

   OPEN "tiles/caveent.tle" FOR INPUT AS #1
    INPUT #1, tilesize
    treesize = 4 + INT(((tilesize) + 7) / 8) * 4 * ((tilesize))
    treesize = INT(treesize / 2)
    DIM SHARED caveent(1 TO treesize)  AS INTEGER
   FOR a = 1 TO treesize
    INPUT #1, caveent(a)
   NEXT
   CLOSE #1

   OPEN "tiles/cave.tle" FOR INPUT AS #1
    INPUT #1, tilesize
    treesize = 4 + INT(((tilesize) + 7) / 8) * 4 * ((tilesize))
    treesize = INT(treesize / 2)
    DIM SHARED cave(1 TO treesize)  AS INTEGER
   FOR a = 1 TO treesize
    INPUT #1, cave(a)
   NEXT
   CLOSE #1

   OPEN "tiles/table.tle" FOR INPUT AS #1
    INPUT #1, tilesize
    treesize = 4 + INT(((tilesize) + 7) / 8) * 4 * ((tilesize))
    treesize = INT(treesize / 2)
    DIM SHARED table(1 TO treesize)  AS INTEGER
   FOR a = 1 TO treesize
    INPUT #1, table(a)
   NEXT
   CLOSE #1

   OPEN "tiles/bed.tle" FOR INPUT AS #1
    INPUT #1, tilesize
    treesize = 4 + INT(((tilesize) + 7) / 8) * 4 * ((tilesize))
    treesize = INT(treesize / 2)
    DIM SHARED bed(1 TO treesize)  AS INTEGER
    FOR a = 1 TO treesize
     INPUT #1, bed(a)
     NEXT
   CLOSE #1

   

   OPEN "char/mand.cha" FOR INPUT AS #1
    INPUT #1, tilesize
    DIM SHARED mand(tilesize, tilesize)  AS INTEGER
     FOR a = 1 TO tilesize
      FOR B = 1 TO tilesize
       INPUT #1, mand(a, B)
      NEXT
     NEXT
   CLOSE #1

   OPEN "char/manr.cha" FOR INPUT AS #1
   INPUT #1, tilesize
   DIM SHARED manr(tilesize, tilesize) AS INTEGER
    FOR a = 1 TO tilesize
     FOR B = 1 TO tilesize
      INPUT #1, manr(a, B)
     NEXT
    NEXT
   CLOSE #1

   OPEN "char/manl.cha" FOR INPUT AS #1
   INPUT #1, tilesize
   DIM SHARED manl(tilesize, tilesize) AS INTEGER
    FOR a = 1 TO tilesize
     FOR B = 1 TO tilesize
      INPUT #1, manl(a, B)
     NEXT
    NEXT
   CLOSE #1

   OPEN "char/manu.cha" FOR INPUT AS #1
   INPUT #1, tilesize
   DIM SHARED manu(tilesize, tilesize) AS INTEGER
    FOR a = 1 TO tilesize
     FOR B = 1 TO tilesize
      INPUT #1, manu(a, B)
     NEXT
    NEXT
   CLOSE #1

   OPEN "char/manmd.cha" FOR INPUT AS #1
   INPUT #1, tilesize
   DIM SHARED manmd(tilesize, tilesize) AS INTEGER
    FOR a = 1 TO tilesize
     FOR B = 1 TO tilesize
      INPUT #1, manmd(a, B)
     NEXT
    NEXT
   CLOSE #1

   OPEN "char/manmu.cha" FOR INPUT AS #1
   INPUT #1, tilesize
   DIM SHARED manmu(tilesize, tilesize) AS INTEGER
    FOR a = 1 TO tilesize
     FOR B = 1 TO tilesize
      INPUT #1, manmu(a, B)
     NEXT
    NEXT
   CLOSE #1

   OPEN "char/manmr.cha" FOR INPUT AS #1
   INPUT #1, tilesize
   DIM SHARED manmr(tilesize, tilesize) AS INTEGER
    FOR a = 1 TO tilesize
     FOR B = 1 TO tilesize
      INPUT #1, manmr(a, B)
     NEXT
    NEXT
   CLOSE #1

   OPEN "char/manml.cha" FOR INPUT AS #1
   INPUT #1, tilesize
   DIM SHARED manml(tilesize, tilesize) AS INTEGER
    FOR a = 1 TO tilesize
     FOR B = 1 TO tilesize
      INPUT #1, manml(a, B)
     NEXT
    NEXT
   CLOSE #1

   OPEN "char/harrde.cha" FOR INPUT AS #1
   INPUT #1, tilesize
   DIM SHARED harrde(tilesize, tilesize)  AS INTEGER
    FOR a = 1 TO tilesize
     FOR B = 1 TO tilesize
      INPUT #1, harrde(a, B)
     NEXT
    NEXT
   CLOSE #1

   OPEN "char/sign.cha" FOR INPUT AS #1
   INPUT #1, tilesize
   DIM SHARED sign(tilesize, tilesize)  AS INTEGER
    FOR a = 1 TO tilesize
     FOR B = 1 TO tilesize
      INPUT #1, sign(a, B)
     NEXT
    NEXT
   CLOSE #1

 OPEN "char/dzipe.cha" FOR INPUT AS #1
   INPUT #1, tilesize
   DIM SHARED dzipepic(tilesize, tilesize) AS INTEGER
    FOR a = 1 TO tilesize
     FOR B = 1 TO tilesize
      INPUT #1, dzipepic(a, B)
     NEXT
    NEXT
   CLOSE #1

  OPEN "char/shopk.cha" FOR INPUT AS #1
    INPUT #1, tilesize
    DIM SHARED shopk(tilesize, tilesize)  AS INTEGER
     FOR a = 1 TO tilesize
      FOR B = 1 TO tilesize
       INPUT #1, shopk(a, B)
      NEXT
     NEXT
   CLOSE #1

  OPEN "char/guard.cha" FOR INPUT AS #1
   INPUT #1, tilesize
   DIM SHARED guard(tilesize, tilesize) AS INTEGER
    FOR a = 1 TO tilesize
     FOR B = 1 TO tilesize
      INPUT #1, guard(a, B)
     NEXT
    NEXT
   CLOSE #1


  OPEN "char/char1.cha" FOR INPUT AS #1
   INPUT #1, tilesize
   DIM SHARED char1(tilesize, tilesize) AS INTEGER
    FOR a = 1 TO tilesize
     FOR B = 1 TO tilesize
      INPUT #1, char1(a, B)
     NEXT
    NEXT
   CLOSE #1

  OPEN "char/char2.cha" FOR INPUT AS #1
   INPUT #1, tilesize
   DIM SHARED char2(tilesize, tilesize) AS INTEGER
    FOR a = 1 TO tilesize
     FOR B = 1 TO tilesize
      INPUT #1, char2(a, B)
     NEXT
    NEXT
   CLOSE #1

  OPEN "char/FARMER.cha" FOR INPUT AS #1
   INPUT #1, tilesize
   DIM SHARED farmer(tilesize, tilesize) AS INTEGER
    FOR a = 1 TO tilesize
     FOR B = 1 TO tilesize
      INPUT #1, farmer(a, B)
     NEXT
    NEXT
   CLOSE #1




RETURN

SUB batanim (num)
 '*********************************
 IF num = 1 THEN
  defa = tiles(1, 1)
  CALL slowtalk("Say your prayers, little one... ", 3, 2, 6, 0, 0)
  FOR a = 1 TO (delay * 10)
  NEXT
   FOR a = 1 TO (delay / 1000)
    FOR B = 1 TO 480
    LINE (1, B)-(640, B), 6
    NEXT
  NEXT
 END IF
 
 IF num = 2 THEN
  FOR a = 1 TO (delay / 2)
   LINE (200, 130)-(320, 130), 15
   LINE (200, 150)-(320, 150), 15
   LINE (200, 130)-(320, 130), 0
   LINE (200, 150)-(320, 150), 0
  NEXT
 FOR a = 1 TO 3
  CALL putthesetiles(4 + a, 3)
  
 NEXT
 END IF

 IF num = 3 THEN
  FOR a = 1 TO (delay / 4)
   LINE (163, 123)-(197, 157), 15
   LINE (163, 157)-(197, 123), 15
   LINE (163, 123)-(197, 157), 0
   LINE (163, 157)-(197, 123), 0
  NEXT
  CALL putthesetiles(4, 3)
   CALL chaput(160, 120, manr(), 40, 15)
 END IF

 IF num = 4 THEN
  FOR a = 1 TO (delay / 3)
   CIRCLE (180, 140), 15, 15
   CIRCLE (180, 140), 15, 0
  NEXT
  CALL putthesetiles(4, 3)
  CALL chaput(160, 120, manr(), 40, 15)
 END IF

 IF num = 5 THEN
  FOR a = 280 TO 180 STEP -1
   CIRCLE (a, 140), 15, 15
   PAINT (a, 140), 15, 15
   FOR B = 1 TO (delay / 10)
   NEXT
   CALL putthesetiles(4, 3)
   CALL putthesetiles(5, 3)
   CALL putthesetiles(6, 3)
   CALL putthesetiles(7, 3)
   CALL chaput(160, 120, manr(), 40, 15)
  NEXT

 END IF
END SUB

SUB battle (monster$)
 DIM powers(1 TO 20) AS INTEGER
 FOR a = 1 TO 20
  powers(a) = 0
 NEXT
FOR churf = 0 TO 15
 FOR lurf = 0 TO 11
  tiles(churf, lurf) = -1
 NEXT
NEXT
CLS
CALL putalltiles
file$ = "char/" + monster$ + ".cha"
   OPEN file$ FOR INPUT AS #1
   INPUT #1, thissize
   DIM pic(thissize, thissize) AS INTEGER
    FOR a = 1 TO thissize
     FOR B = 1 TO thissize
      INPUT #1, pic(a, B)
     NEXT
    NEXT
   CLOSE #1


'*************************************************
 IF monster$ = "starfish" THEN
  id$ = "Starry"
  powers(1) = 1
  powers(2) = 1
  monhp = 20
  attack = 3
  defense = 2
  evade = 8
  ign = 1
  bg = 1
 END IF
 IF monster$ = "crab" THEN
  id$ = "Crabbor"
  powers(1) = 1
  powers(3) = 1
  monhp = 30
  attack = 3
  defense = 3
  evade = 2
  ign = 1
  bg = 1
 END IF
 IF monster$ = "harrde" THEN
  id$ = "Harrde Dryve"
  powers(2) = 1
  powers(3) = 1
  powers(4) = 1
  ign = 0
  monhp = 175
  attack = 8
  defense = 8
  evade = 20
  bg = 0
 END IF
 IF monster$ = "dinobird" THEN
  id$ = "DinoBird"
  powers(4) = 1
  powers(3) = 1
  ign = 1
  monhp = 50
  attack = 12
  defense = 6
  evade = 15
  bg = 3
 END IF
 IF monster$ = "mushroom" THEN
  id$ = "False Morel"
  powers(4) = 1
  powers(5) = 1
  ign = 1
  monhp = 50
  attack = 10
  defense = 10
  evade = 15
  bg = 3
 END IF
size = 0
FOR a = 1 TO 20
 IF powers(a) = 1 THEN size = size + 1
NEXT
DIM techs(1 TO size) AS INTEGER
B = 1
 FOR a = 1 TO 20
  IF powers(a) = 1 THEN techs(B) = a: B = B + 1
 NEXT


numat = size
CALL fight(techs(), pic(), thissize, id$, monhp, attack, defense, evade, numat, ign, bg)
END SUB

SUB chaput (x, y, chatile() AS INTEGER, tilesize, ignore)

 FOR a = 1 TO tilesize
  FOR B = 1 TO tilesize
   IF chatile(a, B) <> ignore THEN
    PSET (x + a, y + B), chatile(a, B)
   END IF
  NEXT
 NEXT
END SUB

SUB checkaction ()

xnow = screenx: ynow = screeny
'screenx = 1, screeny = 1
'**********************************************
IF screenx = 1 AND screeny = 1 THEN
  IF (manposx = 9 AND manposy = 9 AND facing$ = "r") OR (manposx = 11 AND manposy = 9 AND facing$ = "l") OR (manposx = 10 AND manposy = 8 AND facing$ = "d") OR (manposx = 10 AND manposy = 10 AND facing$ = "u") THEN
    IF people(2) = 0 AND delce(6) = 1 THEN
     CALL slowtalk("Harrde Dryve: Haaaa!", 2, 2, 12, 1, 1)
     CALL slowtalk("Delce: Um.. hello...", 3, 2, 15, 0, 1)
     CALL slowtalk("Harrde Dryve: Hey, babe! Wanna go to the beach with me? ", 4, 2, 12, 0, 1)
     CALL slowtalk("Delce: Aah! Get away from me!", 5, 2, 15, 0, 1)
     CALL slowtalk("Harrde Dryve: I'll be missing you...", 6, 2, 12, 0, 1)
     CALL landmark(1, 1)
    END IF
    IF delce(6) > 1 AND people(2) = 0 THEN
     CALL slowtalk("Harrde Dryve: Hey there, babe!", 2, 2, 12, 1, 1)
     CALL slowtalk("Delce: Hey! What's it to you anyways?", 3, 2, 15, 0, 1)
     CALL slowtalk("Harrde Dryve: Ooh.. a little harsh there, boy. I believe you want this!", 4, 2, 12, 0, 1)
     CALL slowtalk("Delce: Is that the Harrde Ribbon? Yeah! Give me that!", 5, 2, 15, 0, 1)
     CALL slowtalk("Harrde Dryve: Hoo boy! You want this, come and get it!", 6, 2, 12, 0, 1)
     CALL battle("harrde")
     IF lostbat = 0 THEN
      CALL slowtalk("Harrde Dryve: Oh, you toasted me! You're so mean! Humph!", 2, 2, 12, 1, 1)
      CALL slowtalk("Delce: Yeah, loser! Now hand it over!", 3, 2, 15, 0, 1)
      CALL slowtalk("Harrde Dryve: Eh, I guess you won it fair and square!", 4, 2, 12, 0, 1)
      CALL slowtalk("You received the Harrde Ribbon!", 3, 5, 1, 1, 0)
      CALL slowtalk("Things are definitely starting to look up!", 4, 5, 1, 0, 1)
      CALL slowtalk("Harrde Dryve: Well I'm outta here! Catch you later, hon!", 2, 2, 12, 1, 1)
      people(2) = 1: CALL landmark(1, 1)
      items(10) = 1
     ELSE
      CALL slowtalk("Harrde Dryve: Ha! Too bad! The Harrde Ribbon is mine!", 2, 2, 12, 1, 1)
      CALL landmark(1, 1)
     END IF
    END IF
  END IF

  IF (manposx = 13 AND manposy = 6 AND facing$ = "u") THEN
    CALL slowtalk("DemoLand Field. Up north is DemoLand Beach!", 3, 2, 4, 1, 0)
    CALL slowtalk("    Just ahead is the DemoLand Shop!", 4, 2, 4, 0, 0)
    CALL slowtalk("Watch out for harmful monsters on DemoLand Beach!", 5, 2, 4, 0, 1)
    CALL landmark(1, 1)
  END IF

  IF manposx = 10 AND manposy = 3 AND facing$ = "u" THEN
    screenx = 1: screeny = 75    'shop1
    manposx = 8: manposy = 11
  END IF
END IF
'screenx = 2, screeny = 1
'********************************************
IF screenx = 2 AND screeny = 1 THEN
  IF manposx = 13 AND manposy = 10 AND facing$ = "u" THEN
     CALL slowtalk("Dzipe: This is so boring....", 2, 2, 7, 1, 1)
     CALL slowtalk("Delce: Boring? Where are we? I can't remember anything! All of a sudden I", 3, 2, 15, 0, 0)
     CALL slowtalk("popped up here! What is this place??", 4, 2, 15, 0, 1)
     CALL slowtalk("Dzipe: Whoa, calm down, dude! This is DemoLand! Our creator is so lazy!!", 5, 2, 7, 0, 0)
     CALL slowtalk("I'm the one who should be complaining! I can't even move, look what", 6, 2, 7, 0, 1)
     CALL slowtalk("happens if I try!", 2, 2, 7, 1, 1)
     PUT (520, 360), grass, PSET
     CALL chaput(520, 360, sign(), 40, 2)
     CALL slowtalk("Aaaah!! See?? At least YOU can move!", 3, 2, 7, 0, 1)
     CALL slowtalk("Delce: HAHAHAHA!! LOL!", 4, 2, 15, 0, 1)
     CALL slowtalk("Dzipe: OK.. whatever.. We have to wait for our creator to make this world", 5, 2, 7, 0, 0)
     CALL slowtalk("bigger! All there is here is a beach and a shop! And some weird guy who ", 6, 2, 7, 0, 1)
     CALL slowtalk("scares me! ...sigh...probably a few more weeks...", 2, 2, 7, 1, 1)
    IF people(1) = 0 THEN
     CALL slowtalk("I found this lying around. I don't know what it's for. You have it.", 3, 2, 7, 0, 1)
     CALL slowtalk("      You received a Hook!", 4, 2, 1, 1, 1)
     people(1) = 1
     equipm(1) = 1
    END IF
     CALL landmark(2, 1)
    END IF
  IF manposx = 5 AND manposy = 4 AND facing$ = "l" THEN
    CALL slowtalk("Farmer: Hiya there!", 2, 2, 1, 1, 1)
    CALL slowtalk("Delce: Ummmm... WHAT are you?", 3, 2, 15, 0, 1)
    CALL slowtalk("Farmer: I'm Farmer Smurf! I am a creation of Mariano Enterprises...", 4, 2, 1, 0, 1)
    CALL slowtalk("Delce: I see... and our creator decided to put you in here just for the", 5, 2, 15, 0, 0)
    CALL slowtalk("hell of it?", 6, 2, 15, 0, 1)
    CALL slowtalk("Farmer: That's right! Durf durf smurf!", 2, 2, 1, 1, 1)
    CALL slowtalk("Delce: Ok.........", 3, 2, 15, 0, 1)
    CALL landmark(2, 1)
  END IF
END IF
'**************************************************
IF screenx = 3 AND screeny = 1 THEN
 'sign
  IF manposx = 8 AND manposy = 8 AND facing$ = "u" THEN
   CALL slowtalk("Exit to Demoland to the East!", 3, 3, 1, 1, 0)
   CALL slowtalk("Watch out for monsters! Equip a weapon if you haven't already!", 4, 3, 1, 0, 1)
   CALL landmark(3, 1)
  END IF
  IF manposx = 11 AND manposy = 8 AND facing$ = "u" THEN
   IF items(10) < 1 THEN
    CALL slowtalk("GUARD: Sorry, I can't let you leave! You need the Harrde Ribbon", 2, 2, 3, 1, 0)
    CALL slowtalk("if you wanna get out of DemoLand!", 3, 2, 3, 0, 1)
    CALL slowtalk("Delce: ""Harrde Ribbon""?? What the hell is that??", 4, 2, 15, 0, 1)
    CALL slowtalk("GUARD: I don't know, but I'll know it when I see it! Now scram, kid!", 5, 2, 3, 0, 1)
   END IF
   IF items(10) = 1 AND people(3) = 0 THEN CALL video(1)
   IF people(3) = 1 THEN
    CALL slowtalk("GUARD: Go on! I'll stand guard..", 2, 2, 3, 1, 1)
   END IF
    CALL landmark(3, 1)
  END IF

END IF
'**************************************************

IF screenx = 4 AND screeny = 1 THEN
 IF manposx = 3 AND manposy = 6 AND facing$ = "u" THEN
  CALL slowtalk("Blurf Forest is to the East!", 3, 3, 1, 1, 0)
  CALL slowtalk("Farther East is Blurf Town and the Train Station.", 4, 3, 1, 0, 0)
  CALL slowtalk("The bridge to the North is still far away...", 5, 3, 1, 0, 1)
  CALL landmark(4, 1)
 END IF
END IF
'***********************
 IF screenx = 7 AND screeny = 1 THEN
  IF manposx = 3 AND manposy = 9 AND facing$ = "l" THEN
   IF people(4) = 0 THEN
   CALL slowtalk("MAN: Yo! This forest is a real maze, huh? Bet you're tired from all those", 2, 2, 2, 1, 0)
   CALL slowtalk("monster attacks!", 3, 2, 2, 0, 1)
   CALL slowtalk("Delce: You bet! How the hell do I get out of here!?", 4, 2, 15, 0, 1)
   CALL slowtalk("MAN: That's for me to know and you to find out! Mwhahaha!!", 5, 2, 2, 0, 1)
   CALL slowtalk("Delce: Then get out of my way! I gotta get out of here! ", 6, 2, 15, 0, 1)
   CALL slowtalk("MAN: Not so fast... Perhaps you'd like to do a little dealing! Say, I give", 2, 2, 2, 1, 0)
   CALL slowtalk("you an item in exchange for some moolah, gold, GPs, dinero..", 3, 2, 2, 0, 0)
   CALL slowtalk("Delce: I get the point! I guess I do need some items...", 4, 2, 15, 0, 1)
   people(4) = 1
   END IF
   CALL shop(2)
  END IF
 END IF
'*************************
IF screenx = 10 AND screeny = 1 THEN
 IF manposx = 6 AND manposy = 4 AND facing$ = "u" THEN
  CALL slowtalk(" This here is Blurf Town! The information center is to the right.", 2, 2, 1, 1, 0)
  CALL slowtalk(" The railroad passes straight through North Blurf Town. If you'd like to ride", 3, 2, 1, 0, 0)
  CALL slowtalk("the train keep heading east until you reach the train station. It's not very", 4, 2, 1, 0, 0)
  CALL slowtalk("far! Talking to people in this town can help you in your quest!", 5, 2, 1, 0, 1)
  CALL slowtalk("Delce: I don't even know what my quest is...", 2, 2, 15, 1, 1)
  CALL landmark(10, 1)
 END IF
 IF manposx = 3 AND manposy = 5 AND facing$ = "u" THEN
    screenx = 1: screeny = 77     'house 1
    manposx = 8: manposy = 11
 END IF
 IF manposx = 3 AND manposy = 9 AND facing$ = "u" THEN
    screenx = 2: screeny = 77     'house 2
    manposx = 8: manposy = 11
 END IF
 IF manposx = 13 AND manposy = 5 AND facing$ = "u" THEN
    screenx = 3: screeny = 77     'house 3
    manposx = 8: manposy = 11
 END IF
 IF manposx = 13 AND manposy = 9 AND facing$ = "u" THEN
    screenx = 4: screeny = 77     'house 4
    manposx = 8: manposy = 11
 END IF

END IF
'***************************
IF screenx = 9 AND screeny = 2 THEN
 IF manposx = 11 AND manposy = 7 AND facing$ = "u" THEN
    screenx = 2: screeny = 75    'inn
    manposx = 8: manposy = 11
 END IF
END IF

'***************************
IF screenx = 1 AND screeny = 75 THEN
 'shop
  IF manposx = 3 AND manposy = 7 AND facing$ = "l" THEN
      CALL slowtalk("PERSON: Hey! You can go to the options menu by pressing 'o'!", 2, 2, 7, 1, 0)
      CALL slowtalk("There you can equip WEAPONs, use ITEMs and save and load GAMEs!", 3, 2, 7, 0, 1)
      CALL slowtalk("In this shop, they sell DRUGs to restore your HP!", 2, 2, 7, 1, 1)
    IF delce(1) < delce(2) THEN
     CALL slowtalk("And it looks like you need some!", 3, 2, 7, 0, 1)
    END IF
     CALL slowtalk("They also sell WEAPONs, but a kid like you wouldn't have enough money!", 4, 2, 7, 0, 1)
     CALL putalltiles
     CALL chaput(120, 280, manl(), 40, 15)
     CALL chaput(330, 100, shopk(), 30, 1)
  END IF
  IF manposx = 8 AND manposy = 4 AND facing$ = "u" THEN CALL shop(1)
 
END IF


'*****************************************
IF screenx = 1 AND screeny = 77 THEN
 'house1
  IF manposx = 3 AND manposy = 5 AND facing$ = "u" THEN
   IF people(5) = 0 THEN
   CALL slowtalk("Maureen: Why hello there, handsome! What's your name?", 2, 2, 8, 1, 1)
   CALL slowtalk("Delce: My name is Delce Arcar. What's yours, babe?", 3, 2, 15, 0, 1)
   CALL slowtalk("Maureen: My name is Maureen! And this here is my twin sister Lurleen!", 4, 2, 8, 0, 1)
   CALL slowtalk("Delce: Maureen, cute name! Can you help me? I appeared in 'DemoLand'", 5, 2, 15, 0, 0)
   CALL slowtalk("a while ago, and I made my way here. I can't remember anything! Do you know", 6, 2, 15, 0, 1)
   CALL slowtalk("what happened to the King? For some reason I remember the King..", 2, 2, 15, 1, 1)
   CALL slowtalk("Maureen: You should know what happened to the King! He's dead now! His", 3, 2, 8, 0, 0)
   CALL slowtalk("brother, however, will soon be crowned King! I don't trust him much", 4, 2, 8, 0, 0)
   CALL slowtalk("though..", 5, 2, 8, 0, 1)
   CALL slowtalk("Delce: Ah.. yes! It's coming back to me.. The King..was poisoned! I saw it!", 6, 2, 15, 0, 1)
   CALL slowtalk("I was in the castle! I don't know why, but ..I.. I can't remember!! I remember", 2, 2, 15, 1, 0)
   CALL slowtalk("that somehow the King was poisoned.. I don't know who did it...", 3, 2, 15, 0, 1)
   CALL slowtalk("Maureen: Oh come on! The King died of old age, that's all! And why would a kid", 4, 2, 8, 0, 0)
   CALL slowtalk("like you be in the castle in the first place?", 5, 2, 8, 0, 1)
   people(5) = 1
   END IF
   IF people(5) = 1 THEN
   CALL slowtalk("Delce: Yeah! He told me! His last words were...'Make sure my son gets the ", 2, 2, 15, 1, 0)
   CALL slowtalk("throne!' I have to stop his brother! Where's the castle?", 3, 2, 15, 0, 1)
   CALL slowtalk("Maureen: You're crazy, kid...", 4, 2, 8, 0, 1)
   END IF
   CALL landmark(1, 77)
  END IF
   IF manposx = 6 AND manposy = 5 AND facing$ = "u" THEN
    CALL slowtalk("Lurleen: Why did you barge into our house like that?", 2, 2, 8, 1, 1)
    CALL slowtalk("Delce: Ah.. I.. the door was open..", 3, 2, 15, 0, 1)
    CALL slowtalk("Lurleen: So? Don't you have any manners? Geez!", 4, 2, 8, 0, 1)
    CALL landmark(1, 77)
   END IF
END IF

IF xnow = screenx AND ynow = screeny THEN

testerx = manposx
testery = manposy
IF facing$ = "u" THEN testery = testery - 1
IF facing$ = "d" THEN testery = testery + 1
IF facing$ = "l" THEN testerx = testerx - 1
IF facing$ = "r" THEN testerx = testerx + 1
IF tiles(testerx, testery) <> 7 THEN
SELECT CASE tiles(testerx, testery)
 CASE 6
  CALL slowtalk("It's a shop. Why don't you try going IN it?", 3, 2, 1, 1, 1)
 CASE 8
  CALL slowtalk("It's just a tree, man! Stop wasting time!", 3, 2, 1, 1, 1)
 CASE 9
  CALL slowtalk("This water looks deep!", 3, 2, 1, 1, 1)
 CASE 11
  CALL slowtalk("No, dumb, you can't go through this wall!", 3, 2, 1, 1, 1)
 CASE 12
  CALL slowtalk("A tree. Oh boy!", 3, 2, 1, 1, 1)
 CASE 13
  CALL slowtalk("Some train tracks. Wonder where the station is!", 3, 2, 1, 1, 1)
 CASE 14
  CALL slowtalk("Go IN the Inn! Haa!", 3, 2, 1, 1, 1)
 CASE 15
  CALL slowtalk("It looks like any old house.. Use the door.", 3, 2, 1, 1, 1)
 CASE 16
  CALL slowtalk("A cave entrance... spooky, huh? Go in it you chicken!", 3, 2, 1, 1, 1)
 CASE 17
  CALL slowtalk("A table. Oh wow!", 3, 2, 1, 1, 1)
 END SELECT
CALL landmark(screenx, screeny)
END IF
END IF
END SUB

SUB delayer ()
 FOR a = 1 TO (delay / wspeed)
 NEXT
END SUB

SUB equip ()
begin:
CLS
 COLOR 15
GOSUB dispweap
GOSUB dispmenu
LINE (350, 10)-(635, 300), 4, B
   LINE (10, 205)-(300, 475), 4, B
   LINE (350, 10)-(635, 300), 4, B
   CALL chaput(15, 215, mand(), 40, 15)
   LOCATE 14, 10
   PRINT "Weapon:"
   LOCATE 15, 10
   PRINT "Armor:"
   IF party(2) = 1 THEN
    CALL chaput(15, 295, dzipepic(), 40, 4)
    LOCATE 19, 10
    PRINT "Weapon:"
    LOCATE 20, 10
    PRINT "Armor:"
   END IF
   smurf2$ = INKEY$
   equipopt = 1
   LOCATE 3, 51: PRINT ">"
   GOSUB dispmenu
  
   LOCATE 13, 53: PRINT "Back to Game"
   LOCATE 14, 53: PRINT "Unarm"
   LOCATE 16, 53: PRINT "To equip a new weapon, you"
   LOCATE 17, 53: PRINT "must first select 'Unarm'"
   '*********************************************
   DO WHILE smurf2$ <> "q"
    smurf2$ = INKEY$
IF smurf2$ = CHR$(0) + "H" THEN smurf$ = "w"
IF smurf2$ = CHR$(0) + "P" THEN smurf$ = "s"

    SELECT CASE smurf2$
  CASE "s"
  IF equipopt < 12 THEN
  LOCATE equipopt + 2, 51
  PRINT " "
  equipopt = equipopt + 1
  LOCATE equipopt + 2, 51
  PRINT ">"
  END IF
   CASE "w"
  IF equipopt > 1 THEN
  LOCATE equipopt + 2, 51
  PRINT " "
   equipopt = equipopt - 1
  LOCATE equipopt + 2, 51
  PRINT ">"
  END IF
   CASE " "
    GOTO derf
   END SELECT
   LOOP
'*********************************************

derf:
    IF equipopt < 11 THEN
     IF equipm(equipopt) > 0 THEN GOTO putonchar
    END IF
    IF equipopt = 12 THEN GOTO putonchar
    EXIT SUB
'*********************************************
putonchar:
   maxper = 16
   IF party(2) = 1 THEN maxper = 20
   IF party(3) = 1 THEN maxper = 24
   IF party(4) = 1 THEN maxper = 28
   peropt = 16
   LOCATE peropt, 3: PRINT ">": smurf2$ = ""
   DO WHILE smurf2$ <> "q"
    smurf2$ = INKEY$
IF smurf2$ = CHR$(0) + "H" THEN smurf$ = "w"
IF smurf2$ = CHR$(0) + "P" THEN smurf$ = "s"

    SELECT CASE smurf2$
  CASE "s"
  IF peropt < maxper THEN
  LOCATE peropt, 3
  PRINT " "
  peropt = peropt + 4
  LOCATE peropt, 3
  PRINT ">"
  END IF
   CASE "w"
  IF peropt > 16 THEN
  LOCATE peropt, 3
  PRINT " "
   peropt = peropt - 4
  LOCATE peropt, 3
  PRINT ">"
  END IF
   CASE " "
    GOTO klerf
   END SELECT
   LOOP

'*********************************************
klerf:
 IF peropt = 16 THEN
  IF equipopt = 1 AND equipm(1) > 0 AND delce(7) = 0 THEN delce(7) = 10: equipm(1) = equipm(1) - 1
  IF equipopt = 2 AND equipm(2) > 0 AND delce(7) = 0 THEN delce(7) = 25: equipm(2) = equipm(2) - 1
  IF equipopt = 6 AND equipm(6) > 0 AND delce(8) = 0 THEN delce(8) = 10: equipm(6) = equipm(6) - 1
  IF equipopt = 7 AND equipm(7) > 0 AND delce(8) = 0 THEN delce(8) = 25: equipm(7) = equipm(7) - 1
  IF equipopt = 12 AND delce(7) = 10 THEN delce(7) = 0: equipm(1) = equipm(1) + 1
  IF equipopt = 12 AND delce(7) = 25 THEN delce(7) = 0: equipm(2) = equipm(2) + 1
  IF equipopt = 12 AND delce(8) = 10 THEN delce(8) = 0: equipm(6) = equipm(6) + 1
  IF equipopt = 12 AND delce(8) = 25 THEN delce(8) = 0: equipm(7) = equipm(7) + 1
  GOSUB dispmenu
  GOSUB dispweap
 END IF
 IF peropt = 20 THEN
  IF equipopt = 1 AND equipm(1) > 0 AND dzipe(7) = 0 THEN dzipe(7) = 10: equipm(1) = equipm(1) - 1
  IF equipopt = 2 AND equipm(2) > 0 AND dzipe(7) = 0 THEN dzipe(7) = 25: equipm(2) = equipm(2) - 1
  IF equipopt = 6 AND equipm(6) > 0 AND dzipe(8) = 0 THEN dzipe(8) = 10: equipm(6) = equipm(6) - 1
  IF equipopt = 7 AND equipm(7) > 0 AND dzipe(8) = 0 THEN dzipe(8) = 25: equipm(7) = equipm(7) - 1
  IF equipopt = 12 AND dzipe(7) = 10 THEN dzipe(7) = 0: equipm(1) = equipm(1) + 1
  IF equipopt = 12 AND dzipe(7) = 25 THEN dzipe(7) = 0: equipm(2) = equipm(2) + 1
  IF equipopt = 12 AND dzipe(8) = 10 THEN dzipe(8) = 0: equipm(6) = equipm(6) + 1
  IF equipopt = 12 AND dzipe(8) = 25 THEN dzipe(8) = 0: equipm(7) = equipm(7) + 1
  GOSUB dispmenu
  GOSUB dispweap
 END IF


 DO WHILE INKEY$ = ""
 LOOP
GOTO begin
'*********************************************
dispweap:
    
    IF delce(7) = 0 THEN
     LOCATE 14, 19
     PRINT "None         "
    END IF
    IF delce(7) = 10 THEN
     LOCATE 14, 19
     PRINT "Hook         "
    END IF
    IF delce(7) = 25 THEN
     LOCATE 14, 19
     PRINT "Axe          "
    END IF
    IF delce(8) = 0 THEN
     LOCATE 15, 18
     PRINT "None         "
    END IF
    IF delce(8) = 10 THEN
     LOCATE 15, 18
     PRINT "Wool Vest    "
    END IF
    IF delce(8) = 25 THEN
     LOCATE 15, 18
     PRINT "Leather Vest "
    END IF
     LOCATE 22, 50
     PRINT "(Delce) Attack: "; delce(3) + delce(7); "  "
     LOCATE 23, 50
     PRINT "(Delce) Defense: "; delce(4) + delce(8); "  "
IF party(2) = 1 THEN

    IF dzipe(7) = 0 THEN
     LOCATE 19, 19
     PRINT "None         "
    END IF
    IF dzipe(7) = 10 THEN
     LOCATE 19, 19
     PRINT "Hook         "
    END IF
    IF dzipe(7) = 25 THEN
     LOCATE 19, 19
     PRINT "Axe          "
    END IF
    IF dzipe(8) = 0 THEN
     LOCATE 20, 18
     PRINT "None         "
    END IF
    IF dzipe(8) = 10 THEN
     LOCATE 20, 18
     PRINT "Wool Vest    "
    END IF
    IF dzipe(8) = 25 THEN
     LOCATE 20, 18
     PRINT "Leather Vest "
    END IF
     LOCATE 24, 50
     PRINT "(Dzipe) Attack: "; dzipe(3) + dzipe(7); "  "
     LOCATE 25, 50
     PRINT "(Dzipe) Defense: "; dzipe(4) + dzipe(8); "  "
END IF

    RETURN
'*********************************************
dispmenu:
   IF equipm(1) > 0 THEN : LOCATE 3, 53: PRINT "Hook "; "("; equipm(1); ")"
   IF equipm(2) > 0 THEN : LOCATE 4, 53: PRINT "Axe"; "("; equipm(2); ")"
   IF equipm(6) > 0 THEN : LOCATE 8, 53: PRINT "Wool Vest "; "("; equipm(6); ")"
   IF equipm(7) > 0 THEN : LOCATE 9, 53: PRINT "Leather Vest "; "("; equipm(7); ")"
   IF equipm(8) > 0 THEN : LOCATE 10, 53: PRINT "Hauberk"; "("; equipm(8); ")"
   IF equipm(9) > 0 THEN : LOCATE 11, 53: PRINT "Knight Armor"; "("; equipm(9); ")"
 RETURN
END SUB

SUB fight (techs() AS INTEGER, pic() AS INTEGER, thissize, id$, monhp, attack, defense, evade, numat, ign, bg)
 lostbat = 0
 FOR churf = 0 TO 15
  FOR lurf = 0 TO 11
   tiles(churf, lurf) = bg
  NEXT
 NEXT
numatkers = 1
beber = monhp: curx = manposx: cury = manposy
GOSUB setscreen
GOTO here
LOCATE 1, 1
PRINT techs

setscreen:
CLS
CALL putalltiles
CALL chaput(319, 119, pic(), thissize, ign)
CALL chaput(160, 120, manr(), 40, 15)
IF party(1) = 2 THEN
 numatkers = 2
 CALL chaput(160, 170, dzipepic(), 40, 1)
END IF
manposx = 4
manposy = 3
 COLOR 15
 LINE (5, 350)-(635, 475), 7, B
 PAINT (6, 351), 0, 7
 LOCATE 24, 60
 PRINT id$
RETURN

here:
''shell "start /m batt.mid"
 myturn = 1
 IF monhp > delce(1) THEN myturn = 0

dammit:
 damage = 0
 IF myturn > 0 THEN
   opt = 1
   smurf$ = ""
   LOCATE 24, 4
   PRINT "Fight"
   LOCATE 25, 4
   PRINT "Magic"
   LOCATE 26, 4
   PRINT "Item"
   LOCATE 27, 4
   PRINT "Run"
   LOCATE 24, 15
   PRINT "HP: "; delce(1); "/"; delce(2); "  "
   LOCATE 24, 30
   PRINT "MP: "; delce(9); "/"; magic; "  "
   IF numatkers > 1 THEN
   LOCATE 25, 15
   PRINT "HP: "; dzipe(1); "/"; dzipe(2); " "
   LOCATE 25, 30
   PRINT "MP: "; dzipe(9); "/"; magic
   END IF
    DO WHILE myturn > 0
     LOCATE 23 + opt, 2
     PRINT ">"
     smurf$ = INKEY$
IF smurf$ = CHR$(0) + "H" THEN smurf$ = "w"
IF smurf$ = CHR$(0) + "K" THEN smurf$ = "a"
IF smurf$ = CHR$(0) + "M" THEN smurf$ = "d"
IF smurf$ = CHR$(0) + "P" THEN smurf$ = "s"

     SELECT CASE smurf$
       CASE "s"
        IF opt < 4 THEN
         LOCATE 23 + opt, 2: PRINT " "
         opt = opt + 1
         LOCATE 23 + opt, 2: PRINT ">"
        END IF
       CASE "w"
        IF opt > 1 THEN
         LOCATE 23 + opt, 2: PRINT " "
         opt = opt - 1
         LOCATE 23 + opt, 2: PRINT ">"
        END IF
       CASE " "
        GOTO fightact
     END SELECT
     LOOP
fightact:
   IF opt = 1 THEN
    IF myturn = 1 THEN
     IF delce(7) = 0 THEN atname$ = "Punch"
     IF delce(7) = 10 THEN atname$ = "Hook"
     IF delce(7) = 25 THEN atname$ = "Axe"
    END IF
    IF myturn = 2 THEN
     IF dzipe(7) = 0 THEN atname$ = "Punch"
     IF dzipe(7) = 10 THEN atname$ = "Hook"
     IF dzipe(7) = 25 THEN atname$ = "Axe"
    END IF
   END IF
   IF opt = 2 AND magic = 0 THEN
    LOCATE 25, 12: PRINT "No magic yet!"
    DO WHILE INKEY$ = "": LOOP
    LOCATE 25, 12: PRINT "             "
    LOCATE 25, 2: PRINT " "
   END IF
   IF opt = 3 THEN
    sum = 0
    FOR x = 1 TO 10
     sum = sum + items(x)
    NEXT
    CALL useitems
    GOSUB setscreen
    sum2 = 0
    FOR x = 1 TO 10
     sum2 = sum2 + items(x)
    NEXT
    IF sum2 = sum THEN GOTO dammit
   END IF
   IF opt = 4 THEN
    a = 0
    IF id$ <> "Harrde Dryve" THEN a = 1 'a = INT(RND * 2)
     IF a = 1 THEN
      CALL slowtalk("You ran from battle!", 3, 10, 15, 1, 1)
      CLS
      manposx = curx: manposy = cury
      CALL landmark(screenx, screeny)
      EXIT SUB
     END IF
     IF a = 0 THEN
      CALL slowtalk("You were unable to run!", 3, 10, 15, 1, 1)
      LOCATE 3, 10: PRINT "                       "
      LOCATE 27, 2: PRINT " "
     END IF
   END IF
    GOTO attack1
    GOTO dammit
END IF
'*************************************************
IF myturn = 0 THEN
 at = INT(RND * numat) + 1
 ber = techs(at)
  IF ber = 1 THEN atname$ = "Sandman"
  IF ber = 2 THEN atname$ = "Stinger"
  IF ber = 3 THEN atname$ = "Pincer"
  IF ber = 4 THEN atname$ = "Drain You"
  IF ber = 5 THEN atname$ = "Spore"
  myturn = 1
END IF

'************************************************
attack1:
 ' merf$ = atname$ + "       "
 ' CALL slowtalk(merf$, 3, 20, 15, 0, 0)
   klurf = myturn
   SELECT CASE atname$
   CASE "Hook", "Punch", "Axe"
   myturn = myturn + 1: IF myturn > numatkers THEN myturn = 0: GOSUB attack2
   CASE "Sandman", "Stinger", "Pincer", "Drain You"
   myturn = 1: GOSUB attack3
   CASE "Spore"
   myturn = 1: GOSUB attack3
  END SELECT
 IF myturn = 0 THEN
  say$ = "Delce used " + atname$ + " on " + id$ + " for " + FORMAT$(damage) + " HP of damage!"
 END IF
 IF klurf = 2 THEN
  say$ = "Dzipe used " + atname$ + " on " + id$ + " for " + FORMAT$(damage) + " HP of damage!"
 END IF
 IF myturn = 1 THEN
  say$ = id$ + " used " + atname$ + " on Delce for " + FORMAT$(damage) + " HP of damage!!"
 END IF
  CALL slowtalk(say$, 2, 2, 15, 1, 0)
 IF delce(1) < (.1) * delce(2) THEN
  say$ = "Uh-oh!! Things are looking dreary for Delce!"
  CALL slowtalk(say$, 5, 2, 15, 0, 0)
  CALL slowtalk("Will Delce heal himself?? Or is this the end of our venerable hero?", 6, 2, 15, 0, 0)
 END IF
 IF poison = 1 THEN
  say$ = "Delce is poisoned!"
  CALL slowtalk(say$, 4, 2, 15, 0, 0)
 END IF
 IF monhp < 1 THEN GOTO win
  GOTO dammit
'************************************************
attack2:
  FOR a = 1 TO 2
     CALL movearound("d", 1)
     CALL delayer: CALL delayer
  NEXT
    a = INT(RND * 100) + 1
    IF a > evade THEN
     IF klurf = 1 THEN
      damage = delce(3) + delce(7) + INT((RND * delce(3)) / 2)
      damage = damage - defense
     END IF
     IF klurf = 2 THEN
      damage = dzipe(3) + dzipe(7) + INT((RND * dzipe(3)) / 2)
      damage = damage - defense
     END IF
     LOCATE 6, 38
     COLOR 4
     PRINT damage
     monhp = monhp - damage
     COLOR 15
     FOR a = 1 TO (delay * 10)
     NEXT
     LOCATE 6, 38: PRINT "     "
    ELSE
     LOCATE 6, 38: PRINT "MISS"
     FOR a = 1 TO (delay * 10)
     NEXT
     LOCATE 6, 38: PRINT "    "
    END IF
    FOR a = 1 TO 2
    CALL movearound("a", 1)
    NEXT
    CALL putthesetiles(4, 3)
    CALL chaput(160, 120, manr(), 40, 15)
   
    LOCATE 3, 20: PRINT "                  "
    FOR a = 0 TO 11
     FOR B = 0 TO 2
      CALL putthesetiles(a, B)
     NEXT
    NEXT

RETURN
'*************
attack3:
 a = INT(RND * 100)
 IF a > delce(6) THEN
 CALL batanim(ber)
 IF ber = 1 THEN GOSUB setscreen
 damage = INT(ber * 1.5) + attack - (delce(4) + delce(8)) + (INT(RND * (attack / 2)))
 IF damage <= 0 THEN damage = 1
 delce(1) = delce(1) - damage
  COLOR 4
  LOCATE 6, 20
  PRINT damage
  COLOR 15
  FOR a = 1 TO (delay * 10)
  NEXT
  LOCATE 6, 20: PRINT "     "
  IF ber = 4 THEN
   COLOR 2: LOCATE 6, 38: PRINT damage
   FOR a = 1 TO (delay * 10): NEXT
   LOCATE 6, 38: PRINT "     "
   monhp = monhp + damage: IF monhp > beber THEN monhp = beber
  END IF
  IF ber = 5 THEN
   poison = 1
  END IF
  IF poison = 1 THEN
   COLOR 4
   LOCATE 6, 20
   PRINT INT(delce(2) * .1)
   delce(1) = delce(1) - INT(delce(2) * .1)
   COLOR 15
   FOR a = 1 TO (delay * 10)
   NEXT
   LOCATE 6, 20: PRINT "     "
  END IF
 ELSE
  LOCATE 6, 20
  PRINT "MISS"
  FOR a = 1 TO (delay * 10)
  NEXT
  LOCATE 6, 20: PRINT "    "
 END IF
 IF delce(1) <= 0 THEN GOTO lose
 
RETURN
'*************
win:
 CALL putthesetiles(8, 3)
 CALL slowtalk("You win!", 2, 10, 15, 1, 1)
 expgained = INT(beber / 2.5) + attack + defense
 der$ = "You gained " + FORMAT$(expgained) + " EXP. Points!!"
 CALL slowtalk(der$, 3, 3, 15, 0, 1)
 delce(5) = delce(5) + expgained
 moneypicked = beber + INT(RND * attack)
 der$ = "You also picked up " + FORMAT$(moneypicked) + " GPs!!"
 CALL slowtalk(der$, 4, 3, 15, 0, 1)
 money = money + moneypicked
 IF (delce(5) >= ((delce(6) * delce(6) * 99))) THEN CALL levelup(1)
  manposx = curx: manposy = cury
 CLS
 CALL landmark(screenx, screeny)
 EXIT SUB
'******************
lose:
 FOR churf = 0 TO 15
  FOR lurf = 0 TO 11
   tiles(churf, lurf) = -1
  NEXT
 NEXT
 CALL putalltiles
 CALL chaput(160, 120, manr(), 40, 15)
 CALL slowtalk("You lose...", 2, 10, 1, 1, 1)
 CALL slowtalk("Delce: What? No! That can't be right!", 3, 2, 15, 0, 1)
 CALL slowtalk("Sorry pal.. besides.. why are you talking? You're supposed to be dead!", 4, 2, 1, 0, 1)
 CALL slowtalk("Delce: Oh yea... dammit all to hell!", 5, 2, 15, 0, 0)
 DO WHILE INKEY$ = ""
 LOOP
 lostbat = 1
 CLS
 LOCATE 10, 3
 PRINT "Would you like to continue? (y/n)"
 DO WHILE churf$ <> "y" AND churf$ <> "n": churf$ = INKEY$: LOOP
  IF churf$ = "y" THEN
   manposx = 2: manposy = 2: screenx = 1: screeny = 1
   delce(1) = delce(2)
   CALL landmark(1, 1)
   money = INT(money / 2)
  END IF
  IF churf$ = "n" THEN END

END SUB

SUB intro ()
babarhuhur:
CLS
COLOR 1
CALL slowtalk("Quest for the Rightful Successor", 12, 15, 1, 0, 0)
CALL slowtalk("CesarWare (C) 1999, 2000", 14, 18, 1, 0, 0)
CALL slowtalk("Beta Version 3.0", 17, 60, 15, 0, 0)
LOCATE 19, 35
PRINT "<S>tart game"
LOCATE 20, 35
PRINT "<H>elp"
smurf$ = ""
DO WHILE smurf$ <> "s" AND smurf$ <> "h"
 smurf$ = INKEY$
LOOP
SELECT CASE smurf$
 CASE "s"
  EXIT SUB
 CASE "h"
  CLS
  LOCATE 2, 2
  PRINT "Quest for the Rightful Successor .. Beta Version 3.0"
  LOCATE 4, 1
  PRINT "- Move around the RPG overworld by pressing the arrow keys!"
  PRINT "- Press o to open the options menu!"
  PRINT "- Moving into the sand or the forest brings up random enemy fights!"
  PRINT "- Explore the world around you before venturing into battles!"
  PRINT "- In this version of the game, you can get as far as the second town, but you "
  PRINT "cannot cross the river yet. The train station is also inoperational."
  PRINT "- When you get this far, just save the game and I might send you the new "
  PRINT "version with"
  PRINT
  PRINT "Have fun!"
  PRINT
  PRINT
  PRINT
  PRINT "CesarWare     ---->   CesarSa1ad@aol.com"
  DO WHILE INKEY$ = ""
  LOOP
  GOTO babarhuhur
 END SELECT
END SUB

SUB landmark (screenx, screeny)

FOR churf = 0 TO 15
 FOR lurf = 0 TO 11
  tiles(churf, lurf) = -1
 NEXT
NEXT


'screenx = 1, screeny = 1
IF screenx = 1 AND screeny = 1 THEN
FOR churf = 0 TO 15
 FOR lurf = 0 TO 11
  tiles(churf, lurf) = 0
 NEXT
NEXT

tiles(10, 2) = 6   'shop
 FOR a = 0 TO 11
  tiles(0, a) = 8
 NEXT

 FOR a = 1 TO 15
  tiles(a, 11) = 8
 NEXT
tiles(12, 2) = 8   'tree
tiles(4, 7) = 8

CALL putalltiles

tiles(13, 5) = 7   'sign
IF people(2) = 0 THEN
tiles(10, 9) = 7   'character
CALL chaput(400, 360, harrde(), 40, 0)
END IF
CALL chaput(520, 200, sign(), 40, 2)
GOTO endmark
END IF

'screenx = 2, screeny = 1

IF screenx = 2 AND screeny = 1 THEN
FOR churf = 0 TO 15
 FOR lurf = 0 TO 11
  tiles(churf, lurf) = 0
 NEXT
NEXT
FOR a = 0 TO 15
 tiles(a, 11) = 8
NEXT

CALL putalltiles
tiles(13, 9) = 7
CALL chaput(520, 360, dzipepic(), 40, 4)
tiles(4, 4) = 7
CALL chaput(160, 160, farmer(), 40, 11)
GOTO endmark
END IF

IF screenx = 3 AND screeny = 1 THEN
FOR churf = 0 TO 15
FOR lurf = 0 TO 11
 tiles(churf, lurf) = 0
NEXT
NEXT
FOR a = 0 TO 11
tiles(13, a) = 9
NEXT
tiles(13, 8) = 5
FOR a = 0 TO 2
tiles(a, 11) = 8
NEXT
IF people(3) = 0 THEN tiles(12, 8) = 8
CALL putalltiles
tiles(8, 7) = 7
tiles(11, 7) = 7
CALL chaput(320, 280, sign(), 40, 2)
CALL chaput(440, 280, guard(), 30, 2)
GOTO endmark
END IF

IF screenx = 4 AND screeny = 1 THEN
FOR churf = 0 TO 15
 FOR lurf = 0 TO 11
  tiles(churf, lurf) = 3
 NEXT
NEXT
FOR a = 0 TO 4
 FOR B = 0 TO 11
  tiles(a, B) = 0
 NEXT
NEXT
FOR a = 0 TO 11
 IF a <> 7 THEN tiles(5, a) = 8
NEXT
CALL putalltiles
tiles(3, 5) = 7
CALL chaput(120, 200, sign(), 40, 2)
GOTO endmark
END IF

IF screenx = 5 AND screeny = 1 THEN
FOR churf = 0 TO 15
 FOR lurf = 0 TO 11
  tiles(churf, lurf) = 3
 NEXT
NEXT
FOR a = 8 TO 13
FOR B = 0 TO 2
 tiles(a, B) = 9
NEXT
NEXT
FOR a = 3 TO 15
tiles(a, 6) = 12
NEXT
FOR a = 13 TO 15
tiles(a, 3) = 12
NEXT
CALL putalltiles
GOTO endmark
END IF

IF screenx = 6 AND screeny = 1 THEN
FOR churf = 0 TO 15
 FOR lurf = 0 TO 11
  tiles(churf, lurf) = 3
 NEXT
NEXT
FOR a = 0 TO 15
tiles(a, 6) = 12
IF a <> 9 THEN tiles(a, 3) = 12
NEXT
FOR a = 0 TO 3
tiles(8, a) = 12
NEXT
CALL putalltiles
GOTO endmark
END IF

IF screenx = 7 AND screeny = 1 THEN
CALL loadscr(7, 1)
tiles(2, 9) = 7
CALL chaput(80, 360, char1(), 40, 1)
GOTO endmark
END IF

IF screenx = 10 AND screeny = 1 THEN
 CALL loadscr(10, 1)
 tiles(6, 3) = 7
 CALL chaput(240, 120, sign(), 40, 2)
 GOTO endmark
END IF


'screenx = 1, screeny = 2
IF screenx = 1 AND screeny = 2 THEN
FOR churf = 0 TO 15
 FOR lurf = 0 TO 11
  tiles(churf, lurf) = 0
 NEXT
NEXT
FOR a = 9 TO 11
tiles(0, a) = 8
NEXT
FOR a = 3 TO 9
FOR B = 0 TO 15
 tiles(B, a) = 1
NEXT
NEXT

FOR a = 0 TO 2
FOR B = 0 TO 15
 tiles(B, a) = 9
NEXT
NEXT
CALL putalltiles
GOTO endmark
END IF

'screenx= 2, screeny = 2
IF screenx = 2 AND screeny = 2 THEN
FOR churf = 0 TO 15
 FOR lurf = 0 TO 11
  tiles(churf, lurf) = 0
 NEXT
NEXT
FOR a = 3 TO 9
FOR B = 0 TO 15
 tiles(B, a) = 1
NEXT
NEXT

FOR a = 0 TO 2
FOR B = 0 TO 15
 tiles(B, a) = 9
NEXT
NEXT
CALL putalltiles
GOTO endmark
END IF

IF screenx = 3 AND screeny = 2 THEN
FOR churf = 0 TO 15
 FOR lurf = 0 TO 11
  tiles(churf, lurf) = 0
 NEXT
NEXT
FOR a = 3 TO 9
FOR B = 0 TO 15
 tiles(B, a) = 1
NEXT
NEXT

FOR a = 0 TO 2
FOR B = 0 TO 15
 tiles(B, a) = 9
NEXT
NEXT
FOR a = 2 TO 11
 tiles(13, a) = 9
NEXT
CALL putalltiles
GOTO endmark
END IF

IF screenx = 4 AND screeny = 2 THEN
FOR churf = 0 TO 15
 FOR lurf = 0 TO 11
  tiles(churf, lurf) = 3
 NEXT
NEXT
FOR a = 0 TO 2
FOR B = 0 TO 15
 tiles(B, a) = 9
NEXT
NEXT
FOR a = 0 TO 4
 FOR B = 3 TO 11
  tiles(a, B) = 0
 NEXT
NEXT
FOR a = 4 TO 11
 tiles(5, a) = 8
NEXT
FOR a = 5 TO 15
 tiles(a, 3) = 13
NEXT
CALL putalltiles
GOTO endmark
END IF

IF screenx = 5 AND screeny = 2 THEN
FOR churf = 0 TO 15
 FOR lurf = 0 TO 11
  tiles(churf, lurf) = 3
 NEXT
NEXT
FOR a = 0 TO 2
FOR B = 0 TO 15
 tiles(B, a) = 9
NEXT
NEXT
FOR a = 0 TO 15
 tiles(a, 3) = 13
NEXT
FOR a = 8 TO 13
FOR B = 9 TO 11
 tiles(a, B) = 9
NEXT
NEXT
CALL putalltiles
GOTO endmark
END IF

IF screenx = 6 AND screeny = 2 THEN
FOR churf = 0 TO 15
 FOR lurf = 0 TO 11
  tiles(churf, lurf) = 3
 NEXT
NEXT
FOR a = 0 TO 2
FOR B = 0 TO 15
 tiles(B, a) = 9
NEXT
NEXT
FOR a = 0 TO 15
 tiles(a, 3) = 13
NEXT
FOR a = 4 TO 11
tiles(8, a) = 12
NEXT

CALL putalltiles
GOTO endmark
END IF

'*************************************************
'shop 1
 IF screenx = 1 AND screeny = 75 THEN
 'shell "start /m shop.mid"
 
  'shop 1
    FOR a = 0 TO 15
     FOR B = 0 TO 11
      tiles(a, B) = 4
     NEXT
    NEXT
   FOR a = 0 TO 15
    IF a <> 8 THEN tiles(a, 11) = 11
    tiles(a, 0) = 11
   NEXT
   FOR a = 0 TO 15
    tiles(a, 3) = 10
   NEXT
   FOR a = 0 TO 11
    tiles(0, a) = 11
    tiles(15, a) = 11
   NEXT
   CALL putalltiles
   tiles(2, 7) = 7
   CALL chaput(80, 280, char1(), 40, 1)
   CALL chaput(330, 100, shopk(), 30, 1)
   GOTO endmark
END IF
'******************************************


  IF screenx = 1 AND screeny = 74 THEN screenx = 1: screeny = 1: manposx = 10: manposy = 3: CALL landmark(1, 1): GOTO endmark 'shell "start /m over.mid"
  IF screenx = 1 AND screeny = 76 THEN screenx = 10: screeny = 1: manposx = 3: manposy = 5: CALL landmark(10, 1): GOTO endmark
  IF screenx = 2 AND screeny = 74 THEN screenx = 9: screeny = 2: manposx = 11: manposy = 8: CALL landmark(9, 2): GOTO endmark
  IF screenx = 2 AND screeny = 76 THEN screenx = 10: screeny = 1: manposx = 3: manposy = 9: CALL landmark(10, 1): GOTO endmark
  IF screenx = 3 AND screeny = 76 THEN screenx = 10: screeny = 1: manposx = 13: manposy = 5: CALL landmark(10, 1): GOTO endmark
  IF screenx = 4 AND screeny = 76 THEN screenx = 10: screeny = 1: manposx = 13: manposy = 9: CALL landmark(10, 1): GOTO endmark
  
CALL loadscr(screenx, screeny)
IF screeny > 74 THEN CALL loadchar


'temporary


endmark:

IF facing$ = "d" THEN CALL chaput(manposx * 40, manposy * 40, mand(), tilesize, 15)

IF facing$ = "u" THEN CALL chaput(manposx * 40, manposy * 40, manu(), tilesize, 15)

IF facing$ = "l" THEN CALL chaput(manposx * 40, manposy * 40, manl(), tilesize, 15)

IF facing$ = "r" THEN CALL chaput(manposx * 40, manposy * 40, manr(), tilesize, 15)



END SUB

SUB levelup (num)
IF num = 1 THEN
 'delce
 delce(6) = delce(6) + 1
 hpb4 = delce(2)
 atb4 = delce(3)
 deb4 = delce(4)
 delce(2) = delce(2) + 5 + INT(RND * 2)
 delce(3) = delce(3) + 3 + INT(RND * 2)
 delce(4) = delce(4) + 3 + INT(RND * 2)
 say$ = "Delce grew to level " + FORMAT$(delce(6)) + "!!"
 CALL slowtalk(say$, 5, 3, 15, 0, 1)
 COLOR 15
 LINE (400, 100)-(635, 200), 0, BF
 LOCATE 8, 53: PRINT "HP: "; hpb4; " - "; delce(2)
 LOCATE 9, 53: PRINT "Attack: "; atb4; " - "; delce(3)
 LOCATE 10, 53: PRINT "Defense: "; deb4; " - "; delce(4)
 DO WHILE INKEY$ = "": LOOP
END IF
END SUB

SUB loadchar ()
IF screenx = 1 AND screeny = 77 THEN
 tiles(3, 4) = 7
 tiles(6, 4) = 7
 CALL chaput(120, 160, char2(), 40, 1)
 CALL chaput(240, 160, char2(), 40, 1)
END IF

END SUB

SUB loadg ()
   LOCATE 21, 50
   PRINT "Load Game? y/n"
   DO WHILE smurf$ <> "y" AND smurf$ <> "n"
   smurf$ = INKEY$
   LOOP
   IF smurf$ = "n" THEN EXIT SUB
   OPEN "file.sav" FOR INPUT AS #1
    FOR a = 1 TO 4
     INPUT #1, party(a)
     party(a) = party(a)
    NEXT
    FOR a = 1 TO 10
     INPUT #1, delce(a)
     delce(a) = delce(a)
     INPUT #1, items(a)
     items(a) = items(a)
     INPUT #1, equipm(a)
     equipm(a) = equipm(a)
    NEXT
   FOR a = 1 TO 100
    INPUT #1, people(a)
    people(a) = people(a)
   NEXT
   INPUT #1, magic
   INPUT #1, money
   INPUT #1, screenx
   INPUT #1, screeny
   INPUT #1, manposx
   INPUT #1, manposy
   INPUT #1, facing$
   INPUT #1, poison
   CLOSE #1
   LOCATE 21, 50
   PRINT "Game loaded. Press any key"
   DO WHILE INKEY$ = "": LOOP

END SUB

SUB loadscr (x, y)
filetoopen$ = "screens/" + "x" + FORMAT$(x) + "y" + FORMAT$(y) + ".sce"
OPEN filetoopen$ FOR INPUT AS #1
 FOR churf = 0 TO 15
  FOR lurf = 0 TO 11
   INPUT #1, deder
   tiles(churf, lurf) = deder
  NEXT
 NEXT
CLOSE #1
CALL putalltiles

END SUB

SUB movearound (smurf$, inbat)
IF smurf$ = CHR$(0) + "H" THEN smurf$ = "w"
IF smurf$ = CHR$(0) + "K" THEN smurf$ = "a"
IF smurf$ = CHR$(0) + "M" THEN smurf$ = "d"
IF smurf$ = CHR$(0) + "P" THEN smurf$ = "s"

SELECT CASE smurf$
CASE "a"
facing$ = "l"
IF screenx >= 1 THEN
 IF screenx = 1 AND manposx = 0 THEN GOTO putchar
 IF tiles(manposx, manposy) < 6 THEN CALL putthesetiles(manposx, manposy)
IF manposx < 1 AND screenx > 1 THEN
 manposx = 15
 screenx = screenx - 1
END IF

IF tiles(manposx - 1, manposy) < 6 THEN
 CALL delayer
 CALL chaput((manposx * 40) - 20, (manposy * 40), manml(), 40, 15)
 CALL delayer
 IF tiles(manposx, manposy) < 6 THEN CALL putthesetiles(manposx, manposy)
 manposx = manposx - 1
  IF tiles(manposx, manposy) < 6 THEN CALL putthesetiles(manposx, manposy)
END IF

CALL chaput(manposx * 40, manposy * 40, manl(), tilesize, 15)
END IF

CASE "d"
facing$ = "r"
IF screenx <= 100 THEN
IF manposx = 15 THEN
 manposx = 0
 screenx = screenx + 1
 EXIT SUB
END IF
 IF tiles(manposx, manposy) < 6 THEN CALL putthesetiles(manposx, manposy)
IF tiles(manposx + 1, manposy) < 6 THEN
 CALL delayer
 CALL chaput((manposx * 40) + 20, (manposy * 40), manmr(), 40, 15)
 CALL delayer
 IF tiles(manposx, manposy) < 6 THEN CALL putthesetiles(manposx, manposy)
 manposx = manposx + 1
 IF tiles(manposx, manposy) < 6 THEN CALL putthesetiles(manposx, manposy)
END IF

CALL chaput(manposx * 40, manposy * 40, manr(), tilesize, 15)
END IF

CASE "w"
facing$ = "u"
IF screeny <= 100 THEN
 IF tiles(manposx, manposy) < 6 THEN CALL putthesetiles(manposx, manposy)
IF manposy = 0 THEN
 manposy = 11
 screeny = screeny + 1
END IF

IF tiles(manposx, manposy - 1) < 6 THEN
 CALL delayer
 CALL chaput((manposx * 40), (manposy * 40) - 20, manmu(), 40, 15)
 CALL delayer
 IF tiles(manposx, manposy) < 6 THEN CALL putthesetiles(manposx, manposy)
manposy = manposy - 1
 IF tiles(manposx, manposy) < 6 THEN CALL putthesetiles(manposx, manposy)
END IF
CALL chaput(manposx * 40, manposy * 40, manu(), tilesize, 15)
END IF

CASE "s"
facing$ = "d"
IF screeny >= 1 THEN
 IF screeny = 1 AND manposy = 11 THEN GOTO putchar
 IF tiles(manposx, manposy) < 6 THEN CALL putthesetiles(manposx, manposy)
IF manposy > 10 AND screeny > 1 THEN
 manposy = 0
 screeny = screeny - 1
END IF

IF tiles(manposx, manposy + 1) < 6 THEN
 CALL delayer
 CALL chaput((manposx * 40), (manposy * 40) + 20, manmd(), 40, 15)
 CALL delayer
 IF tiles(manposx, manposy) < 6 THEN CALL putthesetiles(manposx, manposy)
manposy = manposy + 1
 IF tiles(manposx, manposy) < 6 THEN CALL putthesetiles(manposx, manposy)
END IF
CALL chaput(manposx * 40, manposy * 40, mand(), tilesize, 15)
END IF



CASE " "
CALL checkaction

CASE "o"
CALL options

END SELECT
'inbat = 1
IF inbat = 0 THEN
batt = INT(RND * 10) + 1
IF batt = 1 AND (smurf$ = "a" OR smurf$ = "s" OR smurf$ = "d" OR smurf$ = "w") THEN
 IF tiles(manposx, manposy) = 1 THEN
  who = INT(RND * 2) + 1
   inbat = 1
   IF who = 1 THEN CALL battle("starfish")
   IF who = 2 THEN CALL battle("crab")
  END IF
 IF tiles(manposx, manposy) = 3 THEN
  who = INT(RND * 2) + 1
  inbat = 1
  IF who = 1 THEN CALL battle("dinobird")
  IF who = 2 THEN CALL battle("mushroom")
 END IF
END IF
 
END IF

DO UNTIL smurf$ = ""
smurf$ = INKEY$
LOOP
EXIT SUB

putchar:
 IF smurf$ = "a" THEN CALL chaput(manposx * 40, manposy * 40, manl(), tilesize, 15)
 IF smurf$ = "s" THEN CALL chaput(manposx * 40, manposy * 40, mand(), tilesize, 15)

 
END SUB

SUB options ()
substart:
COLOR 15
curopt = 1
 CLS
 FOR a = 1 TO 480
  LINE (1, a)-(640, a), 0
 NEXT
  LINE (10, 10)-(300, 200), 4, B
  CALL chaput(15, 15, mand(), 40, 15)
  LOCATE 2, 10
  PRINT "Delce Arcar"
  LOCATE 3, 10
  PRINT "Hit Points: "; delce(1); "/"; delce(2)
  LOCATE 4, 10
  PRINT "Magic Points: "; delce(9); "/"; magic
  LOCATE 5, 10
  IF poison = 1 THEN : COLOR 2: PRINT "Poisoned!": COLOR 15
'more party members
 IF party(2) = 1 THEN
  CALL chaput(15, 90, dzipepic(), 40, 4)
  LOCATE 7, 10
   PRINT "Dzipe McNew"
  LOCATE 8, 10
   PRINT "Hit Points: "; dzipe(1); "/"; dzipe(2)
  LOCATE 9, 10
   PRINT "Magic Points: "; dzipe(9); "/"; magic
  END IF
  LINE (350, 10)-(635, 300), 4, B
  LOCATE 3, 51
  PRINT ">"
  LOCATE 20, 50
  PRINT "Money: "; money; " GPs"
  LOCATE 3, 53
  PRINT "Load Game"
  LOCATE 4, 53
  PRINT "Save Game"
  LOCATE 5, 53
  PRINT "Use Items"
  LOCATE 6, 53
  PRINT "Equip"
  LOCATE 7, 53
  PRINT "View Map"
  LOCATE 8, 53
  PRINT "Exit Options"
  LOCATE 9, 53
  PRINT "Exit Game"
  LOCATE 10, 53
  PRINT "View Status"
  LOCATE 11, 53
  PRINT "Text Speed: "
  LOCATE 11, 65
   IF tspeed = 1 THEN PRINT "Slow"
   IF tspeed = 3 THEN PRINT "Medium"
   IF tspeed = 5 THEN PRINT "Fast"
  LOCATE 12, 53
  PRINT "Walk Speed: "
  LOCATE 12, 65
   IF wspeed = 1 THEN PRINT "Slow"
   IF wspeed = 3 THEN PRINT "Medium"
   IF wspeed = 5 THEN PRINT "Fast"
  LOCATE 18, 3
   PRINT "Current Location: "; screenx; ","; screeny
optstart:
  smurf$ = INKEY$
IF smurf$ = CHR$(0) + "H" THEN smurf$ = "w"
IF smurf$ = CHR$(0) + "P" THEN smurf$ = "s"

  SELECT CASE smurf$
   CASE "s"
  IF curopt = 10 THEN
  curopt = 0
  LOCATE 12, 51: PRINT " "
  END IF
  IF curopt < 10 THEN
  LOCATE curopt + 2, 51
  PRINT " "
  curopt = curopt + 1
  LOCATE curopt + 2, 51
  PRINT ">"
  END IF
   CASE "w"
  IF curopt = 1 THEN
  curopt = 11
  LOCATE 3, 51: PRINT " "
  END IF
  IF curopt > 1 THEN
  LOCATE curopt + 2, 51
  PRINT " "
   curopt = curopt - 1
  LOCATE curopt + 2, 51
  PRINT ">"
  END IF
   CASE " "
    GOTO selopt
   
   END SELECT

GOTO optstart
  

selopt:
 SELECT CASE curopt
  CASE 1
   'load game
    CALL loadg
    LOCATE 21, 50
    PRINT "               "
    GOTO substart
  CASE 2
  'save game
   CALL saveg
   LOCATE 21, 50
   PRINT "               "
   GOTO substart
 CASE 3
  CALL useitems
  GOTO substart
 CASE 4
  CALL equip
  GOTO substart
 CASE 5
   
 CASE 6
   GOTO laterz
 CASE 7
   LOCATE 21, 50
   PRINT "Exit Game? y/n"
   DO WHILE smurf$ <> "y" AND smurf$ <> "n"
   smurf$ = INKEY$
   LOOP
   IF smurf$ = "n" THEN GOTO laterz
   END
 CASE 8
   CALL status
   GOTO substart
CASE 9
  IF tspeed = 3 THEN tspeed = 5: GOTO haa
  IF tspeed = 1 THEN tspeed = 3: GOTO haa
  IF tspeed = 5 THEN tspeed = 1: GOTO haa
haa:
 LOCATE 11, 65
 IF tspeed = 1 THEN PRINT "Slow  "
 IF tspeed = 3 THEN PRINT "Medium"
 IF tspeed = 5 THEN PRINT "Fast  "
 GOTO substart
CASE 10
  IF wspeed = 3 THEN wspeed = 5: GOTO haa2
  IF wspeed = 1 THEN wspeed = 3: GOTO haa2
  IF wspeed = 5 THEN wspeed = 1: GOTO haa2
haa2:
 LOCATE 12, 65
 IF wspeed = 1 THEN PRINT "Slow  "
 IF wspeed = 3 THEN PRINT "Medium"
 IF wspeed = 5 THEN PRINT "Fast  "
 GOTO substart
 END SELECT
laterz:
  IF curopt <> 6 THEN
   LOCATE 21, 50
   PRINT "               "
   DO WHILE INKEY$ = "": LOOP
   CLS
   GOTO substart
  END IF
  CALL landmark(screenx, screeny)
 
END SUB

SUB putalltiles ()
'tiles
'by number
'-1 - null
'0 - grass
'1 - sand
'2 - cave
'3 - forest/jungle
'4 - floor
'5 - bridge
'6 - shop               'anything above 6 can't be gone through
'7 - character tile
'8 - tree
'9 - water
'10 - shop counter
'11 - wall (shop)
'12 - forest tree
'13 - track
'14 - inn
'15 - reghouse
'16 - cave entrance
'17 - table
'18 - bed
FOR churf = 0 TO 15
FOR lurf = 0 TO 11
 IF tiles(churf, lurf) = -1 THEN PUT (churf * 40, lurf * 40), wallh, PSET
 IF tiles(churf, lurf) = 0 THEN PUT (churf * 40, lurf * 40), grass, PSET
 IF tiles(churf, lurf) = 1 THEN PUT (churf * 40, lurf * 40), sand, PSET
 IF tiles(churf, lurf) = 2 THEN PUT (churf * 40, lurf * 40), cave, PSET
 IF tiles(churf, lurf) = 3 THEN PUT (churf * 40, lurf * 40), forest, PSET
 IF tiles(churf, lurf) = 4 THEN PUT (churf * 40, lurf * 40), floor, PSET
 IF tiles(churf, lurf) = 5 THEN PUT (churf * 40, lurf * 40), bridge, PSET
 IF tiles(churf, lurf) = 6 THEN PUT (churf * 40, lurf * 40), house, PSET
 IF tiles(churf, lurf) = 8 THEN PUT (churf * 40, lurf * 40), tree, PSET
 IF tiles(churf, lurf) = 9 THEN PUT (churf * 40, lurf * 40), water, PSET
 IF tiles(churf, lurf) = 10 THEN PUT (churf * 40, lurf * 40), counter, PSET
 IF tiles(churf, lurf) = 11 THEN PUT (churf * 40, lurf * 40), wallh, PSET
 IF tiles(churf, lurf) = 12 THEN PUT (churf * 40, lurf * 40), fortree, PSET
 IF tiles(churf, lurf) = 13 THEN PUT (churf * 40, lurf * 40), track, PSET
 IF tiles(churf, lurf) = 14 THEN PUT (churf * 40, lurf * 40), inn, PSET
 IF tiles(churf, lurf) = 15 THEN PUT (churf * 40, lurf * 40), reghouse, PSET
 IF tiles(churf, lurf) = 16 THEN PUT (churf * 40, lurf * 40), caveent, PSET
 IF tiles(churf, lurf) = 17 THEN PUT (churf * 40, lurf * 40), table, PSET
 IF tiles(churf, lurf) = 18 THEN PUT (churf * 40, lurf * 40), bed, PSET
 
NEXT
NEXT

END SUB

SUB putthesetiles (x, y)
 IF tiles(x, y) = -1 THEN PUT (x * 40, y * 40), wallh, PSET
 IF tiles(x, y) = 0 THEN PUT (x * 40, y * 40), grass, PSET
 IF tiles(x, y) = 1 THEN PUT (x * 40, y * 40), sand, PSET
 IF tiles(x, y) = 2 THEN PUT (x * 40, y * 40), cave, PSET
 IF tiles(x, y) = 3 THEN PUT (x * 40, y * 40), forest, PSET
 IF tiles(x, y) = 4 THEN PUT (x * 40, y * 40), floor, PSET
 IF tiles(x, y) = 5 THEN PUT (x * 40, y * 40), bridge, PSET
END SUB

SUB saveg ()
   pi = 4 * ATN(1)
   LOCATE 21, 50
   PRINT "Save Game? y/n"
   DO WHILE smurf$ <> "y" AND smurf$ <> "n"
   smurf$ = INKEY$
   LOOP
   IF smurf$ = "n" THEN EXIT SUB

  OPEN "file.sav" FOR OUTPUT AS #1
    FOR a = 1 TO 4
     PRINT #1, party(a)
    NEXT

   FOR a = 1 TO 10
    PRINT #1, delce(a)
    PRINT #1, items(a)
    PRINT #1, equipm(a)
   NEXT
   FOR a = 1 TO 100
    PRINT #1, people(a)
   NEXT
   PRINT #1, magic
   PRINT #1, money
   PRINT #1, screenx
   PRINT #1, screeny
   PRINT #1, manposx
   PRINT #1, manposy
   PRINT #1, facing$
   PRINT #1, poison
   CLOSE #1
   LOCATE 21, 50
   PRINT "Game saved. Press any key"
   DO WHILE INKEY$ = "": LOOP

END SUB

SUB shop (num)
'*********************************************
IF num = 1 THEN
nomoney$ = "Sorry kid, you don't have enough money!"
bought$ = "Here ya go!"
absurd$ = "Um... come back when you really want to buy something."
bye$ = "SHOPKEEPER: See ya!"
textcol = 6
CALL slowtalk("SHOPKEEPER: Hey there! We sell items and weapons at this shop!", 2, 2, 6, 1, 1)
     CALL slowtalk("What would you like to buy? Here is the list: ", 2, 2, 6, 1, 0)
     CALL slowtalk("<H>ERB - 35 GPs            <M>AGIC BOOK - 40 GPs", 3, 2, 6, 0, 0)
     CALL slowtalk("Wo<o>l Vest - 150 GPs      <N>othing, thanks anyway", 4, 2, 6, 0, 0)
     CALL slowtalk("So, what's your choice?", 5, 2, 6, 0, 0)
    smurf$ = INKEY$
    DO WHILE smurf$ <> "h" AND smurf$ <> "m" AND smurf$ <> "o" AND smurf$ <> "n"
    smurf$ = INKEY$
    LOOP
     SELECT CASE smurf$
      CASE "h"
       buy$ = "HERB": price = 35
      CASE "m"
       buy$ = "MAGIC BOOK": price = 40
      CASE "o"
       buy$ = "Wool Vest": price = 150
      CASE "n"
       buy$ = "n"
     END SELECT
         GOSUB buy
         CALL putalltiles
         CALL chaput(320, 160, manu(), 40, 15)
         CALL chaput(330, 100, shopk(), 30, 1)
    END IF

'*********************************************
IF num = 2 THEN
nomoney$ = "MAN: Hey! What are you trying to pull!?"
bought$ = "Thanks for shopping with us! Heheh!"
absurd$ = "I'll do business with you when you stop fooling around!"
bye$ = "MAN: Talk to you later, dude!"
textcol = 2
CALL slowtalk("MAN: Let's do business!", 2, 2, 2, 1, 1)
     CALL slowtalk("I sell two essential things at a price you'll find is quite fair!", 2, 2, 2, 1, 0)
     CALL slowtalk("<H>ERB - 50 GPs            <D>etoxify - 35 GPs", 3, 2, 2, 0, 0)
     CALL slowtalk("<N>othing, thanks anyway", 4, 2, 2, 0, 0)
     CALL slowtalk("What do you want?", 5, 2, 2, 0, 0)
    smurf$ = INKEY$
    DO WHILE smurf$ <> "h" AND smurf$ <> "d" AND smurf$ <> "n"
    smurf$ = INKEY$
    LOOP
     SELECT CASE smurf$
      CASE "h"
       buy$ = "HERB": price = 50
      CASE "d"
       buy$ = "Detoxify": price = 35
      CASE "n"
       buy$ = "n"
     END SELECT
         GOSUB buy
         CALL landmark(7, 1)
END IF

'*****
EXIT SUB

buy:
      IF buy$ <> "n" THEN
       dur$ = "How many " + buy$ + "s would you like?"
       CALL slowtalk(dur$, 2, 2, textcol, 1, 0)
       dur$ = "You have " + FORMAT$(money) + " GPs now!"
       CALL slowtalk(dur$, 3, 2, textcol, 0, 0)
       LOCATE 3, 40
       INPUT a
        IF a < 0 OR INT(a) <> a THEN
         CALL slowtalk(absurd$, 4, 2, textcol, 0, 1)
         RETURN
        END IF
        IF money < (a * price) THEN
         CALL slowtalk(nomoney$, 4, 2, textcol, 0, 1)
        ELSE
          money = money - (a * price)
          CALL slowtalk(bought$, 4, 2, textcol, 0, 1)
          IF smurf$ = "h" THEN items(1) = items(1) + a
          IF smurf$ = "m" THEN items(2) = items(2) + a
          IF smurf$ = "o" THEN equipm(6) = equipm(6) + a
          IF smurf$ = "d" THEN items(3) = items(3) + a
        END IF
      END IF
  CALL slowtalk(bye$, 2, 2, textcol, 1, 1)
RETURN
END SUB

SUB slowtalk (say$, r, c, col, newbox, waite)
fur = tspeed
COLOR col
IF newbox = 1 THEN
 LINE (5, 5)-(635, 100), 0, BF
END IF

' FOR a = 5 TO 99 STEP 2
'   FOR B = 5 TO 635
'    IF INT(B / 2) = (B / 2) THEN PSET (B, a), 0
'   NEXT
'  NEXT
'  FOR a = 6 TO 100 STEP 2
'   FOR B = 5 TO 635
'    IF INT(B / 2) <> (B / 2) THEN PSET (B, a), 0
'   NEXT
'  NEXT


y = LEN(say$)
x = 0
FOR I = 1 TO y
 x = x + 1
 IF INKEY$ = " " THEN tspeed = 50
 FOR a = 1 TO (delay / tspeed)
 NEXT

 LOCATE r, c, 1, 31, 31
 PRINT LEFT$(say$, x)
NEXT I
IF waite = 1 THEN
 DO WHILE INKEY$ = ""
 LOOP
END IF
tspeed = fur
END SUB

SUB status ()
 CLS
 COLOR 15
 LINE (5, 5)-(635, 475), 4, B
  CALL chaput(10, 10, mand(), 40, 15)
  LOCATE 2, 7
  PRINT "Name: Delce Arcar"
  LOCATE 3, 7
  PRINT "Attack: "; delce(3); "+"; delce(7)
  LOCATE 4, 7
  PRINT "Defense: "; delce(4); "+"; delce(8)
  LOCATE 5, 7
  PRINT "HP: "; delce(1); "/"; delce(2)
  LOCATE 6, 7
  PRINT "Exp: LV. "; delce(6)
  LOCATE 7, 7
  PRINT "Exp. Points: "; delce(5)
  LOCATE 8, 7
  PRINT "Next Level at: "; delce(6) * delce(6) * 99
  LOCATE 9, 7
  PRINT "Magic Points: "; delce(9); "/"; magic
  DO WHILE INKEY$ = ""
  LOOP

END SUB

SUB useitems ()
begin2:
CLS
COLOR 15

   LINE (350, 10)-(635, 300), 4, B
   LINE (10, 205)-(300, 475), 4, B
   LINE (350, 10)-(635, 300), 4, B
   CALL chaput(15, 215, mand(), 40, 15)
   smurf2$ = INKEY$
   equipopt = 1
   LOCATE 3, 51: PRINT ">"
   GOSUB dispmenu2
   GOSUB dispchar
   LOCATE 13, 53: PRINT "Back to Game"
  ' *********************************************
   DO WHILE smurf2$ <> "q"
    IF equipopt <> 11 THEN
     IF items(equipopt) = 0 THEN
       LOCATE 20, 50
       PRINT "                            "
     END IF
    END IF
    IF equipopt = 1 AND items(1) > 0 THEN
      LOCATE 20, 50
      PRINT "Restores 30 HP              "
    END IF
    IF equipopt = 2 AND items(2) > 0 THEN
      LOCATE 20, 50
      PRINT "Restores 10 MP              "
    END IF
    IF equipopt = 3 AND items(3) > 0 THEN
     LOCATE 20, 50
     PRINT "Cures you of Poison!"
    END IF
    IF equipopt = 10 AND items(10) = 1 THEN
      LOCATE 20, 50
      PRINT "Your ticket out of DemoLand!"
    END IF
   
    smurf2$ = INKEY$
    SELECT CASE smurf2$
  CASE "s"
  IF equipopt < 11 THEN
  LOCATE equipopt + 2, 51
  PRINT " "
  equipopt = equipopt + 1
  LOCATE equipopt + 2, 51
  PRINT ">"
  END IF
   CASE "w"
  IF equipopt > 1 THEN
  LOCATE equipopt + 2, 51
  PRINT " "
   equipopt = equipopt - 1
  LOCATE equipopt + 2, 51
  PRINT ">"
  END IF
   CASE " "
    GOTO derf2
   END SELECT
   LOOP
'*********************************************

derf2:
    IF equipopt < 11 THEN
     IF items(equipopt) > 0 THEN GOTO putonchar2
    END IF
    EXIT SUB
'*********************************************
putonchar2:
   maxper = 16
   IF party(2) = 1 THEN maxper = 20
   IF party(3) = 1 THEN maxper = 24
   IF party(4) = 1 THEN maxper = 28
   peropt = 16
   LOCATE peropt, 3: PRINT ">": smurf2$ = ""
   DO WHILE smurf2$ <> "q"
    smurf2$ = INKEY$
    SELECT CASE smurf2$
  CASE "s"
  IF peropt < maxper THEN
  LOCATE peropt, 3
  PRINT " "
  peropt = peropt + 4
  LOCATE peropt, 3
  PRINT ">"
  END IF
   CASE "w"
  IF peropt > 16 THEN
  LOCATE peropt, 3
  PRINT " "
   peropt = peropt - 4
  LOCATE peropt, 3
  PRINT ">"
  END IF
   CASE " "
    GOTO klerf2
   END SELECT
   LOOP

'*********************************************
klerf2:
 IF peropt = 16 THEN
  IF equipopt = 1 AND items(1) > 0 THEN delce(1) = delce(1) + 30: items(1) = items(1) - 1: IF delce(1) > delce(2) THEN delce(1) = delce(2)
  IF equipopt = 2 AND items(2) > 0 THEN delce(9) = delce(9) + 10: items(2) = items(2) - 1: IF delce(9) > magic THEN delce(9) = magic
  IF equipopt = 3 AND items(3) > 0 THEN poison = 0: items(3) = items(3) - 1
  GOSUB dispmenu2
  GOSUB dispchar
END IF
 DO WHILE INKEY$ = ""
 LOOP
GOTO begin2
'*********************************************

dispmenu2:
   
   IF items(1) > 0 THEN : LOCATE 3, 53: PRINT "Herb "; "("; items(1); ")"
   IF items(2) > 0 THEN : LOCATE 4, 53: PRINT "Magic Book "; "("; items(2); ")"
   IF items(3) > 0 THEN : LOCATE 5, 53: PRINT "Detoxify "; "("; items(3); ")"
   IF items(10) = 1 THEN : LOCATE 12, 53: PRINT "Harrde Ribbon"
 RETURN
'**********************************************
dispchar:
  LINE (10, 10)-(300, 200), 4, B
  CALL chaput(15, 15, mand(), 40, 15)
  LOCATE 2, 10
  PRINT "Delce Arcar"
  LOCATE 3, 10
  PRINT "Hit Points: "; delce(1); "/"; delce(2)
  LOCATE 4, 10
  PRINT "Magic Points: "; delce(9); "/"; magic
RETURN
END SUB

SUB video (num)
IF num = 1 THEN
  CALL slowtalk("GUARD: Yep, that's the Harrde Ribbon! Now you may pass!", 2, 2, 3, 1, 1)
    CALL slowtalk("Delce: How the hell am I gonna pass! There's a freaking tree in the way!!", 3, 2, 15, 0, 1)
    CALL slowtalk("GUARD: Oh, that... hmm.. oh I know! Stand back, kid!", 4, 2, 3, 0, 1)
     CALL delayer
     CALL chaput((manposx * 40), (manposy * 40) + 20, manmu(), 40, 15)
     CALL delayer
     IF tiles(manposx, manposy) < 6 THEN CALL putthesetiles(manposx, manposy)
      manposy = manposy + 1
     IF tiles(manposx, manposy) < 6 THEN CALL putthesetiles(manposx, manposy)
     CALL chaput(manposx * 40, manposy * 40, manu(), tilesize, 15)
     CALL delayer
     people(3) = 1
     FOR x = 1 TO 40
      FOR y = 1 TO 40
        FOR a = 1 TO (delay / 20)
        NEXT
       PSET (x + 479, y + 319), 15
      NEXT
     NEXT
    CALL slowtalk("Those environmentalists are really gonna let me have it now..", 5, 2, 3, 0, 1)
    CALL slowtalk("Delce: Ah... I'm not even gonna ask..", 6, 2, 15, 0, 1)
END IF
END SUB


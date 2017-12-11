@echo off
color 0a
title Wizard People!

:startMenu
cls
echo Wizard People!
echo ---------------
echo 1) Start Game
echo 2) Load Game
echo 3) Help
echo 4) Exit
echo ---------------
set /p input=Number: 

if %input% == 1 goto startGame
if %input% == 2 goto loadGame
if %input% == 3 goto help
if %input% == 4 exit

:help
cls
title Help
echo This is a rpg game. You have to
echo defeat enimes to win.
pause
goto startMenu

:loadGame
if NOT exist save.sav goto loaderror
< save.sav (
set /p na=
set /p hp=
set /p xp=
set /p xpmax=
set /p money=
set /p lvl=
set /p wep=
set /p wepdis=
set /p arm=
set /p armdis=
set /p hpots=
set /p hpmax=
set /p plydmg=
set /p mondmg=
set /p monhp=
set /p monpois=
set /p resistance=
)
cls
echo Game Loaded
pause
goto fight

:loaderror
cls
echo There is no save file!
pause
goto startMenu

:startGame
cls
title Wizard People!
echo Tell me, what is your name?
echo.
set /p na=Name: 
cls
echo Ok, %na%.
pause
cls
set hp=100
set xp=0
set xpmax=100
set money=100
set lvl=1
set wep=0
set wepdis=Fists
set arm=0
set armdis=None
set hpots=2
set hpmax=100
set plydmg=7
set mondmg=3
set monhp=50
set monpois=2
set resistance=0
goto fight

:fight
cls


if %hp% GTR %hpmax% set hp= %hpmax%


if %money% LSS 0 set money= 0


if %xp% GEQ %xpmax% set /a xp= %xp% - %xpmax%
if %xp% GEQ %xpmax% set /a lvl= %lvl% + 1
if %xp% GEQ %xpmax% set /a xpmax= %xpmax% + 2

echo Wizard People!
echo --------------------------
echo %na% Money: %money%
echo Xp: %xp%/%xpmax% Lvl: %lvl%
echo Weapon: %wepdis% 
echo Armor: %armdis%
echo Monster Damage: %mondmg%
echo Damage: %plydmg%
echo Health Potions: %hpots%
echo Hp: %hp%/%hpmax%
echo Monster Hp: %monhp%
echo Monster Poison: %monpois%
echo --------------------------
echo 1) Fight
echo 2) Shop
echo 3) Save
echo 4) Exit
echo --------------------------
set /p input=Number: 

if %input% == 1 goto playerAttack
if %input% == 2 goto shop
if %input% == 3 goto save
if %input% == 4 exit
goto fight

:playerAttack
if %hp% GTR %hpmax% set hp= %hpmax%
if %monhp% LEQ 0 goto wingame
if %hp% LEQ 0 goto loose

title Sorry for the pause!
cls
echo Stats
echo ----------------------
echo Money: %money%
echo Damage: %plydmg%
echo Monster Damage: %mondmg%
echo Health Potions: %hpots%
echo Monster Poison: %monpois%
echo Health: %hp%/%hpmax%
echo Monster Health: %monhp%
echo ----------------------
echo 1) Use %wepdis%
echo 2) Use Monster Poison
echo 3) Use Health Potions
echo 4) Flee ($50)
echo ----------------------
set /p input=Number: 

if %input% == 1 goto playerAttakFaze
if %input% == 2 goto useMonPois
if %input% == 3 goto useHpots
if %input% == 4 goto flee
goto playerAttack

:flee
if %money% LSS 50 goto noFundsAttack
set /a money= %money% - 50
goto fight

:noFundsAttack
cls
echo You do not have enough money to flee!
pause
goto playerAttack

:useHpots
if %hpots% LEQ 0 goto notEnoughHpots
set /a hpots= %hpots% - 1
if %hp% GEQ %hpmax% goto hpTooHighAttack
set /a hp= %hp% + 15
cls
echo You used a health potion!
goto playerAttack

:hpTooHighAttack
cls
echo Your hp is too high!
pause
goto playerAttack

:notEnoughHpots
cls
echo You do not have enough health potions!
pause 
goto playerAttack

:useMonPois
if %monpois% LEQ 0 goto notEnoughMonPois
set /a monpois= %monpois% - 1
set /a monhp= %monhp% - 7
cls
echo You used a monster poison!
pause
goto playerAttack

:notEnoughMonPois
cls
echo You do not have enough monster poison!
pause
goto playerAttack

:playerAttakFaze
set /a monhp= %monhp% - %plydmg%
echo You attacked the monster!
pause
goto monAttak

:monAttak
set /a hp= %hp% - %mondmg%
echo The monster attacked you!
pause 
goto playerAttack

:wingame
set moyoge= %random%
if %moyoge% GTR 50 goto wingame
if %moyoge% LSS 20 goto wingame
goto fz2ofwin

:fz2ofwin
set xpyoge= %random%
if %xpyoge% GTR 50 goto fz2ofwin
if %xpyoge% LSS 20 goto fz2ofwin
cls
echo You found $%moyoge%, and %xpyoge% Xp!
pause

::Money
set /a money= %money% + %moyoge%
::Xp
set xp= %xp% + %xpyoge%
if %xp% GEQ %xpmax% set /a xp= %xp% - %xpmax%
if %xp% GEQ %xpmax% set /a lvl= %lvl% + 1
set /a xpmax= %xpmax% + 2
::Monster
set /a mondmg= %mondmg% + 2
set /a monhp= %monhp% + 2
::goto
goto fight

:save
(
echo %na%
echo %hp%
echo %xp%
echo %xpmax%
echo %money%
echo %lvl%
echo %wepdis%
echo %arm%
echo %armdis%
echo %hpots%
echo %hpmax%
echo %plydmg%
echo %mondmg%
echo %monhp%
echo %monpois%
echo %resistance%
) > save.sav
cls
echo Game Saved!
pause
goto fight

:shop
cls
title Shop
echo What would you like to buy?
echo.
echo 1) Weapons
echo 2) Potions
echo 3) Food
echo 4) Armor
echo 5) Back
echo.
set /p input=Number: 

if %input% == 1 goto buyWeapons
if %input% == 2 goto buyPotions
if %input% == 3 goto buyFood
if %input% == 4 goto buyArmor
if %input% == 5 goto fight
goto shop

:buyArmor
cls
echo ----------------------------------
echo Money: %money% Lvl: %lvl%
echo ----------------------------------
echo    Armor      Cost     Resistance
echo 1) Leather    $50      +2
echo 2) Cain       $150     +3
echo 3) Gold       $300     +5
echo 4) Diamond    $500     +7
echo 5) Atomic     $1500    +10
echo 6) Space      $3000    +20
echo 7) Back
echo ----------------------------------
set /p input=Number: 

if %input% == 1 goto purchaseleatherarmor
if %input% == 2 goto purchasechainarmor
if %input% == 3 goto purchasegoldarmor
if %input% == 4 goto purchasediamondarmor
if %input% == 5 goto purchaseatomicarmor
if %input% == 6 goto purchasespacearmor
if %input% == 7 goto shop

:buyPotions
cls
echo What potion?
echo -----------------------------------------------------
echo %na% Lvl: %lvl% Money: %money%
echo -----------------------------------------------------
echo 1) Health   $5    +1 (In battle) (Adds 15 health)
echo 2) Lvl      $500  +2
echo 3) Lvl      $1000 +5
echo 4) Poison   $25   +1    -7 Monster Health (In battle)
echo 5) Back
echo -----------------------------------------------------
set /p input=Number: 

if %input% == 1 goto buyHpots
if %input% == 2 goto buyLvl
if %input% == 3 goto buyLvl2
if %input% == 4 goto buyMonsterPoison
if %input% == 5 goto shop

:buyMonsterPoison
cls
if %money% LSS 25 goto nofunds
set /a money= %money% - 25
set /a monpois= %monpois% + 1
echo Purchase Succsefull!
pause
goto buyPotions

:buyLvl2
cls
if %money% LSS 1000 goto nofunds
set /a money= %money% - 1000
set /a lvl= %lvl% + 5
set /a xpmax= %xpmax% + 1
echo Purchase Succsefull!
pause
goto buyPotions

:buyLvl
cls
if %money% LSS 500 goto nofunds
set /a money= %money% - 500
set /a lvl= %lvl% + 2
set /a xpmax= %xpmax% + 1
echo Purchase Succsefull!
pause
goto buyPotions

:buyHpots
cls
if %money% LSS 5 goto nofunds
set /a money= %money% - 5
set /a hpots= %hpots% + 1
echo Purchase Succsefull!
pause
goto buyPotions

:buyFood
cls
echo What Food?
echo.
echo %na% Money: %money% Hp: %hp%
echo.
echo 1) Patato   $2   +2
echo 2) Salad    $5   +4
echo 3) Pasta    $7   +5
echo 4) Steak    $15  +10
echo 5) Back
echo.
set /p input=Number: 

if %input% == 1 goto purchasePatato
if %input% == 2 goto purchaseSalad
if %input% == 3 goto purchasePasta
if %input% == 4 goto purchaseSteak
if %input% == 5 goto shop
goto buyFood

:purchasePatato
cls
if %money% LSS 2 goto nofunds
if %hp% GEQ %hpmax% goto hpToHigh
set /a money= %money% - 2
set /a hp= %hp% + 2
echo Purchase Succsefull!
pause
goto buyFood

:purchaseSalad
cls
if %money% LSS 5 goto nofunds
if %hp% GEQ %hpmax% goto hpToHigh
set /a money= %money% - 5
set /a hp= %hp% + 4
echo Purchase Succsefull!
pause
goto buyFood

:purchasePasta
cls
if %money% LSS 7 goto nofunds
if %hp% GEQ %hpmax% goto hpToHigh
set /a money= %money% - 7
set /a hp= %hp% + 5
echo Purchase Succsefull!
pause
goto buyFood

:purchaseSteak
cls
if %money% LSS 15 goto nofunds
if %hp% GEQ %hpmax% goto hpToHigh
set /a money= %money% - 15
set /a hp= %hp% + 10
echo Purchase Succsefull!
pause
goto buyFood

:hpToHigh
cls
echo You can not buy this item
echo because your hp is too high.
pause
goto shop

:nofunds
cls
echo You do not have enough money to buy 
echo this item.
pause
goto shop

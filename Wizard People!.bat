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
goto fight

:fight
cls
echo Wizard People!
echo --------------------------
echo %na% Money: %money%
echo Xp: %xp%/%xpmax% Lvl: %lvl%
echo Weapon: %wepdis% Armor: %armdis%
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

:save
(
echo %na%
echo %hp%
echo %xp%
echo %xpmax%
echo %money%
echo %lvl%
echo %wep%
echo %wepdis%
echo %arm%
echo %armdis%
echo %hpots%
echo %hpmax%
echo %plydmg%
echo %mondmg%
echo %monhp%
echo %monpois%
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
echo 4) Back
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
echo 1) Leather    $50
echo 2) Chain      $150
echo 3) Gold       $300
echo 4) Diamond    $500
echo 5) Atomic     $1500
echo 6) Space      $3000
echo 7) Back
echo ----------------------------------
set /p input=Number

if %input% == 1 goto purchase.leather.armor
if %input% == 2 goto purchase.chain.armor
if %input% == 3 goto purchase.gold.armor
if %input% == 4 goto purchase.diamond.armor
if %input% == 5 goto purchase.atomic.armor
if %input% == 6 goto purchase.space.armor
if %input% == 12365478963214785862793147896321478963214789632159632587410 goto purchase.easteregg.armor
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
if %money% LSS 25 goto nofunds
set /a money= %money% - 25
set /a monpois= %monpois% + 1
echo Purchase Succsefull!
pause
goto buyPotions

:buyLvl2
if %money% LSS 1000 goto nofunds
set /a money= %money% - 1000
set /a lvl= %lvl% + 5
set /a xpmax= %xpmax% + 1
echo Purchase Succsefull!
pause
goto buyPotions

:buyLvl
if %money% LSS 500 goto nofunds
set /a money= %money% - 500
set /a lvl= %lvl% + 2
set /a xpmax= %xpmax% + 1
echo Purchase Succsefull!
pause
goto buyPotions

:buyHpots
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
if %money% LSS 2 goto nofunds
if %hp% GEQ %hpmax% goto hpToHigh
set /a money= %money% - 2
set /a hp= %hp% + 2
echo Purchase Succsefull!
pause
goto buyFood

:purchaseSalad
if %money% LSS 5 goto nofunds
if %hp% GEQ %hpmax% goto hpToHigh
set /a money= %money% - 5
set /a hp= %hp% + 4
echo Purchase Succsefull!
pause
goto buyFood

:purchasePasta
if %money% LSS 7 goto nofunds
if %hp% GEQ %hpmax% goto hpToHigh
set /a money= %money% - 7
set /a hp= %hp% + 5
echo Purchase Succsefull!
pause
goto buyFood

:purchaseSteak
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
goto buyFood

:nofunds
cls
echo You do not have enough money to buy 
echo this item.
pause
goto buyFood

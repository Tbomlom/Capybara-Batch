@echo off
title Capybara Batch! by Tbomlom
setlocal EnableDelayedExpansion
chcp 65001 >nul


:: Initialwerte
set /a skelettwins=0
set /a HP=100
set /a MaxHP=100
set /a Gold=0
set "Skill1=None"
set /a EventCount=1
set /a Damage=10

set /a demonhp=50
set /a maxdemonhp=50
set /a demondamage=10

set /a skeletthp=100
set /a maxskeletthp=100
set /a skelettdamage=10

set "currentevent=null"

:GameLoop
cls
if %HP% GTR %MaxHP% (
    set /a HP=%MaxHP%
)
if %HP% LEQ 0 (
    goto death
)
echo  ██████╗ █████╗ ██████╗ ██╗   ██╗██████╗  █████╗ ██████╗  █████╗ ██████╗  █████╗ ████████╗ ██████╗██╗  ██╗
echo ██╔════╝██╔══██╗██╔══██╗╚██╗ ██╔╝██╔══██╗██╔══██╗██╔══██╗██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝██╔════╝██║  ██║
echo ██║     ███████║██████╔╝ ╚████╔╝ ██████╔╝███████║██████╔╝███████║██████╔╝███████║   ██║   ██║     ███████║
echo ██║     ██╔══██║██╔═══╝   ╚██╔╝  ██╔══██╗██╔══██║██╔══██╗██╔══██║██╔══██╗██╔══██║   ██║   ██║     ██╔══██║
echo ╚██████╗██║  ██║██║        ██║   ██████╔╝██║  ██║██║  ██║██║  ██║██████╔╝██║  ██║   ██║   ╚██████╗██║  ██║
echo  ╚═════╝╚═╝  ╚═╝╚═╝        ╚═╝   ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝   ╚═╝    ╚═════╝╚═╝  ╚═╝
echo.
echo.
echo.
echo.
echo HP: %HP% / %MaxHP%
echo Gold: %Gold%
echo Skill: %Skill1%
echo Attack Damage: %Damage%
echo.
if %currentevent%==demonfightwindeal goto demonfightwindeal
if %currentevent%==DemonDealFightdemon goto DemonDealFightdemon
if %currentevent%==demondealfightplayer goto DemonDealFightplayer
if %currentevent%==skelettfightplayer goto skelettfightplayer
if %currentevent%==skelettfightskelett goto skelettfightskelett
if %currentevent%==skelettfightwin goto skelettfightwin
set /a check=%EventCount% %% 10
if %check%==0 (
    set /a demondamage+=20
    set /a maxdemonhp+=20
    set /a demonhp=%maxdemonhp%
    set /a maxskeletthp+=20
    set /a skelettdamage+=20
    set /a skeletthp=%maxskeletthp%
)

echo [S] Spiel speichern
echo [L] Spiel laden
echo [Enter] zum nächsten Event
set /p action=Aktion?:

if /I "%action%"=="S" call :savegame
if /I "%action%"=="L" call :loadgame

echo Event #%EventCount%
set /a EventCount+=1
:: Zufalls-Event (1 bis 5)
set /a randEvent=%random% %%10+1

echo Event: 
powershell -Command "Start-Sleep -Seconds 2"


if %randEvent%==1 goto Angel
if %randEvent%==2 goto Demon
if %randEvent%==3 goto Skeleton
if %randEvent%==4 goto Chest
if %randEvent%==5 goto Ants
if %randEvent%==6 goto Skeleton
if %randEvent%==7 goto Chest
if %randEvent%==8 goto Chest
if %randEvent%==9 goto Ants
if %randEvent%==10 goto Angel

:Demon
set /a demonhp=%maxdemonhp%
call :demonbanner
echo Du Entdeckst einen Demon.
pause >nul
echo Er schlägt dir einen Deal vor
pause >nul
echo Er will kämpfen und wenn du gewinnst bekommst du seine Seele aber wenn er gewinnt bekommt er deine.
set /p input=Nimmst du den Deal an?(Y/N):
if /I "%input%" EQU "Y" goto DemonDealFightstart
if /I "%input%" EQU "N" goto GameLoop

:DemonDealFightstart
set "currentevent=demondealfightplayer"
echo Kampf beginnt!
powershell -Command "Start-Sleep -Seconds 2"
echo Du greifst zu erst an.
goto GameLoop

:DemonDealFightplayer
call :demonbanner
echo du greifst jetzt an
echo.
echo.
echo.
echo.
echo Demon HP %demonhp%/%maxdemonhp%
echo.
echo.
pause >nul
set /a demonhp=demonhp - Damage
if %demonhp% LEQ 0 (
    set "currentevent=demonfightwindeal"
    goto GameLoop
) 
set "currentevent=DemonDealFightdemon"
goto GameLoop

:DemonDealFightdemon
call :demonbanner
echo der Demon greift jetzt an!
echo.
echo.
echo.
echo.
echo Demon HP %demonhp%/%maxdemonhp%
echo.
echo.
pause >nul
set /a HP=HP - demondamage
if %HP% LEQ 0 (
    goto death
) 
set "currentevent=demondealfightplayer"
goto GameLoop

:Skeleton
echo ███████╗██╗  ██╗███████╗██╗     ███████╗████████╗ ██████╗ ███╗   ██╗
echo ██╔════╝██║ ██╔╝██╔════╝██║     ██╔════╝╚══██╔══╝██╔═══██╗████╗  ██║
echo ███████╗█████╔╝ █████╗  ██║     █████╗     ██║   ██║   ██║██╔██╗ ██║
echo ╚════██║██╔═██╗ ██╔══╝  ██║     ██╔══╝     ██║   ██║   ██║██║╚██╗██║
echo ███████║██║  ██╗███████╗███████╗███████╗   ██║   ╚██████╔╝██║ ╚████║
echo ╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝   ╚═╝    ╚═════╝ ╚═╝  ╚═══╝
echo.
echo.
echo ein Skelett läuft dir über den weg und ihr verwickelt euch in einen Kampf
goto Skelettfightstart

:skelettfightwin
if %skeletthp% LEQ 0 (
    set /a skeletthp= 0
)
call :skelettbanner
echo.
echo.
echo.
echo.
echo Skelett HP %skeletthp%/%maxskeletthp%
echo.
echo.
set /a skelettwins+=1
echo du hast gewonnen
pause >nul
if %skelettwins% GTR 1 (
    echo du hebst seine Knochen auf und verbesserst dein Schwert und bekommst dadurch +5 Attack Damage
    set /a Damage+=5
    pause >nul
    set "currentevent=null"
    goto GameLoop
) else (
    echo du hebst seine Knochen auf und machst dir daraus ein Schwert und bekommst dadurch +20 Attack Damage
    set /a Damage+=20
    pause >nul
    set "currentevent=null"
    goto GameLoop
)

:Skelettfightstart
set /a skeletthp=%maxskeletthp%
set "currentevent=skelettfightplayer"
echo Kampf beginnt!
powershell -Command "Start-Sleep -Seconds 2"
echo Du greifst zu erst an.
goto GameLoop

:skelettfightplayer
call :skelettbanner
echo du greifst jetzt an
echo.
echo.
echo.
echo.
echo Skelett HP %skeletthp%/%maxskeletthp%
echo.
echo.
pause >nul
set /a skeletthp=skeletthp - Damage
if %skeletthp% LEQ 0 (
    set "currentevent=skelettfightwin"
    goto GameLoop
) 
set "currentevent=skelettfightskelett"
goto GameLoop


:skelettfightskelett
call :skelettbanner
echo das Skelett greift jetzt an!
echo.
echo.
echo.
echo.
echo Skelett HP %skeletthp%/%maxskeletthp%
echo.
echo.
pause >nul
set /a HP=HP - skelettdamage
if %HP% LEQ 0 (
    goto death
) 
set "currentevent=skelettfightplayer"
goto GameLoop




:Chest
echo  ██████╗██╗  ██╗███████╗███████╗████████╗
echo ██╔════╝██║  ██║██╔════╝██╔════╝╚══██╔══╝
echo ██║     ███████║█████╗  ███████╗   ██║   
echo ██║     ██╔══██║██╔══╝  ╚════██║   ██║   
echo ╚██████╗██║  ██║███████╗███████║   ██║   
echo  ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝   ╚═╝   
echo.
echo.
echo du findest eine Truhe.
pause >nul
echo du öffnest sie
:: Zufalls-Event (1 bis 5)
set /a chestloot=(%random% %% 4) + 1

echo dein Loot: 
powershell -Command "Start-Sleep -Seconds 2"

if %chestloot%==1 goto HealBoost
if %chestloot%==2 goto DamageBoost
if %chestloot%==3 goto Trash
if %chestloot%==4 goto Gold

:Gold
echo du findest Gold
pause >nul
echo du bekommst + 50 Gold
set /a Gold+=50
pause >nul
goto GameLoop


:DamageBoost
echo du findest einen Damage Boost
pause >nul
echo du bekommst + 10 Damage
set /a Damage= Damage + 10
pause >nul
goto GameLoop

:Trash
echo du findest eine Leere Truhe
pause >nul
goto GameLoop

:HealBoost
echo du findest einen Heal Boost
pause >nul
echo du bekommst + 100 Hp
set /a HP=HP+100
if %HP% GTR %MaxHP% (
    set /a HP=%MaxHP%
)
pause >nul
goto GameLoop

:Ants
echo   █████╗ ███╗   ██╗████████╗███████╗
echo  ██╔══██╗████╗  ██║╚══██╔══╝██╔════╝
echo  ███████║██╔██╗ ██║   ██║   ███████╗
echo  ██╔══██║██║╚██╗██║   ██║   ╚════██║
echo  ██║  ██║██║ ╚████║   ██║   ███████║
echo  ╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝
echo.
echo.
echo Armeisen laufen dir über den Weg aber du bemerkst sie nicht.
pause >nul
echo sie klauen dir 5 HP und 5 MaxHP
set /a MaxHP-=5
set /a HP-=5
pause >nul
goto GameLoop

:Angel
echo  █████╗ ███╗   ██╗ ██████╗ ███████╗██╗     
echo ██╔══██╗████╗  ██║██╔════╝ ██╔════╝██║     
echo ███████║██╔██╗ ██║██║  ███╗█████╗  ██║     
echo ██╔══██║██║╚██╗██║██║   ██║██╔══╝  ██║     
echo ██║  ██║██║ ╚████║╚██████╔╝███████╗███████╗
echo ╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝╚══════╝
echo.
echo.
echo dir erscheint ein Engel
pause >nul
echo der Engel fragt dich ob du das Angebot 50 Gold gegen + 100 HP und + 50 Max HP annehmen würdest.
set /p input=Nimmst du den Deal an?(Y/N):
if /I "%input%" EQU "Y" goto angebotengelja
if /I "%input%" EQU "N" goto GameLoop
goto GameLoop

:angebotengelja
echo du nimmst an
if %Gold% GEQ 50 (
    set /a Gold-=50
    set /a HP+=100
    set /a MaxHP+=50
    pause >nul
    goto GameLoop
)
echo du hast nicht genug Gold
pause >nul
goto GameLoop
exit /b


:demonfightwindeal
if %demonhp% LEQ 0 (
    set /a demonhp= 0
)
call :demonbanner
echo.
echo.
echo.
echo.
echo Demon HP %demonhp%/%maxdemonhp%
echo.
echo.
echo du hast gewonnen
pause >nul
echo du bekommst seine Seele und damit auch + 50Max HP + 5 Damage und + 50 HP
set /a Damage=Damage + 5
set /a MaxHP=MaxHP + 50
set /a HP=HP + 50
pause >nul
set "currentevent=null"
set /a demonhp=%maxdemonhp%
goto GameLoop

:demonbanner
echo ██████╗ ███████╗███╗   ███╗ ██████╗ ███╗   ██╗
echo ██╔══██╗██╔════╝████╗ ████║██╔═══██╗████╗  ██║
echo ██║  ██║█████╗  ██╔████╔██║██║   ██║██╔██╗ ██║
echo ██║  ██║██╔══╝  ██║╚██╔╝██║██║   ██║██║╚██╗██║
echo ██████╔╝███████╗██║ ╚═╝ ██║╚██████╔╝██║ ╚████║
echo ╚═════╝ ╚══════╝╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═══╝
echo.
echo.
exit /b



:skelettbanner
echo ███████╗██╗  ██╗███████╗██╗     ███████╗████████╗ ██████╗ ███╗   ██╗
echo ██╔════╝██║ ██╔╝██╔════╝██║     ██╔════╝╚══██╔══╝██╔═══██╗████╗  ██║
echo ███████╗█████╔╝ █████╗  ██║     █████╗     ██║   ██║   ██║██╔██╗ ██║
echo ╚════██║██╔═██╗ ██╔══╝  ██║     ██╔══╝     ██║   ██║   ██║██║╚██╗██║
echo ███████║██║  ██╗███████╗███████╗███████╗   ██║   ╚██████╔╝██║ ╚████║
echo ╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝   ╚═╝    ╚═════╝ ╚═╝  ╚═══╝
echo.
echo.
exit /b

:death
(
    echo set /a HP=%HP%
    echo set /a MaxHP=%MaxHP%
    echo set /a Gold=%Gold%
    echo set /a Damage=%Damage%
    echo set "Skill1=%Skill1%"
    echo set /a EventCount=%EventCount%
    echo set "currentevent=%currentevent%"
    echo set /a demonhp=%demonhp%
    echo set /a skeletthp=%skeletthp%
    echo set /a skelettwins=%skelettwins%
) > "%saveFile%"
cls
echo.
echo.
echo.
echo.
echo ██████╗ ███████╗ █████╗ ████████╗██╗  ██╗
echo ██╔══██╗██╔════╝██╔══██╗╚══██╔══╝██║  ██║
echo ██║  ██║█████╗  ███████║   ██║   ███████║
echo ██║  ██║██╔══╝  ██╔══██║   ██║   ██╔══██║
echo ██████╔╝███████╗██║  ██║   ██║   ██║  ██║
echo ╚═════╝ ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝
echo.
echo.
echo.
echo du bist gestorben
pause >nul
exit


:loadgame

set "saveDir=%APPDATA%\Capybara Batch"
set "saveFile=%saveDir%\savegame.bat"



if exist "%saveFile%" (
    call "%saveFile%"
    echo Spielstand geladen!
) else (
    echo Kein Spielstand gefunden!
)
pause >nul
goto GameLoop


pause >nul
goto GameLoop


:savegame
set "saveDir=%APPDATA%\Capybara Batch"
set "saveFile=%saveDir%\savegame.bat"

if not exist "%saveDir%" (
    mkdir "%saveDir%"
    attrib +h "%saveDir%"
)



(
    echo set /a HP=%HP%
    echo set /a MaxHP=%MaxHP%
    echo set /a Gold=%Gold%
    echo set /a Damage=%Damage%
    echo set "Skill1=%Skill1%"
    echo set /a EventCount=%EventCount%
    echo set "currentevent=%currentevent%"
    echo set /a demonhp=%demonhp%
    echo set /a skeletthp=%skeletthp%
    echo set /a skelettwins=%skelettwins%
) > "%saveFile%"

goto GameLoop




zpLow           = $02
zpHigh          = $03
zpLow2          = $04
zpHigh2         = $05

SCREENRAM       = $0400
SCNROW0         = $0400
VELOCITY_GAUGE  = $0426
FUEL_GAUGE      = $062D
SCNROW17        = $06A8
SCNROW19        = $06F8
SPRPTR0         = $07F8 ;Sprite pointers


SPRITERAM       = 170
*=$2A80
                incbin "neptunelander.spt", 1, 17, true


CHARRAM         = 12
*=$3000
                incbin "neptunelander.cst", 0, 127


SCN_INTRO
*=$3400
                incbin "scnLanderIntro.bin"


*=$4000
;Game data
gameStatus                      byte 00

fuelMajor                       byte 13
fuelMinor                       byte 08
fuelMicro                       byte 10
fuelUsed                        byte 00

velocityMajor                   byte 06
velocityMinor                   byte 04
velocityMicro                   byte 00

horizontalVelocity              byte 00, 00
verticalVelocity                byte 00, 00

moveLeft                        byte 00
moveRight                       byte 00
moveThrust                      byte 00

shipLanded                      byte 00
shipCollided                    byte 00
shipExplosionFrame              byte 02
shipExplosionDelay              byte 00
shipExplosionActive             byte 00

txtLevelNumber                  text 'level 00'
txtPrepareLand                  text 'prepare to land, commander'
txtSuccess                      text 'landing succeeded.'
txtGameOver                     text 'you crashed. game over'

spriteNumberMask                byte %00000001, %00000010, %00000100, %00001000
                                byte %00010000, %00100000, %01000000, %10000000

gameLevelReferenceLo            byte <gameLevelCurrent
                                byte <gameLevel1
                                byte <gameLevel2
                                byte <gameLevel3

gameLevelReferenceHi            byte >gameLevelCurrent
                                byte >gameLevel1
                                byte >gameLevel2
                                byte >gameLevel3

gameMapReferenceLo              byte 00
                                byte <gameMap1
                                byte <gameMap2
                                byte <gameMap3

gameMapReferenceHi              byte 00
                                byte >gameMap1
                                byte >gameMap2
                                byte >gameMap3


gameLevelCurrent                byte 01 ; current level type from 0-2 (easy - hard)
gravity                         byte 00, 00 ;fraction, integer
thrust                          byte 00, 00 ;fraction, integer
horizontalInertia               byte 00, 00 ;fraction, integer
fuelRate                        byte 00
base1XYBound                    byte 00, 00, 00, 00 ; x lower, x upper, y lower, y upper
base2XYBound                    byte 00, 00, 00, 00
base3XYBound                    byte 00, 00, 00, 00
shipXHi                         byte 00
shipXLo                         byte 00, 00 ;fraction, integer
shipY                           byte 00, 00 ;fraction, integer


;Arrays for game types (structure to match gameLevelCurrent)
gameLevel1                      byte 0
                                byte 1, 0 ;gravity
                                byte 6, 0 ;thrust
                                byte 2, 0 ;horizontal inertia
                                byte 15 ; fuel rate - higher = slower
                                byte 63, 66, 228, 230 ; base 1 bounds
                                byte 140, 145, 132, 134 ; base 2 bounds
                                byte 8, 18, 204, 206 ; base 3 bounds
                                byte 00 ; ship x hi initial
                                byte 00, 60 ; ship x lo initial
                                byte 00, 60 ; ship y initial

gameMap1                        text "{clear}{white}{down*8}##{down}]^{down}{arrow left}{down}${down}{left}&{down}${down}{left}&{down}{left}%{down}{left}'{down}{left*2}!{down}{left*3}[£{down}{left*3}!{down}{left*2}!{down}{left}{arrow left}{down}{arrow left}{down}{arrow left}{down}{arrow left}{(*3}'{up}{left}%"
                                text "{up}{left}&{up}{left}${up}{left}!{up}!{up}[£{up}!{up}'{up}{left}%{up}'{up}{left}%{up}{(*3}'{up}{left}%{up}{left}{arrow left}{up}{left*2}{arrow left}{up}{left}[£{up}!{up}'{up}{left}%{up}){down}{arrow left}##{down}${down}{left}&{down}${down}{left}&"
                                text "{down}{left}%{down}{left}'{down}{left}${down}{left}&{down}${down}{left}&{down}{left}!{down}{left*2}!{down}{left}${down}{left}&{down}{arrow left}{down}]^{(*4}!]^{down}]^{down}{arrow left}"
                                byte 00

gameLevel2                      byte 1
                                byte 2, 0 ;gravity
                                byte 4, 0 ;thrust
                                byte 2, 0 ;horizontal inertia
                                byte 10 ; fuel rate
                                byte 63, 66, 228, 230 ; base 1 bounds
                                byte 140, 145, 132, 134 ; base 2 bounds
                                byte 8, 18, 204, 206 ; base 3 bounds
                                byte 00 ; ship x hi initial
                                byte 00, 60 ; ship x lo initial
                                byte 00, 60 ; ship y initial

gameMap2                        text "{clear}{white}{down*8}##{down}]^{down}{arrow left}{down}${down}{left}&{down}${down}{left}&{down}{left}%{down}{left}'{down}{left*2}!{down}{left*3}[£{down}{left*3}!{down}{left*2}!{down}{left}{arrow left}{down}{arrow left}{down}{arrow left}{down}{arrow left}{(*3}'{up}{left}%"
                                text "{up}{left}&{up}{left}${up}{left}!{up}!{up}[£{up}!{up}'{up}{left}%{up}'{up}{left}%{up}{(*3}'{up}{left}%{up}{left}{arrow left}{up}{left*2}{arrow left}{up}{left}[£{up}!{up}'{up}{left}%{up}){down}{arrow left}##{down}${down}{left}&{down}${down}{left}&"
                                text "{down}{left}%{down}{left}'{down}{left}${down}{left}&{down}${down}{left}&{down}{left}!{down}{left*2}!{down}{left}${down}{left}&{down}{arrow left}{down}]^{(*4}!]^{down}]^{down}{arrow left}"
                                byte 00

gameLevel3                      byte 2
                                byte 2, 0 ;gravity
                                byte 4, 0 ;thrust
                                byte 2, 0 ;horizontal inertia
                                byte 10 ; fuel rate
                                byte 63, 66, 228, 230 ; base 1 bounds
                                byte 140, 145, 132, 134 ; base 2 bounds
                                byte 8, 18, 204, 206 ; base 3 bounds
                                byte 00 ; ship x hi initial
                                byte 00, 60 ; ship x lo initial
                                byte 00, 60 ; ship y initial

gameMap3                        text "{clear}{white}{down*8}##{down}]^{down}{arrow left}{down}${down}{left}&{down}${down}{left}&{down}{left}%{down}{left}'{down}{left*2}!{down}{left*3}[£{down}{left*3}!{down}{left*2}!{down}{left}{arrow left}{down}{arrow left}{down}{arrow left}{down}{arrow left}{(*3}'{up}{left}%"
                                text "{up}{left}&{up}{left}${up}{left}!{up}!{up}[£{up}!{up}'{up}{left}%{up}'{up}{left}%{up}{(*3}'{up}{left}%{up}{left}{arrow left}{up}{left*2}{arrow left}{up}{left}[£{up}!{up}'{up}{left}%{up}){down}{arrow left}##{down}${down}{left}&{down}${down}{left}&"
                                text "{down}{left}%{down}{left}'{down}{left}${down}{left}&{down}${down}{left}&{down}{left}!{down}{left*2}!{down}{left}${down}{left}&{down}{arrow left}{down}]^{(*4}!]^{down}]^{down}{arrow left}"
                                byte 00











COLROW0                         = $D800
COLROW6                         = $D8F0
COLROW11                        = $D9B8
COLROW12                        = $D9E0
COLROW17                        = $DAA8
COLROW19                        = $DAF8
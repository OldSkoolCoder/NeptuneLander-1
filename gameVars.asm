;variables

shipXHi                 byte 00
shipXLo                 byte 00, 00 ;fraction, integer
shipY                   byte 00, 00 ;fraction, integer
shipSprite              byte 00
thrustSprite            byte 00
thrustDirSprite         byte 00

verticalVelocity        byte 00, 00 ;fraction, integer
gravity                 byte 00, 00 ;fraction, integer
thrust                  byte 00, 00 ;fraction, integer
horizontalVelocity      byte 00, 00 ;fraction, integer
horizontalInertia       byte 00, 00 ;fraction, integer
velocityOffset          byte 00

fuelMajor               byte 00
fuelMinor               byte 00
fuelMicro               byte 00

velMajor                byte 00
velMinor                byte 00
velMicro                byte 00

gameStatus              byte 00

collisionBackground     byte 00
shipLanded              byte 00

shipExplosionFrame      byte 00
shipExplosionLoop       byte 00, 00
shipExplosionActive     byte 00

spriteNumberMask        byte %00000001, %00000010, %00000100, %00001000
                        byte %00010000, %00100000, %01000000, %10000000

scLevelOne              text "{clear}{white}{down*8}##{down}]^{down}{arrow left}{down}${down}{left}&{down}${down}{left}&{down}{left}%{down}{left}'{down}{left*2}!{down}{left*3}[£{down}{left*3}!{down}{left*2}!{down}{left}{arrow left}{down}{arrow left}{down}{arrow left}{down}{arrow left}{(*3}'{up}{left}%"
                        text "{up}{left}&{up}{left}${up}{left}!{up}!{up}[£{up}!{up}'{up}{left}%{up}'{up}{left}%{up}{(*3}'{up}{left}%{up}{left}{arrow left}{up}{left*2}{arrow left}{up}{left}[£{up}!{up}'{up}{left}%{up}){down}{arrow left}##{down}${down}{left}&{down}${down}{left}&"
                        text "{down}{left}%{down}{left}'{down}{left}${down}{left}&{down}${down}{left}&{down}{left}!{down}{left*2}!{down}{left}${down}{left}&{down}{arrow left}{down}]^{(*4}!]^{down}]^{down}{arrow left}"
                        byte 00

;debug variables
tmp                     byte 80, 00
dbcollision             byte 00
safezone                byte 00

;constants
spShip                  = 0
spThrustUp              = 13
spThrustRight           = 14
spThrustLeft            = 15
spThrustNone            = 16

gfMenu                  = 0
gfAlive                 = 1
gfLanded                = 2
gfDying                 = 3
gfDead                  = 4

cnFuelRate              = 10
cnVelRate               = 9


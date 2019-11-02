;game subroutines

InitVariables
        lda #60
        sta shipXLo + 1
        sta shipY + 1
        lda #0
        sta collisionBackground
        sta shipXHi
        sta shipXLo
        sta shipY
        sta shipSprite
        sta verticalVelocity
        sta horizontalVelocity
        sta verticalVelocity + 1
        sta horizontalVelocity + 1
        sta gravity + 1
        sta thrust + 1
        sta horizontalInertia + 1
        sta shipExplosionLoop
        sta shipExplosionLoop + 1
        sta velMicro
        sta shipLanded
        lda #1
        sta thrustSprite
        lda #2
        sta gravity
        sta thrustDirSprite
        sta horizontalInertia
        sta shipExplosionFrame
        lda #4
        sta thrust
        sta velMinor
        lda #6
        sta velMajor
        lda #8
        sta fuelMinor
        lda #10
        sta fuelMicro
        lda #13
        sta fuelMajor
        lda #gfAlive
        sta gameStatus
        lda SPRCBG
        rts

InitScreen
        LIBSCREEN_SETCOLOURS_VVVVV black, black, black, black, black
        LIBSCREEN_SET1000_AV SCREENRAM, space
        LIBSCREEN_SETVIC_AV VMCR, #12
        LIBSCREEN_PRINT_A scLevelOne
        rts

InitGauges
        LIBSCREEN_VERTICALCHAR_VVVAA #64, gray3, 13, $0426, $D826
        lda #green
        sta $D916
        LIBSCREEN_VERTICALCHAR_VVVAA #64, lightblue, 13, $0425, $D825
        lda #red
        sta $D9DD
        sta $DA05
        rts

InitSprites
        LIBSPRITE_MULTICOLORENABLE_AV shipSprite, false
        LIBSPRITE_SETFRAME_AV shipSprite, spShip
        LIBSPRITE_SETFRAME_AV thrustSprite, spThrustNone
        LIBSPRITE_SETFRAME_AV thrustDirSprite, spThrustNone
        LIBSPRITE_ENABLE_VV %00000111, true
        LIBSPRITE_SETPOSITION_AAAA shipSprite, shipXHi, shipXLo+1, shipY+1
        LIBSPRITE_SETPOSITION_AAAA thrustSprite, shipXHi, shipXLo+1, shipY+1
        LIBSPRITE_SETPOSITION_AAAA thrustDirSprite, shipXHi, shipXLo+1, shipY+1
        LIBSPRITE_SETCOLOUR_VV 0, gray1
        LIBSPRITE_SETCOLOUR_VV 1, red
        LIBSPRITE_SETCOLOUR_VV 2, red
        LIBSPRITE_SETMULTICOLORS_VV yellow, gray3
        rts

UserInput
        LIBSPRITE_SETFRAME_AV thrustSprite, spThrustNone
        LIBSPRITE_SETFRAME_AV thrustDirSprite, spThrustNone
        lda fuelMajor
        bne @Left
        lda fuelMinor
        bne @Left
        rts
@Left
        LIBJOY_GETJOY_V JoyLeft
        bne @Right
        LIBMATHS_ADD_16BIT_AAA horizontalVelocity, horizontalInertia, horizontalVelocity
        LIBSPRITE_SETFRAME_AV thrustDirSprite, spThrustLeft
        jsr AdjustFuel
@Right
        LIBJOY_GETJOY_V JoyRight
        bne @Fire
        LIBMATHS_SUBTRACT_16BIT_AAA horizontalVelocity, horizontalInertia, horizontalVelocity
        LIBSPRITE_SETFRAME_AV thrustDirSprite, spThrustRight
        jsr AdjustFuel
@Fire
        LIBJOY_GETJOY_V JoyFire
        bne @NoInput
        LIBMATHS_SUBTRACT_16BIT_AAA verticalVelocity, thrust, verticalVelocity
        LIBSPRITE_SETFRAME_AV thrustSprite, spThrustUp
        LIBMATHS_ADD_8BIT_AAA velMicro, thrust, velMicro
        jsr AdjustFuel
        jsr AdjustFuel
        jsr AdjustVelocityGauge
        rts
@NoInput
        rts

AdjustFuel
        dec fuelMicro
        lda fuelMicro
        cmp #$FF
        bne AdjustFuelExit
        lda #cnFuelRate
        sta fuelMicro
        dec fuelMinor
        lda fuelMinor
        cmp #$FF
        bne AdjustFuelExit
        lda #8
        sta fuelMinor
        dec fuelMajor
AdjustFuelExit
        rts

DisplayFuel
        lda #$2D
        sta zpLow
        lda #$06
        sta zpHigh
        ldx fuelMajor
@loop
        LIBMATHS_SUBTRACT_16BIT_AVVA zpLow, 40, 00, zpLow
        dex
        bne @loop
        lda #72
        sec
        sbc fuelMinor
        sta (zpLow,x)       
        rts

AdjustVelocityGauge
        lda velMicro
        cmp #00
        bmi @decrease
        cmp #cnVelRate
        bpl @increase
        rts
@decrease
        clc
        adc #cnVelRate
        sta velMicro
        dec velMinor
        lda velMinor
        cmp #$FF
        bne @exit
        lda #7
        sta velMinor
        dec velMajor
        lda velMajor
        cmp #$FF
        bne @exit
        lda #00
        sta velMajor
@exit
        rts
@increase
        sec
        sbc #cnVelRate
        sta velMicro
        inc velMinor
        lda velMinor
        cmp #8
        bmi @exit
        lda #00
        sta velMinor
        inc velMajor
        lda velMajor
        cmp #12
        bmi @exit
        lda #12
        sta velMajor
        lda #7
        sta velMinor
        rts

DisplayVelocity
        lda #$26
        sta zpLow
        lda #$04
        sta zpHigh
        ldy velMajor
        ldx #0
@loop
        LIBMATHS_ADD_16BIT_AVVA zpLow, 40, 00, zpLow
        dey
        bne @loop
        lda #73
        clc
        adc velMinor
        sta (zpLow,x)
        LIBMATHS_ADD_16BIT_AVVA zpLow, 40, 00, zpLow
        lda #64
        sta (zpLow,x)
        LIBMATHS_SUBTRACT_16BIT_AVVA zpLow, 80, 00, zpLow
        lda #64
        sta (zpLow,x)
        rts

AddGravity
        LIBMATHS_ADD_16BIT_AAA verticalVelocity, gravity, verticalVelocity
        LIBMATHS_SUBTRACT_8BIT_AAA velMicro, gravity, velMicro
        lda verticalVelocity+1
        cmp #2
        bmi @GravityExit
        lda #2
        sta verticalVelocity+1
        lda #$00
        sta verticalVelocity
@GravityExit
        jsr AdjustVelocityGauge
        rts

UpdateSprites
        LIBMATHS_ADD_16BIT_AAA shipY, verticalVelocity, shipY
        LIBMATHS_ADD_16BIT_AAA shipXLo, horizontalVelocity, shipXLo
        lda shipXLo + 1
        cmp #$00
        bne @checklow
        lda #$01
        sta shipXHi
        jmp @spritepos
@checklow
        cmp #$FF
        bne @spritepos
        lda #$00
        sta shipXHi
@spritepos
        LIBSPRITE_SETPOSITION_AAAA shipSprite, shipXHi, shipXLo+1, shipY+1
        LIBSPRITE_SETPOSITION_AAAA thrustSprite, shipXHi, shipXLo+1, shipY+1
        LIBSPRITE_SETPOSITION_AAAA thrustDirSprite, shipXHi, shipXLo+1, shipY+1
        rts

LandingDetection
        lda shipXHi
        cmp #0
        bne @zone3test
        lda shipY + 1
        cmp #228
        bcc @zone2test
        lda shipXLo + 1
        cmp #63
        bcc @zone2test
        cmp #66
        bcs @zone2test
        lda #true
        sta shipLanded
        jmp @exit
@zone2test
        lda shipY + 1
        cmp #132
        bcc @exit
        lda shipXLo + 1
        cmp #140
        bcc @Exit
        cmp #145
        bcs @exit
        lda #true
        sta shipLanded
        jmp @exit
@zone3test
        lda shipY + 1
        cmp #204
        bcc @exit
        lda shipXLo + 1
        cmp #8
        bcc @exit
        cmp #18
        bcs @exit
        lda #true
        sta shipLanded
@exit
        rts

CollisionDetection
        lda shipLanded
        cmp #true
        beq @nocollision
        LIBSPRITE_DATACOLLIDE_A shipSprite
        beq @nocollision
        lda shipXHi
        cmp #0
        beq @notinsafezone
        lda shipXLo + 1
        cmp #40
        bmi @notinsafezone
        lda shipY + 1
        cmp #156
        bpl @notinsafezone
@nocollision
        rts
@notinsafezone
        lda #true
        sta collisionBackground
        rts

ShipExplosion
        lda shipExplosionActive
        beq ExitShipExplosion
        lda shipExplosionLoop + 1
        bne ExpLoopDecrease
        lda #250
        sta shipExplosionLoop
        lda #05
        sta shipExplosionLoop + 1
        LIBSPRITE_SETFRAME_AA shipSprite, shipExplosionFrame
        inc shipExplosionFrame
        lda shipExplosionFrame
        cmp #14
        bne ExpLoopDecrease
        lda #false
        sta shipExplosionActive
ExpLoopDecrease
        dec shipExplosionLoop
        bne ExitShipExplosion
        dec shipExplosionLoop + 1
        lda #250
        sta shipExplosionLoop
ExitShipExplosion
        rts


;*** DEBUG SPACE ***
dbUserInput
        LIBJOY_GETJOY_V JoyLeft
        bne @Right
        LIBMATHS_SUBTRACT_16BIT_AAA shipXLo, tmp, shipXLo
        lda shipXHi
        sbc #$00
        sta shipXHi
@Right
        LIBJOY_GETJOY_V JoyRight
        bne @Up
        LIBMATHS_ADD_16BIT_AAA shipXLo, tmp, shipXLo
        lda shipXHi
        adc #$00
        sta shipXHi
@Up
        LIBJOY_GETJOY_V JoyUp
        bne @Down
        LIBMATHS_SUBTRACT_16BIT_AAA shipY, tmp, shipY
@Down
        LIBJOY_GETJOY_V JoyDown
        bne @NoInput
        LIBMATHS_ADD_16BIT_AAA shipY, tmp, shipY
@NoInput
        lda #19
        jsr krnCHROUT
        ldx shipXLo + 1
        lda #0
        jsr $BDCD

        lda #44
        jsr krnCHROUT

        ldx shipY + 1
        lda #0
        jsr $BDCD

        lda #44
        jsr krnCHROUT

        ldx dbcollision
        lda #0
        jsr $BDCD

        lda #44
        jsr krnCHROUT

        ldx shipLanded
        lda #0
        jsr $BDCD

        lda #32
        jsr krnCHROUT
        lda #32
        jsr krnCHROUT
        lda #32
        jsr krnCHROUT

        rts

dbUpdateSprites
        LIBSPRITE_SETPOSITION_AAAA shipSprite, shipXHi, shipXLo+1, shipY+1
        LIBSPRITE_SETPOSITION_AAAA thrustSprite, shipXHi, shipXLo+1, shipY+1
        LIBSPRITE_SETPOSITION_AAAA thrustDirSprite, shipXHi, shipXLo+1, shipY+1
        rts

dbCollisionDetection
        lda shipLanded
        cmp #true
        beq dbCollisionExit
        LIBSPRITE_DATACOLLIDE_A shipSprite
        beq dbCollisionExit
        lda #true
        sta dbcollision
        rts
dbCollisionExit
        lda #false
        sta dbcollision
        rts
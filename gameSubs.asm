;game subroutines

InitVariables
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
        LIBGENERAL_STORE_VA 1, thrustSprite
        LIBGENERAL_STORE_VA 6, velMajor
        LIBGENERAL_STORE_VA 8, fuelMinor
        LIBGENERAL_STORE_VA 10, fuelMicro
        LIBGENERAL_STORE_VA 13, fuelMajor
        LIBGENERAL_STORE_VA gfAlive, gameStatus
        LIBGENERAL_STORE2_VAA 4, thrust, velMinor
        LIBGENERAL_STORE2_VAA 60, shipXLo + 1, shipY + 1
        LIBGENERAL_STORE4_VAAAA 2, gravity, thrustDirSprite, horizontalInertia, shipExplosionFrame
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
        LIBGENERAL_STORE_VA green, $D916
        LIBSCREEN_VERTICALCHAR_VVVAA #64, lightblue, 13, $0425, $D825
        LIBGENERAL_STORE2_VAA red, $D9DD, $DA05
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
        LIBGENERAL_STORE_VA cnFuelRate, fuelMicro
        dec fuelMinor
        lda fuelMinor
        cmp #$FF
        bne AdjustFuelExit
        LIBGENERAL_STORE_VA 8, fuelMinor
        dec fuelMajor
AdjustFuelExit
        rts

DisplayFuel
        LIBGENERAL_STORE_VA $2D, zpLow
        LIBGENERAL_STORE_VA $06, zpHigh
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
        LIBGENERAL_STORE_VA 7, velMinor
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
        LIBGENERAL_STORE_VA 0, velMinor
        inc velMajor
        lda velMajor
        cmp #12
        bmi @exit
        LIBGENERAL_STORE_VA 12, velMajor
        LIBGENERAL_STORE_VA 7, velMinor
        rts

DisplayVelocity
        LIBGENERAL_STORE_VA $26, zpLow
        LIBGENERAL_STORE_VA $04, zpHigh
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
        LIBGENERAL_STORE_VA 2, verticalVelocity+1
        LIBGENERAL_STORE_VA 0, verticalVelocity
@GravityExit
        jsr AdjustVelocityGauge
        rts

UpdateSprites
        LIBMATHS_ADD_16BIT_AAA shipY, verticalVelocity, shipY
        LIBMATHS_ADD_16BIT_AAA shipXLo, horizontalVelocity, shipXLo
        lda shipXLo + 1
        cmp #$00
        bne @checklow
        LIBGENERAL_STORE_VA 1, shipXHi
        jmp @spritepos
@checklow
        cmp #$FF
        bne @spritepos
        LIBGENERAL_STORE_VA 0, shipXHi
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
        bne zone3test
        LIBSPRITE_CHECKPOS_AVVAVVA shipY+1, 228, 230, shipXLo+1, 63, 66, shipLanded
        LIBSPRITE_CHECKPOS_AVVAVVA shipY+1, 132, 134, shipXLo+1, 140, 145, shipLanded
        rts
zone3test
        LIBSPRITE_CHECKPOS_AVVAVVA shipY+1, 204, 206, shipXLo+1, 8, 18, shipLanded
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
        LIBGENERAL_STORE_VA true, collisionBackground
        rts

ShipExplosion
        lda shipExplosionActive
        beq ExitShipExplosion
        lda shipExplosionLoop + 1
        bne ExpLoopDecrease
        LIBGENERAL_STORE_VA 250, shipExplosionLoop
        LIBGENERAL_STORE_VA 5, shipExplosionLoop + 1
        LIBSPRITE_SETFRAME_AA shipSprite, shipExplosionFrame
        inc shipExplosionFrame
        lda shipExplosionFrame
        cmp #14
        bne ExpLoopDecrease
        LIBGENERAL_STORE_VA false, shipExplosionActive
ExpLoopDecrease
        dec shipExplosionLoop
        bne ExitShipExplosion
        dec shipExplosionLoop + 1
        LIBGENERAL_STORE_VA 250, shipExplosionLoop
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
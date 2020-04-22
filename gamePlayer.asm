gamePlayer_UserInput
        lda fuelMajor
        bne .CheckMoveLeft
        lda fuelMinor
        bne .CheckMoveLeft
        rts
.CheckMoveLeft
        LIBJOY_GETJOY_V JOY_LEFT
        bne .CheckMoveRight
        inc moveLeft
        jsr gameSound_Thrusters
.CheckMoveRight
        LIBJOY_GETJOY_V JOY_RIGHT
        bne .CheckFirePressed
        inc moveRight
        jsr gameSound_Thrusters
.CheckFirePressed
        LIBJOY_GETJOY_V JOY_FIRE
        bne .ExitUserInput
        inc moveThrust
        ;inc fuelUsed
        ;inc fuelUsed
        jsr gameSound_Thrusters
.ExitUserInput
        rts


gamePlayer_Move
        LIBSPRITE_SETFRAME_VV THRUST_SPRITE, FRAME_THRUST_NONE
        LIBSPRITE_SETFRAME_VV THRUST_DIR_SPRITE, FRAME_THRUST_NONE
        lda moveLeft
        beq .MoveRight
        LIBMATHS_ADD_16BIT_AA horizontalVelocity, horizontalInertia
        LIBSPRITE_SETFRAME_VV THRUST_DIR_SPRITE, FRAME_THRUST_LEFT
        inc fuelUsed
        dec moveLeft
.MoveRight
        lda moveRight
        beq .MoveThrust
        LIBMATHS_SUBTRACT_16BIT_AA horizontalVelocity, horizontalInertia
        LIBSPRITE_SETFRAME_VV THRUST_DIR_SPRITE, FRAME_THRUST_RIGHT
        inc fuelUsed
        dec moveRight
.MoveThrust
        lda moveThrust
        beq .AdjustFuel
        LIBMATHS_SUBTRACT_16BIT_AA verticalVelocity, thrust
        LIBSPRITE_SETFRAME_VV THRUST_DIR_SPRITE, FRAME_THRUST_UP
        LIBMATHS_ADD_8BIT_AA velocityMicro, thrust
        inc fuelUsed
        inc fuelUsed
        dec moveThrust
.AdjustFuel
        lda fuelUsed
        beq .ExitMove
        dec fuelMicro
        lda fuelMicro
        cmp #$FF
        bne .AdjustFuelLoop
        lda fuelRate
        sta fuelMicro
        dec fuelMinor
        lda fuelMinor
        cmp #$FF
        bne .AdjustFuelLoop
        lda #8
        sta fuelMinor
        dec fuelMajor
.AdjustFuelLoop
        dec fuelUsed
        jmp .AdjustFuel
.ExitMove
        rts


gamePlayer_AddGravity
        LIBMATHS_ADD_16BIT_AA verticalVelocity, gravity
        LIBMATHS_SUBTRACT_8BIT_AA velocityMicro, gravity
        lda verticalVelocity+1
        cmp #2
        bmi .ExitAddGravity
        lda #2
        sta verticalVelocity+1
        lda #0
        sta verticalVelocity
.ExitAddGravity
        rts


gamePlayer_UpdateSprites
        LIBMATHS_ADD_16BIT_AA shipY, verticalVelocity
        LIBMATHS_ADD_16BIT_AA shipXLo, horizontalVelocity
        lda shipXLo + 1
        cmp #0
        bne .CheckMSBLower
        lda #1
        sta shipXHi
        jmp .CheckYPos
.CheckMSBLower
        cmp #$FF
        bne .CheckYPos
        lda #0
        sta shipXHi
.CheckYPos
        lda shipY+1
        cmp #10
        bcs .PositionSprites
        lda #TRUE
        sta shipLostInSpace
        lda #GF_STATUS_DYING
        sta gameStatus
.PositionSprites
        LIBSPRITE_SETPOSITION_VAAA SHIP_SPRITE, shipXHi, shipXLo+1, shipY+1
        LIBSPRITE_SETPOSITION_VAAA THRUST_SPRITE, shipXHi, shipXLo+1, shipY+1
        LIBSPRITE_SETPOSITION_VAAA THRUST_DIR_SPRITE, shipXHi, shipXLo+1, shipY+1
        rts



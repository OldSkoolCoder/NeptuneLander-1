gameShip_CheckLanded
        lda #0
        sta landingPad
        lda shipXHi
        bne .Zone3Test
        LIBSPRITE_CHECKPOS_AAAAAAA shipY+1, base1XYBound+2, base1XYBound+3, shipXLo+1, base1XYBound, base1XYBound+1, shipLanded
        lda shipLanded
        beq .Zone2Test
        lda #1
        sta landingPad
        jmp .ExitCheckLanded
.Zone2Test
        LIBSPRITE_CHECKPOS_AAAAAAA shipY+1, base2XYBound+2, base2XYBound+3, shipXLo+1, base2XYBound, base2XYBound+1, shipLanded 
        lda shipLanded
        beq .ExitCheckLanded
        lda #2
        sta landingPad
        jmp .ExitCheckLanded
.Zone3Test
        LIBSPRITE_CHECKPOS_AAAAAAA shipY+1, base3XYBound+2, base3XYBound+3, shipXLo+1, base3XYBound, base3XYBound+1, shipLanded
        lda shipLanded
        beq .ExitCheckLanded
        lda #3
        sta landingPad
.ExitCheckLanded
        rts


gameShip_CheckCollision
        lda shipLanded
        cmp #TRUE
        beq .ExitCheckCollision
        LIBSPRITE_DATACOLLIDE_V SHIP_SPRITE
        beq .ExitCheckCollision
        lda shipXHi
        cmp #0
        beq .NotInSafeZone
        lda shipXLo + 1
        cmp #40
        bcc .NotInSafeZone
        lda shipY + 1
        cmp #156
        bcc .ExitCheckCollision
.NotInSafeZone
        lda #TRUE
        sta shipCollided
.ExitCheckCollision
        rts


gameShip_Exploding
        lda shipExplosionActive
        bne .AnimateExplosion
        lda #TRUE
        sta shipExplosionActive
        LIBSPRITE_MULTICOLORENABLE_VV SHIP_SPRITE, TRUE
        LIBSPRITE_ENABLE_VV %00000110, FALSE
.AnimateExplosion
        lda shipExplosionDelay
        bne .ExitExploding
        lda #EXPLOSION_RATE
        sta shipExplosionDelay
        LIBSPRITE_SETFRAME_VA SHIP_SPRITE, shipExplosionFrame
        inc shipExplosionFrame
        lda shipExplosionFrame
        cmp #14
        bne .ExitExploding
        ;LIBSPRITE_ENABLE_VV %00000001, FALSE   
        lda #0
        sta SPREN
        lda #GF_STATUS_DEAD
        sta gameStatus
.ExitExploding
        dec shipExplosionDelay
        rts


gameShip_Landed
        ldx #0
.LandedTextLoop
        lda txtSuccess,x
        sta SCNROW0+11,x
        lda #YELLOW
        sta COLROW0+11,x
        inx
        cpx #18
        bne .LandedTextLoop
        jsr gameScore_FuelRemaining
        LIBGENERAL_DELAY_V 255
        LIBGENERAL_DELAY_V 255
        LIBGENERAL_DELAY_V 255
        LIBGENERAL_DELAY_V 255
        inc gameLevelCurrent
        lda #FALSE
        sta shipLanded
        lda #GF_STATUS_NEXT_LEVEL
        sta gameStatus
        LIBSPRITE_ENABLE_VV %00000111, FALSE
        rts




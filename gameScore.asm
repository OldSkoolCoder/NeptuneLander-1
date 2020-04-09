gameScore_FuelRemaining
        ldx landingPad
        lda baseScoreMultiplier-1,x
        sta fuelBonus
        lda fuelMajor
        bne .CheckRemainingFuel
        lda fuelMinor
        bne .CheckRemainingFuel
        jmp .ExitFuelRemaining
.CheckRemainingFuel
        LIBGENERAL_DELAY_V 30
        jsr gameGauges_DisplayFuelGauge
        LIBMATHS_ADD_DEC_24BIT_AA score, fuelBonus
        jsr gameScore_DisplayScore
        dec fuelMinor
        lda fuelMinor
        cmp #$FF
        bne .CheckRemainingFuel
        lda #8
        sta fuelMinor
        dec fuelMajor
        lda fuelMajor
        cmp #$FF
        bne .CheckRemainingFuel
.ExitFuelRemaining
        rts


gameScore_DisplayScore
        LIBSCREEN_DISPLAY_DECIMAL_AA score, SCNSCORE1
        LIBSCREEN_DISPLAY_DECIMAL_AA score+1, SCNSCORE2
        LIBSCREEN_DISPLAY_DECIMAL_AA score+2, SCNSCORE3
        rts
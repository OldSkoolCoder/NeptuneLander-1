gameGauges_AdjustVelocityGauge
        lda velocityMicro
        cmp #0
        bmi .DecreaseVelocityGauge
        cmp #VELOCITY_RATE
        bpl .IncreaseVelocityGauge
        rts
.DecreaseVelocityGauge
        clc
        adc #VELOCITY_RATE
        sta velocityMicro
        dec velocityMinor
        lda velocityMinor
        cmp #$FF
        bne .ExitAdjustVelocity
        lda #7
        sta velocityMinor
        dec velocityMajor
        lda velocityMajor
        cmp #$FF
        bne .ExitAdjustVelocity
        lda #0
        sta velocityMajor
        rts
.IncreaseVelocityGauge
        sec
        sbc #VELOCITY_RATE
        sta velocityMicro
        inc velocityMinor
        lda velocityMinor
        cmp #8
        bmi .ExitAdjustVelocity
        lda #0
        sta velocityMinor
        inc velocityMajor
        lda velocityMajor
        cmp #12
        bmi .ExitAdjustVelocity
        lda #12
        sta velocityMajor
        lda #7
        sta velocityMinor
.ExitAdjustVelocity
        rts

gameGauges_DisplayFuelGauge
        lda #<FUEL_GAUGE
        sta zpLow
        lda #>FUEL_GAUGE
        sta zpHigh
        ldx fuelMajor
.DisplayFuelGaugeLoop
        LIBMATHS_SUBTRACT_16BIT_AV zpLow, 40
        dex
        bne .DisplayFuelGaugeLoop
        lda #CHAR_FUEL
        sec
        sbc fuelMinor
        sta (zpLow,x)       
        rts


gameGauges_DisplayVelocityGauge
        lda #<VELOCITY_GAUGE
        sta zpLow
        lda #>VELOCITY_GAUGE
        sta zpHigh
        ldy velocityMajor
        ldx #0
.DisplayVelocityGaugeLoop
        LIBMATHS_ADD_16BIT_AV zpLow, 40
        dey
        bne .DisplayVelocityGaugeLoop
        lda #CHAR_VELOCITY
        clc
        adc velocityMinor
        sta (zpLow,x)
        LIBMATHS_ADD_16BIT_AV zpLow, 40
        lda #CHAR_BLOCK
        sta (zpLow,x)
        LIBMATHS_SUBTRACT_16BIT_AV zpLow, 80
        lda #CHAR_BLOCK
        sta (zpLow,x)
        rts



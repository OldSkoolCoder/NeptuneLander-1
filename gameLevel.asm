gameLevel_IntroText
        LIBSCREEN_SET1000_AV SCREENRAM, SPACE
        ldx #0
.IntroScreenLoop
        lda txtPrepareLand,x
        sta SCNROW19+7,x
        lda #YELLOW
        sta COLROW19+7,x
        cpx #8
        bcs .SkipLevelText
        lda txtLevelNumber,x
        sta SCNROW17+16,x
        lda #WHITE
        sta COLROW17+16,x
.SkipLevelText
        inx
        cpx #26
        bne .IntroScreenLoop
        lda gameLevelCurrent
        clc
        adc #$30
        sta SCNROW17+23
        LIBGENERAL_DELAY_V 255
        LIBGENERAL_DELAY_V 255
        LIBGENERAL_DELAY_V 255
        LIBGENERAL_DELAY_V 255
        rts


gameLevel_PrepareLevel
        LIBSCREEN_SET1000_AV SCREENRAM, SPACE
        LIBSCREEN_SET1000_AV COLOURRAM, WHITE
        ldy gameLevelCurrent
        lda gameLevelReferenceLo,y
        sta zpLow
        lda gameLevelReferenceHi,y
        sta zpHigh
        ldy #27
.LevelDataCopyLoop
        lda (zpLow),y
        sta gameLevelCurrent,y
        dey
        bne .LevelDataCopyLoop
        ldy gameLevelCurrent
        lda gameMapReferenceLo,y
        sta zpLow
        lda gameMapReferenceHi,y
        sta zpHigh
        LIBSCREEN_INDIRECT_PRINT_A zpLow
        LIBSCREEN_VERTICALCHAR_VVVAA CHAR_BLOCK, GRAY3, 13, SCNROW0+38, COLROW0+38
        lda #GREEN
        sta COLROW6+38
        LIBSCREEN_VERTICALCHAR_VVVAA CHAR_BLOCK, LIGHTBLUE, 13, SCNROW0+37, COLROW0+37
        lda #RED
        sta COLROW11+37
        sta COLROW12+37
        ldy #7
        lda #YELLOW
.ScoreColourLoop
        sta COLSCORE-1,y
        dey
        bne .ScoreColourLoop
        lda #13
        sta fuelMajor
        lda #8
        sta fuelMinor
        lda #10
        sta fuelMicro
        lda #6
        sta velocityMajor
        lda #4
        sta velocityMinor
        lda #0
        sta fuelUsed
        sta velocityMicro
        sta verticalVelocity
        sta verticalVelocity+1
        sta horizontalVelocity
        sta horizontalVelocity+1
        sta shipExplosionDelay
        lda #2
        sta shipExplosionFrame
        lda #FALSE
        sta shipExplosionActive
        lda SPRCSP
        rts


gameLevel_InitialiseSprites
        LIBSPRITE_MULTICOLORENABLE_VV SHIP_SPRITE, FALSE
        LIBSPRITE_MULTICOLORENABLE_VV THRUST_SPRITE, TRUE
        LIBSPRITE_SETFRAME_VV SHIP_SPRITE, FRAME_SHIP
        LIBSPRITE_SETFRAME_VV THRUST_SPRITE, FRAME_THRUST_NONE
        LIBSPRITE_SETFRAME_VV THRUST_DIR_SPRITE, FRAME_THRUST_NONE
        LIBSPRITE_ENABLE_VV %00000111, TRUE
        LIBSPRITE_SETPOSITION_VAAA SHIP_SPRITE, shipXHi, shipXLo+1, shipY+1
        LIBSPRITE_SETPOSITION_VAAA THRUST_SPRITE, shipXHi, shipXLo+1, shipY+1
        LIBSPRITE_SETPOSITION_VAAA THRUST_DIR_SPRITE, shipXHi, shipXLo+1, shipY+1
        LIBSPRITE_SETCOLOUR_VV SHIP_SPRITE, GRAY2
        LIBSPRITE_SETCOLOUR_VV THRUST_SPRITE, RED
        LIBSPRITE_SETCOLOUR_VV THRUST_DIR_SPRITE, RED
        LIBSPRITE_SETMULTICOLORS_VV YELLOW, GRAY1
        lda SPRCBG
        rts


gameLevel_GameOver
        ldx #0
.GameOverTextLoop
        lda txtGameOver,x
        sta SCNROW0+9,x
        lda #YELLOW
        sta COLROW0+9,x
        inx
        cpx #22
        bne .GameOverTextLoop
        LIBGENERAL_DELAY_V 255
        LIBGENERAL_DELAY_V 255
        LIBGENERAL_DELAY_V 255
        LIBGENERAL_DELAY_V 255
        lda #1
        sta gameLevelCurrent
        lda #FALSE
        sta shipCollided
        lda #GF_STATUS_MENU
        sta gameStatus
        rts

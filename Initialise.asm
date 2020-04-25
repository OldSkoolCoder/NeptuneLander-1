*=$4000
Initialise_Game
        LIBSCREEN_SET1000_AV SCREENRAM, SPACE
        LIBSCREEN_SETCOLOURS_VV BLACK, BLACK
        LIBSCREEN_SETVIC_AV VMCR, CHARRAM
        lda #60
        sta rasterPosition
        lda #0
        sta initScroll
        lda #$80
        jsr gameUtils_CopyMusic
        jsr SID_INIT
        rts

Initialise_Menu
        lda #240
        sta rasterPosition
        lda #0
        sta initScroll
        LIBSCREEN_COPYSCREEN_A SCN_INTRO
        ldx #8
        lda #BLACK
.HideThrustersLoop
        cpx #5
        bcs .SkipFirstRow
        sta $DA91,x
.SkipFirstRow
        sta $DAB7,x
        sta $DADF,x
        sta $DB07,x
        sta $DB2F,x
        dex
        bne .HideThrustersLoop

.IntroWaitFireLoop
        LIBJOY_GETJOY_V JOY_FIRE
        bne .IntroWaitFireLoop
        lda #$70
        jsr gameUtils_CopyMusic
        jsr SID_INIT
        lda #1
        sta gameLevelCurrent
        lda #0
        sta score
        sta score+1
        sta score+2

        rts

Initialise_ScrollMenu
        lda initScroll
        bne .VerticalScrollLoop
        lda #60
        sta rasterPosition
        lda #1
        sta initScroll
        lda #$80
        jsr gameUtils_CopyMusic
        jsr SID_INIT
        LIBSCREEN_SET1000_AV SCREENRAM, SPACE
        lda #0 
        sta screenScrollYValue
        lda VCR1
        and #%11110000
        sta VCR1
        lda #20
        sta currentScreenRow
        jsr Initialise_CopyTitleScreenRow
.VerticalScrollLoop
        inc screenScrollYValue
        lda screenScrollYValue
        and #7
        sta screenScrollYValue

        lda VCR1
        and #%11111000
        ora screenScrollYValue
        sta VCR1

        lda screenScrollYValue
        bne .ExitScrollMenu

        dec currentScreenRow
        jsr Initialise_CopyScreenDown
        lda currentScreenRow
        bne .ExitScrollMenu

        lda VCR1
        and #%11111000
        ora #%00001011
        sta VCR1
        lda #GF_STATUS_MENU
        sta gameStatus
.ExitScrollMenu
        inc rasterPosition
        rts



Initialise_CopyScreenDown
        ldy #8
.CopyScreenDownLoop
        LIBSCREEN_COPYSCREENROW_A $06F8
        LIBSCREEN_COPYSCREENROW_A $06D0
        LIBSCREEN_COPYSCREENROW_A $06A8
        LIBSCREEN_COPYSCREENROW_A $0680
        LIBSCREEN_COPYSCREENROW_A $0658
        LIBSCREEN_COPYSCREENROW_A $0630
        LIBSCREEN_COPYSCREENROW_A $0608
        LIBSCREEN_COPYSCREENROW_A $05E0
        LIBSCREEN_COPYSCREENROW_A $05B8
        LIBSCREEN_COPYSCREENROW_A $0590
        LIBSCREEN_COPYSCREENROW_A $0568
        LIBSCREEN_COPYSCREENROW_A $0540
        LIBSCREEN_COPYSCREENROW_A $0518
        LIBSCREEN_COPYSCREENROW_A $04F0
        LIBSCREEN_COPYSCREENROW_A $04C8
        LIBSCREEN_COPYSCREENROW_A $04A0
        LIBSCREEN_COPYSCREENROW_A $0478
        LIBSCREEN_COPYSCREENROW_A $0450
        LIBSCREEN_COPYSCREENROW_A $0428
        LIBSCREEN_COPYSCREENROW_A $0400
        iny
        cpy #32
        beq Initialise_CopyTitleScreenRow
        jmp .CopyScreenDownLoop
Initialise_CopyTitleScreenRow        
        ldx currentScreenRow
        lda tbl_TitleScreenLo,x
        sta zpLow
        lda tbl_TitleScreenHi,x
        sta zpHigh
        lda tbl_TitleScreenColourLo,x
        sta zpLow2
        lda tbl_TitleScreenColourHi,x
        sta zpHigh2

        ldy #8
.CopyScreenRowLoop
        lda (zpLow),y
        sta SCREENRAM,y
        lda (zpLow2),y
        sta COLOURRAM,y
        iny
        cpy #32
        bne .CopyScreenRowLoop
        rts

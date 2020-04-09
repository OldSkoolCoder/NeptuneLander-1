*=$4000
Initialise_Game
        LIBSCREEN_SETVIC_AV VMCR, CHARRAM
        lda #$80
        jsr gameUtils_CopyMusic
        jsr SID_INIT
        rts

Initialise_Menu
        LIBSCREEN_SETCOLOURS_VV BLACK, BLACK
        LIBSCREEN_COPYSCREEN_A SCN_INTRO
        lda #$80
        jsr gameUtils_CopyMusic
        jsr SID_INIT
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

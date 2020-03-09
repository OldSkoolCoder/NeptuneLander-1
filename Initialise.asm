Initialise_Game
        LIBSCREEN_SETVIC_AV VMCR, CHARRAM
        rts

Initialise_Menu
        LIBSCREEN_SETCOLOURS_VV BLACK, BLACK
        LIBSCREEN_COPYSCREEN_A SCN_INTRO
.IntroWaitFireLoop
        LIBJOY_GETJOY_V JOY_FIRE
        bne .IntroWaitFireLoop
        rts

*=$0801

        byte    $0E, $08, $0A, $00, $9E, $20, $28  
        byte    $32, $30, $36, $34, $29, $00, $00, $00

Start
        jsr Initialise_Game
        jsr IRQ_Initialise

GameLoop
        ;LIBSCREEN_WAIT_V 240
        LIBSCREEN_WAIT_A rasterPosition
        jsr GameFlow_Update
        jmp GameLoop
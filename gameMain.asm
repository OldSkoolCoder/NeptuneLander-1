*=$0801

        byte    $0E, $08, $0A, $00, $9E, $20, $28  
        byte    $32, $30, $36, $34, $29, $00, $00, $00

Initialise
        jsr InitVariables
        jsr InitGame
        jsr InitGauges
        jsr InitSprites

GameLoop
        LIBSCREEN_WAIT_V #250
        jsr UserInput
        jsr AddGravity
        ;jsr dbUserInput
        jsr UpdateSprites
        jsr LandingDetection
        jsr CollisionDetection
        ;jsr dbCollisionDetection
        jsr DisplayFuel
        jsr DisplayVelocity        
        jsr GameFlowUpdate

        lda gameStatus
        cmp #gfLanded
        beq Winner
        cmp #gfMenu
        bne GameLoop
        jmp Initialise

Winner
        jmp Winner



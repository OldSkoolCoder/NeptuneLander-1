gfStatusJumpTableLo             byte <GameFlow_StatusMenu
                                byte <GameFlow_StatusNextLevel
                                byte <GameFlow_StatusAlive
                                byte <GameFlow_StatusLanded
                                byte <GameFlow_StatusDying
                                byte <GameFlow_StatusDead
                                byte <GameFlow_StatusHiScore

gfStatusJumpTableHi             byte >GameFlow_StatusMenu
                                byte >GameFlow_StatusNextLevel
                                byte >GameFlow_StatusAlive
                                byte >GameFlow_StatusLanded
                                byte >GameFlow_StatusDying
                                byte >GameFlow_StatusDead
                                byte >GameFlow_StatusHiScore

GameFlow_Update
        ldx gameStatus
        lda gfStatusJumpTableLo,x
        sta zpLow
        lda gfStatusJumpTableHi,x
        sta zpHigh
        jmp (zpLow)

GameFlow_StatusMenu
        jsr Initialise_Menu
        lda #GF_STATUS_NEXT_LEVEL
        sta gameStatus
        rts

GameFlow_StatusNextLevel
        jsr gameLevel_IntroText
        jsr gameLevel_PrepareLevel
        jsr gameLevel_InitialiseSprites
        lda #GF_STATUS_ALIVE
        sta gameStatus
        rts

GameFlow_StatusAlive
        jsr gamePlayer_UserInput
        jsr gamePlayer_Move
        jsr gamePlayer_AddGravity
        jsr gamePlayer_UpdateSprites
        jsr gameGauges_AdjustVelocityGauge
        jsr gameGauges_DisplayFuelGauge
        jsr gameGauges_DisplayVelocityGauge
        jsr gameShip_CheckLanded
        jsr gameShip_CheckCollision
        lda shipLanded
        beq .NotLanded
        lda #GF_STATUS_LANDED
        sta gameStatus
.NotLanded
        lda shipCollided
        beq .NotCollided
        lda #GF_STATUS_DYING
        sta gameStatus
.NotCollided
        rts

GameFlow_StatusLanded
        jsr gameShip_Landed
        rts

GameFlow_StatusDying
        jsr gameShip_Exploding
        rts

GameFlow_StatusDead
        jsr gameLevel_GameOver
        rts

GameFlow_StatusHiScore
        rts


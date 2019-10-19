gfStatusJumpTableLo             byte <GameFlowStatusMenu
                                byte <GameFlowStatusAlive
                                byte <GameFlowStatusLanded
                                byte <GameFlowStatusDying
                                byte <GameFlowStatusDead

gfStatusJumpTableHi             byte >GameFlowStatusMenu
                                byte >GameFlowStatusAlive
                                byte >GameFlowStatusLanded
                                byte >GameFlowStatusDying
                                byte >GameFlowStatusDead

GameFlowUpdate
        ldx gameStatus
        lda gfStatusJumpTableLo,x
        sta zpLow
        lda gfStatusJumpTableHi,x
        sta zpHigh

        jmp (zpLow)

GameFlowStatusMenu
        ;not yet implemented
        rts

GameFlowStatusAlive
        lda collisionBackground
        ;lda dbcollision
        beq @exit
        lda #gfDying
        sta gameStatus
@exit
        rts

GameFlowStatusDying
        lda #True
        sta shipExplosionActive
        LIBSPRITE_MULTICOLORENABLE_AV shipSprite, true
        LIBSPRITE_ENABLE_VV %00000110, false
@Loop
        jsr shipExplosion
        lda shipExplosionActive
        bne @loop
        lda #gfDead
        sta gameStatus
        rts

GameFlowStatusDead
        LIBSPRITE_ENABLE_VV %00000001, false
@loop
        LIBJOY_GETJOY_V JoyFire
        bne @loop
        lda #gfMenu
        sta gameStatus
        rts

GameFlowStatusLanded
        ;not yet active
        rts

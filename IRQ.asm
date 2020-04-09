IRQ_Initialise
        sei
        lda #<IRQ_Main
        ldx #>IRQ_Main
        sta $0314
        stx $0315
        lda #%00011011
        ldx #0
        ldy #%01111111
        sta VCR1
        stx RASTER
        sty ICSR
        lda #1
        sta IRQMR
        sta VICINT
        cli
        rts


IRQ_Main
        asl VICINT
        jsr SID_PLAY
        jmp krnINTERRUPT
        rts


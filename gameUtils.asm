gameUtils_CopyMusic ;lda with highbyte of memory location
        sei
        sta zpHigh
        lda #0
        sta zpLow
        sta zpLow2
        lda #$10
        sta zpHigh2

        ldy #0
.CopyLoop
        lda (zpLow),y
        sta (zpLow2),y
        inc zpLow
        inc zpLow2
        bne .CopyLoop
        inc zpHigh
        inc zpHigh2
        lda zpHigh2
        cmp #$20
        bne .CopyLoop
        cli
        rts




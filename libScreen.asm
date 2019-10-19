;-------------------------------------------------------------------------------
;LIBSCREEN: Screen Libraries
;-------------------------------------------------------------------------------

;Sets 1000 bytes of memory from start address with a value
defm 	LIBSCREEN_SET1000_AV ;Address, Character

        lda #/2
        ldx #250
@loop   dex
        sta /1,x
        sta /1+250,x
        sta /1+500,x
        sta /1+750,x
        bne @loop

        endm

;Set border and background colours
defm 	LIBSCREEN_SETCOLOURS_VVVVV ;Border, Background0, Background1, Backgroung2, Background3

        lda #/1
        sta BDCOL
        lda #/2
        sta BGCOL0
        lda #/3
        sta BGCOL1
        lda #/4
        sta BGCOL2
        lda #/5
        sta BGCOL3

        endm

;Set video modes
defm 	LIBSCREEN_SETVIC_AV ;VICRegister, Mode

        lda /1
        ora #/2
        sta /1

        endm

;Wait for given raster line
defm 	LIBSCREEN_WAIT_V ;Line

@loop   lda #/1
        cmp RASTER
        bne @loop

        endm
       
defm    LIBSCREEN_VERTICALCHAR_VVVAA ;character, colour, length, screen address, colour address

        lda #</4
        sta zpLow
        lda #>/4
        sta zpHigh
        lda #</5
        sta zpLow2
        lda #>/5
        sta zpHigh2
        ldx #/3
@loop   ldy #$00
        lda #/1
        sta (zpLow),y
        lda #/2
        sta (zpLow2),y
        clc
        lda zpLow
        adc #40
        sta zpLow
        lda zpHigh
        adc #0
        sta zpHigh
        clc
        lda zpLow2
        adc #40
        sta zpLow2
        lda zpHigh2
        adc #0
        sta zpHigh2
        dex
        bne @loop

        endm

;Print to the screen using the kernal CHROUT routine (max 255 chars)
defm 	LIBSCREEN_PRINT_A ;address of text

        ldy #0
@nextchar
        lda /1,y
        beq @exit
        jsr krnCHROUT
        iny
        jmp @nextchar
@exit
        endm
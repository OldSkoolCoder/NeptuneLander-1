; Copy screen and colour data to display ram
defm    LIBSCREEN_COPYSCREENROW_A
        lda /1,y
        sta /1+40,y
        lda /1+$D400,y
        sta /1+$D428,y
        endm


defm    LIBSCREEN_COPYSCREEN_A
        ldx #0
@loop   
        lda /1,x
        sta SCREENRAM,x
        lda /1+250,x
        sta SCREENRAM+250,x
        lda /1+500,x
        sta SCREENRAM+500,x
        lda /1+750,x
        sta SCREENRAM+750,x
        lda /1+1000,x
        sta COLOURRAM,x
        lda /1+1250,x
        sta COLOURRAM+250,x
        lda /1+1500,x
        sta COLOURRAM+500,x
        lda /1+1750,x
        sta COLOURRAM+750,x
        inx
        cpx #251
        bne @loop
        endm


; Set screen border and background colour
defm    LIBSCREEN_SETCOLOURS_VV ;Border, Background
        lda #/1
        sta BDCOL
        lda #/2
        sta BGCOL0
        endm


; Wait for raster line
defm    LIBSCREEN_WAIT_V ;Line number
@loop   lda #/1
        cmp RASTER
        bne @loop
        endm


; Wait for raster line
defm    LIBSCREEN_WAIT_A ;Line number
@loop   lda /1
        cmp RASTER
        bne @loop
        endm


; Get input for joystick in port 2
defm    LIBJOY_GETJOY_V ; JoystickDirection
        lda CIAPRA
        and #/1
        endm ; test with bne on return


;Set video modes
defm    LIBSCREEN_SETVIC_AV ;VICRegister, Mode

        lda /1
        ora #/2
        sta /1

        endm

; Set 1000 consecutive bytes to a character code
defm    LIBSCREEN_SET1000_AV ;Start Address, Character Code
        lda #/2
        ldx #250
@loop   dex
        sta /1,x
        sta /1+250,x
        sta /1+500,x
        sta /1+750,x
        bne @loop
        endm


; Print a decimal value to the screen
defm    LIBSCREEN_DISPLAY_DECIMAL_AA ;Decimal address, screen location
        lda /1
        and #$F0
        lsr
        lsr
        lsr
        lsr
        ora #$30
        sta /2
        lda /1
        and #$0F
        ora #$30
        sta /2 + 1
        endm


; Simple delay
defm    LIBGENERAL_DELAY_V ; no. of y loops
        ldy #/1
@loopy
        ldx #$FF
@loopx
        dex
        bne @loopx
        dey
        bne @loopy
        endm


;Print to the screen using the kernal CHROUT routine (max 255 chars)
defm    LIBSCREEN_INDIRECT_PRINT_A ;address of text
        ldy #0
@nextchar
        lda (/1),y
        beq @exit
        jsr krnCHROUT
        iny
        jmp @nextchar
@exit
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


; Switch on sprite multicolour mode
defm    LIBSPRITE_MULTICOLORENABLE_VV ;Sprite Number, True/False
        ldy #/1
        lda spriteNumberMask,y      
        ldy #/2
        beq @disable
@enable
        ora SPRMCS
        sta SPRMCS
        jmp @done 
@disable
        eor #$FF
        and SPRMCS
        sta SPRMCS
@done
        endm


; Set current animation frame for sprite
defm    LIBSPRITE_SETFRAME_VV ;Sprite Number, Anim Index
        ldy #/1        
        clc
        lda #/2
        adc #SPRITERAM
        sta SPRPTR0,y
        endm


;set sprite animation frame  
defm    LIBSPRITE_SETFRAME_VA ;Sprite Number, Anim Index

        ldy #/1        
        clc
        lda /2
        adc #SPRITERAM
        sta SPRPTR0,y
        endm


defm    LIBSPRITE_SETPOSITION_VAAA ;SpriteNumber, XHi, XLo, Y

        lda #/1
        asl
        tay
        lda /3
        sta SPRX0,y
        lda /4
        sta SPRY0,y
        ldy #/1
        lda spriteNumberMask,y
        eor #$FF
        and SPRXMSB
        sta SPRXMSB
        ldy /2
        beq @end
        ldy #/1
        lda spriteNumberMask,y
        ora SPRXMSB
        sta SPRXMSB
@end
        endm


defm    LIBSPRITE_SETCOLOUR_VV ;SpriteNumber, Value

        lda #/2
        sta SPRCOL0 + /1
        
        endm


;Sprite multi-colour set
defm    LIBSPRITE_SETMULTICOLORS_VV ;Colour0, Colour1

        lda #/1
        sta SPRMC0
        lda #/2
        sta SPRMC1

        endm


;Sprite enable/disable
defm    LIBSPRITE_ENABLE_VV ;SpriteNumber, True/False

        lda #/1
        ldy #/2
        beq @disable
@enable
        ora SPREN
        sta SPREN
        jmp @done 
@disable
        eor #$FF
        and SPREN
        sta SPREN
@done
        endm


;Subtract an 8-bit value from a 16-bit address
defm    LIBMATHS_SUBTRACT_16BIT_AV ;Address, value
        sec
        lda /1
        sbc #/2
        sta /1
        lda /1 + 1
        sbc #0
        sta /1 + 1
        endm


;Add 8-bit value to a 16-bit address
defm    LIBMATHS_ADD_16BIT_AV ;Address, value
        clc
        lda /1
        adc #/2
        sta /1
        lda /1 + 1
        adc #0
        sta /1 + 1
        endm


;Add value to a value in an address and store it
defm    LIBMATHS_ADD_16BIT_AA ;Source1, Source2
        clc
        lda /1
        adc /2
        sta /1
        lda /1 + 1
        adc /2 + 1
        sta /1 + 1
        endm


;Add value to a value in an address and store it
defm    LIBMATHS_ADD_DEC_24BIT_AA ;Source1 24bit, Source2 8bit
        sei
        sed
        clc
        lda /1
        adc /2
        sta /1
        lda /1 + 1
        adc #0
        sta /1 + 1
        lda /1 + 2
        adc #0
        sta /1 + 2
        cld
        cli
        endm


;Subtract one 16-bit value from another
defm    LIBMATHS_SUBTRACT_16BIT_AA ;Source 1, Source 2
        sec
        lda /1
        sbc /2
        sta /1
        lda /1 + 1
        sbc /2 + 1
        sta /1 + 1
        endm


;Add one addres to another address and store it
defm    LIBMATHS_ADD_8BIT_AA ;Source1, Source
        clc
        lda /1
        adc /2
        sta /1
        endm


;Subtract one address from another address and store it
defm    LIBMATHS_SUBTRACT_8BIT_AA ;Source1, Source2
        sec
        lda /1
        sbc /2
        sta /1
        endm


defm    LIBSPRITE_DATACOLLIDE_V ;spritenumber
        ldy #/1
        lda SpriteNumberMask,y
        and SPRCBG
        endm


defm    LIBSPRITE_CHECKPOS_AAAAAAA ;Y, min, max, X, min, max, result
        lda /1 
        cmp /2 
        bcc @done
        cmp /3
        bcs @done
        lda /4 
        cmp /5 
        bcc @done
        cmp /6 
        bcs @done
        lda #TRUE
        sta /7
@done
        endm

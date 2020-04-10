;-------------------------------------------------------------------------------
;LIBMATHS: Maths Libraries
;-------------------------------------------------------------------------------

;Add one addres to another address and store it
defm 	LIBMATHS_ADD_8BIT_AAA ;Source1, Source2, Target

        clc
        lda /1
        adc /2
        sta /3
    
        endm

;Add value to a value in an address and store it
defm 	LIBMATHS_ADD_16BIT_AVVA ;Source, Low Byte, High Byte, Target

        clc
        lda /1
        adc #/2
        sta /4
        lda /1 + 1
        adc #/3
        sta /4 + 1

        endm

;Add value to a value in an address and store it
defm 	LIBMATHS_ADD_16BIT_AAA ;Source1, Source2, Target

        clc
        lda /1
        adc /2
        sta /3
        lda /1 + 1
        adc /2 + 1
        sta /3 + 1

        endm

;Subtract one address from another address and store it
defm 	LIBMATHS_SUBTRACT_8BIT_AAA ;Source1, Source2, Target

        sec
        lda /1
        sbc /2
        sta /3
    
        endm
        
;Subtract one 16-bit value from another
defm 	LIBMATHS_SUBTRACT_16BIT_AAA ;Source 1, Source 2, Target

        sec
        lda /1
        sbc /2
        sta /3
        lda /1 + 1
        sbc /2 + 1
        sta /3 + 1
    
        endm
        
;Subtract an 8-bit value from a 16-bit value
defm 	LIBMATHS_SUBTRACT_16BIT_AVVA ;Source 1, Low byte, high byte, Target

        sec
        lda /1
        sbc #/2
        sta /4
        lda /1 + 1
        sbc #/3
        sta /4 + 1
    
        endm
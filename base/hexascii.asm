;SAVE#D:HEXASCII.ASM
resatascii
	.by $00,$00,$00,$00,$00,$00,$00,$00
resbcd
	.by $00,$00,$00,$00
val	
	.by $00,$00,$00
limpiores
	ldx #7
	lda #0
limpiores01
	sta resatascii,X
	dex
	bpl limpiores01
	ldx #3
limpiores02
	sta resbcd,X
	dex
	bpl limpiores02
	rts
limpioval
	ldx #2
	lda #$00
limpioval01
	sta val,X
	dex
	bpl limpioval01
	rts
; Convert an 16 bit binary value into a 24bit BCD value
bin2bcd
	jsr limpiores
	lda #0		  ;Clear the result area
	sta resbcd+0
	sta resbcd+1
	sta resbcd+2
	sta resbcd+3
	ldx #24		 ;Setup the bit counter
	sed			 ;Enter decimal mode
loophex
	asl val+0	   ;Shift a bit out of the binary
	rol val+1
	rol val+2	   ;... value
	lda resbcd+0	   ;And add it into the result, doubling
	adc resbcd+0	   ;... it at the same time
	sta resbcd+0
	lda resbcd+1
	adc resbcd+1
	sta resbcd+1
	lda resbcd+2
	adc resbcd+2
	sta resbcd+2
	lda resbcd+3
	adc resbcd+3
	sta resbcd+3
	dex			 ;More bits to process?
	bne loophex
	cld			 ;Leave decimal mode
	;BRK
bcd2atascii
	ldx #4
	ldy #0
loop2
	lda resbcd-1,X
	lsr
	lsr
	lsr
	lsr
	ora #$10
	sta resatascii,Y
	lda resbcd-1,X
	and #$0F
	ora #$10
	sta resatascii+1,Y
	iny
	iny
	dex
	bne loop2
	rts
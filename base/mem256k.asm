; SAVE #D:MEM256K.ASM
;RECONOCEDOR DE BANCOS
;BY VITOCO
;El acceso a la memoria extendida del 130XE y del 800XL modificado
;se realiza a traves de bancos de memoria de 16K cada uno, accesibles
;a traves de una zona fija de memoria ($4000-$7FFF) que es reemplazada
;por el banco. Para activar un banco especifico, se debe modificar
;algunos bits en el registro de hardware denominado PORTB (direccion
;de memoria 54017). La combinacion de bits requerida para cada banco
;es la siguiente:
;       | POKE  | Banco real | D=0	 V=0 E=0		 B=0 R=1
; Banco | 54017 | 130XE 256K |  7   6   5   4   3   2   1   0
;-------|-------|------------|---------------------------------
;   0   |  177  |  RAM   RAM |  1   0   1   1   0   0   0   1
;   1   |  161  |   0     4  |  1   0   1   0   0   0   0   1
;   2   |  165  |   1     5  |  1   0   1   0   0   1   0   1
;   3   |  169  |   2     6  |  1   0   1   0   1   0   0   1
;   4   |  173  |   3     7  |  1   0   1   0   1   1   0   1
;   5   |  193  |         8  |  1   1   0   0   0   0   0   1
;   6   |  197  |         9  |  1   1   0   0   0   1   0   1
;   7   |  201  |        10  |  1   1   0   0   1   0   0   1
;   8   |  205  |        11  |  1   1   0   0   1   1   0   1
;   9   |  225  |        12  |  1   1   1   0   0   0   0   1
;  10   |  229  |        13  |  1   1   1   0   0   1   0   1
;  11   |  233  |        14  |  1   1   1   0   1   0   0   1
;  12   |  237  |        15  |  1   1   1   0   1   1   0   1
;-------|-------|------------|---------------------------------
;  13   |  129  |         0  |  1   0   0   0   0   0   0   1
;  14   |  133  |         1  |  1   0   0   0   0   1   0   1
;  15   |  137  |         2  |  1   0   0   0   1   0   0   1
;  16   |  141  |         3  |  1   0   0   0   1   1   0   1
;
max = 16
bankos
	.wo max
memory
	.by $00,$00,$00
b	
;		  ;$B1,$A1,$A5,$A9,$AD
;	.BYTE 177,$161,165,169,173
;		  ;$C1,$C5,$C9,$CD,$E1
;	.BYTE 193,197,201,205,225
;		  ;$E5,$E9,$ED,$81,$85
;	.BYTE 229,233,237,129,133
		  ;$89,$8D
;	.BYTE 137,141
;
;
	.by $B2
	.by $A2,$A6,$AA,$AE
	.by $C2,$C6,$CA,$CE
	.by $E2,$E6,$EA,$EE
	.by $82,$86,$8A,$8E
limpio.memory
	lda #$00
	sta memory
	sta memory+1
	sta memory+2
	rts
memoria
	ldy #max
busco1
	lda b,y
	sta portb
	sta 22222
	dey 
	bpl busco1
	ldy #1
busco2
	lda B,Y
	sta portb
	cmp 22222
	bne distinto
	iny
	cpy #max+1
	bne busco2
distinto
	lda B
	sta portb
	sty bankos
	jsr limpio.memory
	ldx bankos
	dex
distinto2
;SACO CALCULO DE MEMORIA
;DISPONIBLE SEGUN BANCOS
;ENCONTRADOS
	clc
	lda memory
	adc #$00
	sta memory
	lda memory+1
	adc #$40
	sta memory+1
	lda memory+2
	adc #$00
	sta memory+2
	dex 
	bpl distinto2
	rts
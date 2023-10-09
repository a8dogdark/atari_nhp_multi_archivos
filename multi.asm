    icl 'base/sys_equates.m65'
    icl 'base/sys_macros.m65'

;
;valores principales que regula los baudios
;
b00600 = $05cc  ;timer a  600 bps
b00800 = $0458  ;timer a  800 bps
b00990 = $0380  ;timer a  991 bps
b01150 = $0303  ;timer a 1150 bps
b01400 = $0278  ;timer a 1400 bps
pcrsr = $cb 



    org $2000
    icl 'base/romram.asm'
    icl 'base/loader.asm'
    icl 'base/pagina7.asm'
    icl 'base/pagina4.asm'
    icl 'base/mem256k.asm'
    icl 'base/hexascii.asm'
    
    

;
;display list principal
dls
:3    .by $70
    .by $46
    .wo show
    .by $70
:21    .BY $02
    .by $41
    .wo dls
show
    .sb " "
    .sb +128,"dogdark"
    .sb "  softwares "
    .sb +32,"QRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRE"
    .sb "|"
    .sb +128,"MULTICOPIADOR DE ARCHIVOS NHP 3.1 2023"
    .sb "|"
    .sb +32,"ARRRRRRRRRWRRRRRRRRRRRRRRRRRRRRRRRRRRRRD"
    .sb "|MEMORIA  | "
shmemo
    .sb "******                     |"
    .sb "|BANCOS   | "
shbancos
    .sb "**                         |"
    .sb "|TITULO 01| "
shtit01    
    .sb "********************       |"
    .sb "|TITULO 02| "
shtit02
    .sb "********************       |"
    .sb "|TITULO 03| "
shtit03
    .sb "********************       |"
    .sb "|TITULO 04| "
shtit04
    .sb "********************       |"
    .sb "|TITULO 05| "
shtit05
    .sb "********************       |"
    .sb "|TITULO 06| "
shtit06
    .sb "********************       |"
    .sb "|SISTEMA  | "
muestrosistema
    .sb "NHP                        |"
    .sb "|AUDIO    | "
muestroaudio
    .sb "ON                         |"
    .sb "|FUENTE   | "
fuente 
    .sb "********************       |"
    .sb +32,"ARWRRRRRRRXWRRRRRRRRRWRRRRRRRRRRRRRRRRRD"
    .sb "|#| BYTES  | BLOQUES | BANCO           |"
    .sb +32,"ARSRRRRRRRRSRRRRRRRRRSRRRRRRRRRRRRRRRRRD"
sharchi01
    .sb "|1| "
shbytes01
    .sb "****** |    "
shblockes01
    .sb "**** |    "
shbank01
    .sb "**           |"
sharchi02
    .sb "|2| "
shbytes02
    .sb "****** |    "
shblockes02
    .sb "**** |    "
shbank02
    .sb "**           |"
sharchi03
    .sb "|3| "
shbytes03
    .sb "****** |    "
shblockes03
    .sb "**** |    "
shbank03
    .sb "**           |"
    .sb +32,"ZRXRRRRRRRRXRRRRRRRRRXRRRRRRRRRRRRRRRRRC"
datash
    .by 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
;1er byte controla sistema de velocidad
;2do byte controla audio
;3er byte
sistema 
    .by 0,0,0
veonhp
    .sb "NHP  "
veonhp8
    .sb "NHP8 "
veostac
    .sb "STAC "
veoultra
    .sb "ULTRA"
veosuper
    .sb "SUPER"
veoaudioon
    .sb "ON "
veoaudiooff
    .sb "OFF"
;   
;funcion para regular la velocidad
;
baud.600
    lda #<b00600
    jsr baud.m1
    lda #>b00600
    jmp baud.m2
baud.800
    lda #<b00800
    jsr baud.m1
    lda #>b00800
    jsr baud.m2
baud.990
    lda #<b00990
    jsr baud.m1
    lda #>b00990
    jsr baud.m2
baud.1150
    lda #<b01150
    jsr baud.m1
    lda #>b01150
    jsr baud.m2
baud.1400
    lda #<b01400
    jsr baud.m1
    lda #>b01400
baud.m2    
    sta $eba8
    sta $fd46
    sta $fce1
    rts
baud.m1
    sta $eba3
    sta $fd41
    sta $fcdc
    rts


reseter
    ldx #19
    lda #$00
reseter02
    sta shtit01,x
    sta shtit02,x
    sta shtit03,x
    sta shtit04,x
    sta shtit05,x
    sta shtit06,x
    sta fuente,x
    dex
    bpl reseter02
    ldx #5
    lda #$10
reseter03
    sta shmemo,x
    sta shbytes01,x
    sta shbytes02,x
    sta shbytes03,x
    dex
    bpl reseter03
    sta shbancos
    sta shbancos+1
    ldx #3
reseter04
    sta shblockes01,x
    sta shblockes02,x
    sta shblockes03,x
    dex
    bpl reseter04
    sta shbank01
    sta shbank01+1
    sta shbank02
    sta shbank02+1
    sta shbank03
    sta shbank03+1
;obtenemos los bancoy memoria disponible
    jsr limpioval
    jsr memoria
;mostramos la cantidad de bancos disponibles
    jsr limpioval
    lda bankos
    sta val
    jsr bin2bcd
    lda resatascii+7
    sta shbancos+1
    lda resatascii+6
    sta shbancos
;mostramos los bytes disponibles de memoria
    jsr limpioval
    lda memory
    sta val
    lda memory+1
    sta val+1
    lda memory+2
    sta val+2
    jsr bin2bcd
    ldx #7
    ldy #5
reseter05
    lda resatascii,x 
    sta shmemo,y 
    dex
    dey
    bpl reseter05
    jsr baud.600
    ldx #$ff
    stx $d301
    rts


;
;funcion que cierra perifericos
;
close
    ldx #$10
    lda #$0c
    sta $0342,x
    jmp $e456





;
;video inverso para datos de archivos
;
inverso
    clc
    lda sharchi01+1
    adc #128
    sta sharchi01+1
    rts
noinverso
    rts

;
;fsk
;
fsk
    ldx #$08
fsk2
    lda data01fsk,x
    sta $d200,x
    dex
    bpl fsk2
    rts
data01fsk
    .by $05,$a0,$07,$a0,$05,$a0,$07,$a0,$00
dos
    jmp ($0c)
@start
    jsr dos
start
    ldx #<dls
    stx $230
    ldy #>dls
    sty $231
    lda #$02
    sta 710
    sta 712
;
;colocamos interrupcion vbi
;
    ldy #<VBI
    ldx #>VBI
    lda #$07    ;diferida
    jsr setvbv  
    

;ingresamos el titulo 01
    ldx #<shtit01
    ldy #>shtit01
    stx pcrsr
    sty pcrsr+1
    jsr rutlee
;ingresamos la fuente 01

;ingresamos el titulo 02

;ingresamos la fuente 02

;ingresamos el titulo 03

;ingresamos la fuente 03



    ;jsr inverso
    jmp *
inicio
    jsr close
    jsr kem
    ldx #<@start
    ldy #>@start
    lda #$03
    stx $02
    sty $03
    sta $09
    ldy #$ff
    sty $08
    iny
    sty $0244
    ldx #$00
    stx sistema
    stx sistema+1
    stx sistema+2
    jsr reseter
    jmp start
;rutina tecla option para cambiar el sistema
.proc VBI
    lda consol
    cmp consol_anterior
    beq fin
    sta consol_anterior
    cmp #$05    ;select
    beq esselect
    cmp #$03    ;option
    bne fin
;es option
esoption
    ldx sistema
    cpx #4
    bne esoption02
    ldx #$ff
esoption02
    inx
    stx sistema
    lda #<veonhp
    ldy #>veonhp
    cpx #$00
    beq esoption03
    lda #<veonhp8
    ldy #>veonhp8
    cpx #$01
    beq esoption03
    lda #<veostac
    ldy #>veostac
    cpx #$02
    beq esoption03
    lda #<veoultra
    ldy #>veoultra
    cpx #$03
    beq esoption03
    lda #<veosuper
    ldy #>veosuper
esoption03
    sta loop_copia+1
    sty loop_copia+2
    ldy #$04
loop_copia
    lda veonhp,y
    sta muestrosistema,y
    dey
    bpl loop_copia
    jmp fin
esselect
    ldx sistema+1
    cpx #01
    bne esselect02
    ldx #$ff
esselect02
    inx
    stx sistema+1
    lda #<veoaudioon
    ldy #>veoaudioon
    cpx #$00
    beq esselect03
    lda #<veoaudiooff
    ldy #>veoaudiooff
esselect03
    sta loop_copia_sel+1
    sty loop_copia_sel+2
    ldy #$02
loop_copia_sel
    lda veoaudioon,y
    sta muestroaudio,y
    dey
    bpl loop_copia_sel
fin
    jmp $e462
consol_anterior
    .by $00
.end
    run inicio
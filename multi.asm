    icl 'base/sys_equates.m65'
    icl 'base/sys_macros.m65'
    org $2000
    icl 'base/romram.asm'
    icl 'base/loader.asm'
    icl 'base/pagina7.asm'
    icl 'base/pagina4.asm'
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
shbanc
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
    .sb "|SISTEMA  | NORMAL                     |"
    .sb "|AUDIO    | ON                         |"
    .sb "|FUENTE   | "
fuente 
    .sb "********************       |"
    .sb +32,"ARWRRRRRRRXWRRRRRRRRRWRRRRRRRRRRRRRRRRRD"
    .sb "|#| BYTES  | BLOQUES | BANCO           |"
    .sb +32,"ARSRRRRRRRRSRRRRRRRRRSRRRRRRRRRRRRRRRRRD"
    .sb "|1| "
shbytes01
    .sb "****** |    **** |    **           |"
    .sb "|2| "
shbytes02
    .sb "****** |    **** |    **           |"
    .sb "|3| "
shbytes03
    .sb "****** |    **** |    **           |"
    .sb +32,"ZRXRRRRRRRRXRRRRRRRRRXRRRRRRRRRRRRRRRRRC"
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
    sta shbanc
    sta shbanc+1





    rts

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
    jsr reseter
    jmp *
inicio
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
    jmp start
    run inicio
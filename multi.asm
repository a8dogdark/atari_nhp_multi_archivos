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
    .by $41
    .wo dls
show
    .sb " "
    .sb +128,"dogdark"
    .sb "  softwares "
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
    jmp *
inicio

    jmp start
    run inicio
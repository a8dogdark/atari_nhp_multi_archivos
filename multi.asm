    icl 'base/sys_equates.m65'
    icl 'base/sys_macros.m65'
    org $2000
    icl 'base/romram.asm'
    icl 'base/loader.asm'
    icl 'base/pagina7.asm'
    icl 'base/pagina4.asm'
dos
    jmp ($0c)
@start
    jsr dos
start

    jmp *
inicio

    jmp start
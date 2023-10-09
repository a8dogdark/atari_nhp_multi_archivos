    ORG $2000
DLS
:3    .BY $70
    .BY $46
    .WO SHOW
    .BY $70,$02,$70,$02,$02,$02
    .BY $02,$02,$02,$02,$02,$02
    .BY $02,$02,$02,$02,$02,$02
    .BY $02,$02
    .BY $41
    .WO DLS
SHOW
    .SB " "
    .SB +128,"dogdark"
    .SB "  softwares "
    .SB +128," CONVERSOR MULTI ARCHIVOS NHP V3.1 2023 "
    .SB +32,"QRRRRRRRRRRRRWRRRRRRRRRRRRRRRRRRRRRRRRRE"
    .SB "|MEMORIA     | 000000                  |"
    .SB "|BANCOS      | 00                      |"
    .SB "|TITULO 01   | ********************    |"
    .SB "|TITULO 02   | ********************    |"
    .SB "|TITULO 03   | ********************    |"
    .SB "|TITULO 04   | ********************    |"
    .SB "|TITULO 05   | ********************    |"
    .SB "|TITULO 06   | ********************    |"
    .SB "|FUENTE      | ********************    |"
    .SB +32,"ARRRWRRRRRRRRSRRRRRRRRRWRRRRRRRRRRRRRRRD"
    .SB     "| # | BYTES  | BLOQUES | BANCO         |"
    .SB +32,"ARRRSRRRRRRRRSRRRRRRRRRSRRRRRRRRRRRRRRRD"
    .SB "| * | ****** |    **** | **            |"
    .SB "| * | ****** |    **** | **            |"
    .SB "| * | ****** |    **** | **            |"
    .SB +32,"ZRRRXRRRRRRRRXRRRRRRRRRXRRRRRRRRRRRRRRRC"
INICIO
    LDX #<DLS
    LDY #>DLS
    STX $230
    STY $231
    LDA #$02
    STA 710
    STA 712
    JMP *
    RUN INICIO
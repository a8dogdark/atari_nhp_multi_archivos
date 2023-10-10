    ICL 'BASE/sys_equates.m65'
    ICL 'BASE/sys_macros.m65'
;************************************************
;VARIABLES BASICAS
;************************************************
;
;
;VALORES QUE USAREMOS EN LOS TIMER DE VELOCIDAD
;DE CARGA
;
;NHP	= CARGARA EN SU TOTALIDAD EN 600 BAUDIOS
;8NHP	= CARGARA EN SU TOTALIDAD EN 800 BAUDIOS
;STAC	= 4 PRIMEROS BLOQUES LO REALIZA EN 800 BAUDIOS,
;		  Y EL RESTO LO CARGARA EN 990 BAUDIOS
;ULTRA	= 4 PRIMEROS BLOQUES LO REALIZA EN 800 BAUDIOS,
;		  Y EL RESTO LO CARGARA EN 1150, SE HICIERON PRUEBAS
;		  EN CINTA REAL EN UNA CASETERA XC11, A 1200 BAUDIOS
;		  CON ALGUNAS DIFICULTADOES DE LECTURA, BAJANDO ESTO
;		  A 1150 BAUDIOS, CARGO SIN PROBLEMAS, SE ACONSEJA
;		  SEGUN PRUEBAS EN CINTA REAL, PARA CASETERAS XC12
;		  O SISTEMAS INJEKTOR NO GRABAR A MAS DE 1000 BAUDIOS
;		  PARA OBTENER UNA LECTURA. BYTE A 1000 BAUDIOS $0378
;SUPUL	= 4 PRIMEROS BLOQUES LO REALIZA EN 800 BAUDIOS,
;		  Y EL RESTO LO CARGARA EN 1400, SE HICIERON PRUEBAS
;		  EN CASETERAS REALES NO TENIENDO NINGUN RESULTADO POSITIVO,
;		  EN CAMBIO SI SE CREA UN AUDIO EN UN PC Y LUEGO SE CARGA
;		  A TRAVES DE UN CASETTE ADAPTER, ESTE FUNCIONA SIN PROBLEMA
;		  ALGUNO.
;************************************************
;VALORES PRINCIPALES QUE REGULA LOS BAUDIOS
;CODIGO DONADO POR WILLYSOFT
;************************************************
B00600 	= $05CC		;TIMER  600 BPS
B00800 	= $0458  	;TIMER  800 BPS
B00990 	= $0380  	;TIMER  991 BPS
B01150 	= $0303  	;TIMER 1150 BPS
B01400	= $0278		;TIMER 1400 BPS
PCRSR   = $CB
;************************************************
    ORG $2000
    ICL 'BASE/ROMRAM.ASM'
    ICL 'BASE/HEXASCII.ASM'
    ICL 'BASE/MEM256K.ASM'
DLS
:3    .BY $70
    .BY $46
    .WO SHOW
    .BY $70,$02,$70,$02,$02,$02
    .BY $02,$02,$02,$02,$02,$02
    .BY $02,$02,$02,$02,$02,$02
    .BY $02,$02,$02,$02
    .BY $41
    .WO DLS
SHOW
    .SB " "
    .SB +128,"dogdark"
    .SB "  softwares "
    .SB +128," CONVERSOR MULTI ARCHIVOS NHP V3.1 2023 "
    .SB +32,"QRRRRRRRRRRRRWRRRRRRRRRRRRRRRRRRRRRRRRRE"
    .SB "|MEMORIA     | "
MUESTROMEMORIA
    .SB "000000                  |"
    .SB "|BANCOS      | "
MUESTROBANCOS
    .SB "00                      |"
    .SB "|TITULO 01   | "
TITULO01
    .SB "********************    |"
    .SB "|TITULO 02   | "
TITULO02
    .SB "********************    |"
    .SB "|TITULO 03   | "
TITULO03
    .SB "********************    |"
    .SB "|TITULO 04   | "
TITULO04
    .SB "********************    |"
    .SB "|TITULO 05   | "
TITULO05
    .SB "********************    |"
    .SB "|TITULO 06   | "
TITULO06
    .SB "********************    |"
    .SB "|FUENTE      | "
FUENTE  
    .SB "********************    |"
    .SB "|SISTEMA     | "
MUESTROSISTEMA    
    .SB "NHP                     |"
    .SB "|AUDIO       | "
MUESTROAUDIO
    .SB "ON                      |"
    .SB +32,"ARRRWRRRRRRRRSRRRRRRRRRWRRRRRRRRRRRRRRRD"
    .SB     "| # | BYTES  | BLOQUES | BANCO         |"
    .SB +32,"ARRRSRRRRRRRRSRRRRRRRRRSRRRRRRRRRRRRRRRD"
DATA
    .SB "| * | ****** |    **** | **            |"
    .SB "| * | ****** |    **** | **            |"
    .SB "| * | ****** |    **** | **            |"
    .SB +32,"ZRRRXRRRRRRRRXRRRRRRRRRXRRRRRRRRRRRRRRRC"
VEONHP
    .SB "NHP  "
VEONHP8
    .SB "NHP8 "
VEOSTAC
    .SB "STAC "
VEOULTRA
    .SB "ULTRA"
VEOSUPER
    .SB "SUPER"
VEOAUDIOON
    .SB "ON "
VEOAUDIOOFF
    .SB "OFF"
GRABANDO
    .SB "PRESIONE START PARA COMENZAR GRABACIÓN"
;VALORES PARA SISTEMA O AUDIO
;1 BIT SISTEMA BAUDIOS
;2 BIT SISTEMA AUDIO 0 ON 1 OFF
SISTEMA
    .BY 0,0,0
RY
    .BY 0,0,0
LEN
    .BY 0,0,0


RESETER
    JSR LIMPIOTITULO01
    JSR LIMPIOTITULO02
    JSR LIMPIOTITULO03
    JSR LIMPIOFUENTE
    JSR CALCULOMEMORIA
    RTS
LIMPIOFUENTE
    LDX #19
    LDA #$00
LIMPIOFUENTE02
    STA FUENTE,X
    DEX
    BPL LIMPIOFUENTE02
    RTS
LIMPIOTITULO01
    LDX #19
    LDA #$00
LIMPIOTITULOS01B
    STA TITULO01,X
    STA TITULO02,X
    DEX
    BPL LIMPIOTITULOS01B
    RTS
LIMPIOTITULO02
    LDX #19
    LDA #$00
LIMPIOTITULOS02B
    STA TITULO03,X
    STA TITULO04,X
    DEX
    BPL LIMPIOTITULOS02B
    RTS
LIMPIOTITULO03
    LDX #19
    LDA #$00
LIMPIOTITULOS03B
    STA TITULO05,X
    STA TITULO06,X
    DEX
    BPL LIMPIOTITULOS03B
    RTS
CALCULOMEMORIA
    JSR LIMPIOVAL
    JSR MEMORIA
    LDA BANKOS
    STA VAL
    JSR BIN2BCD
    LDA RESATASCII+7
    STA MUESTROBANCOS+1
    LDA RESATASCII+6
    STA MUESTROBANCOS
    JSR LIMPIOVAL
    LDA MEMORY
    STA VAL 
    LDA MEMORY+1
    STA VAL+1
    LDA MEMORY+2
    STA VAL+2
    JSR BIN2BCD
    LDX #7
    LDY #5
CALCULOMEMORIA02
    LDA RESATASCII,X
    STA MUESTROMEMORIA,Y 
    DEX
    DEY
    BPL CALCULOMEMORIA02
    RTS
;************************************************
;FUNCION PARA REGULAR LA VELOCIDAD AL GRABAR
;************************************************
;
BAUD.600
	LDA # <B00600
	JSR BAUD.M1
	LDA # >B00600
	JMP BAUD.M2
BAUD.800
	LDA # <B00800
	JSR BAUD.M1
	LDA # >B00800
	JMP BAUD.M2
BAUD.990
	LDA # <B00990
	JSR BAUD.M1
	LDA # >B00990
	JMP BAUD.M2
BAUD.1150
	LDA # <B01150
	JSR BAUD.M1
	LDA # >B01150
	JMP BAUD.M2
BAUD.1400
	LDA # <B01400
	JSR BAUD.M1
	LDA # >B01400
BAUD.M2
	STA $EBA8
	STA $FD46
	STA $FCE1
	RTS
BAUD.M1
	STA $EBA3
	STA $FD41
	STA $FCDC
	RTS
;************************************************
;FUNCION QUE NOS PERMITE PODER CONVERTIR UN BYTE
;EN ATASCII, USADO PARA INGRESO DE TITULOS Y
;FUENTE, NO TIENE LIMITACIONES MAYORES EN LAS
;PULSACIONES DEL TECLADO
;************************************************
ASCINT
	CMP #32
	BCC ADD64
	CMP #96
	BCC SUB32
	CMP #128
	BCC REMAIN
	CMP #160
	BCC ADD64
	CMP #224
	BCC SUB32
	BCS REMAIN
ADD64
	CLC
	ADC #64
	BCC REMAIN
SUB32
	SEC
	SBC #32
REMAIN
	RTS
;************************************************
;FUNCION QUE CIERRA PERIFERICOS
;************************************************
CLOSE
	LDX #$10
	LDA #$0C
	STA $0342,X
	JMP $E456
;************************************************
;RUTINA QUE NOS PERMMITE PODER INGRESAR INFORMA-
;CION A UN CAMPO ESPECIFICO YA ANTES DECLARADO
;MOSTRANDO UN CURSOR EN FORMA PARPADEANTE
;************************************************
;
;************************************************
;CURSOR PARPADEANTE
;************************************************
FLSH
	LDY RY
	LDA (PCRSR),Y
	EOR #63
	STA (PCRSR),Y
	LDA #$10
	STA $021A
	RTS
;************************************************
;ABRE PERIFERICO TECLADO
;************************************************
OPENK
	LDA #255
	STA 764
	LDX #$10
	LDA #$03
	STA $0342,X
	STA $0345,X
	LDA #$26
	STA $0344,X
	LDA #$04
	STA $034A,X
	JSR $E456
	LDA #$07
	STA $0342,X
	LDA #$00
	STA $0348,X
	STA $0349,X
	STA RY
	RTS
;************************************************
;RUTINA QUE LEE LO TECLEADO
;************************************************
RUTLEE
	LDX # <FLSH
	LDY # >FLSH
	LDA #$10
	STX $0228
	STY $0229
	STA $021A
	JSR OPENK
GETEC
	JSR $E456
	CMP #$7E
	BNE C0
	LDY RY
	BEQ GETEC
	LDA #$00
	STA (PCRSR),Y
	LDA #63		;$3F
	DEY
	STA (PCRSR),Y
	DEC RY
	JMP GETEC
C0
	CMP #155	;$9B
	BEQ C2
    CMP #27
    BEQ C3
	JSR ASCINT
	LDY RY
	STA (PCRSR),Y
	CPY #20		;#14
	BEQ C1
	INC RY
C1
	JMP GETEC
C2
	JSR C4
	RTS
C3
    JSR C4
    JMP GRABACION
C4
    JSR CLOSE
	LDA #$00
	STA $021A
	LDY RY
	STA (PCRSR),Y
    RTS
INGRESOFUENTE
    JSR LIMPIOFUENTE
    LDX # <FUENTE
    LDY # >FUENTE
    STX PCRSR
    STY PCRSR+1
    JSR RUTLEE
    RTS
;************************************************
;DISPLAY DE INICIO DEL PROGRAMA Y FUNCIONALIDAD
;DIRECTA A TODAS SUS FUNCIONES
;************************************************
DOS
	JMP ($0C)
@START
	JSR DOS
START
    LDX #<DLS
    LDY #>DLS
    STX $230
    STY $231
    LDA #$02
    STA 710
    STA 712

    LDY #<VBI
    LDX #>VBI
    LDA #$07
    JSR SETVBV

    LDX SISTEMA+2
    CPX #0
    BEQ ARCHIVO01
    CPX #1
    BEQ ARCHIVO02 
    CPX #2
    BEQ ARCHIVO03
    LDX #0
    STX SISTEMA+2
    JMP START
ARCHIVO01
;archivo 01
;ingresamos el primer titulo
    JSR LIMPIOTITULO01
    LDX # <TITULO01
	LDY # >TITULO01
	STX PCRSR
	STY PCRSR+1
	JSR RUTLEE
;ingresamos el segundo titulo
    LDX # <TITULO02
	LDY # >TITULO02
	STX PCRSR
	STY PCRSR+1
	JSR RUTLEE
;ingresamos la fuente
    JSR INGRESOFUENTE
;cargamos el archivo a memoria

    LDX SISTEMA+2
    INX
    STX SISTEMA+2
;mostramos los datos en pantalla
ARCHIVO02 
;archivo02
;ingresamos el primer titulo
    JSR LIMPIOTITULO02
    LDX # <TITULO03
	LDY # >TITULO03
	STX PCRSR
	STY PCRSR+1
	JSR RUTLEE
;ingresamos el segundo titulo
    LDX # <TITULO04
	LDY # >TITULO04
	STX PCRSR
	STY PCRSR+1
	JSR RUTLEE
;ingresamos la fuente
    JSR INGRESOFUENTE
;cargamos el archivo a memoria

    LDX SISTEMA+2
    INX
    STX SISTEMA+2
;mostramos los datos en pantalla

ARCHIVO03
;archivo03
;ingresamos el primer titulo
    JSR LIMPIOTITULO03
    LDX # <TITULO05
	LDY # >TITULO05
	STX PCRSR
	STY PCRSR+1
	JSR RUTLEE
;ingresamos el segundo titulo
    LDX # <TITULO06
	LDY # >TITULO06
	STX PCRSR
	STY PCRSR+1
	JSR RUTLEE
;ingresamos la fuente
    JSR INGRESOFUENTE
;cargamos el archivo a memoria

    LDX SISTEMA+2
    INX
    STX SISTEMA+2
;mostramos los datos en pantalla



GRABACION 
    LDX SISTEMA+2
    CPX #0
    BNE SIGRABACION
    JMP START
SIGRABACION
    LDA #$40
    STA 710
    STA 712
;comenzamos la grabación
;archivo01
;copiamos los titulos
;cargamos los bytes
;cargamos el bloque
;comenzamos la grabacion

;validamos si existe un segundo archivo o terminamos grabacion
;archivo02
;copiamos los titulos
;cargamos los bytes
;cargamos el bloque
;comenzamos la grabacion

;validamos si existe un tercer archivo o terminamos grabacion
;archivo03
;copiamos los titulos
;cargamos los bytes
;cargamos el bloque
;comenzamos la grabacion

    JMP *
INICIO
    JSR CLOSE
	JSR KEM			;COPIO LA ROM A LA RAM
	LDX # <@START
	LDY # >@START
	LDA #$03
	STX $02
	STY $03
	STA $09
	LDY #$FF
	STY $08
	INY   
	STY $0244
    LDX #$00
    STX SISTEMA
    STX SISTEMA+1
    JSR RESETER
    JMP START 

;rutina tecla option para cambiar el sistema
.proc VBI
    LDA CONSOL
    CMP CONSOL_ANTERIOR
    BEQ FIN
    STA CONSOL_ANTERIOR
    CMP #$05    ;select
    BEQ ESSELECT
    CMP #$03    ;option
    BNE FIN
;es option
ESOPTION
    LDX SISTEMA
    CPX #4
    BNE ESOPTION02
    LDX #$ff
ESOPTION02
    INX
    STX SISTEMA
    LDA #<VEONHP
    LDY #>VEONHP
    CPX #$00
    BEQ ESOPTION03
    LDA #<VEONHP8
    LDY #>VEONHP8
    CPX #$01
    BEQ ESOPTION03
    LDA #<VEOSTAC
    LDY #>VEOSTAC
    CPX #$02
    BEQ ESOPTION03
    LDA #<VEOULTRA
    LDY #>VEOULTRA
    CPX #$03
    BEQ ESOPTION03
    LDA #<VEOSUPER
    LDY #>VEOSUPER
ESOPTION03
    STA LOOP_COPIA+1
    STY LOOP_COPIA+2
    LDY #$04
LOOP_COPIA
    LDA VEONHP,y
    STA MUESTROSISTEMA,y
    DEY
    BPL LOOP_COPIA
    JMP FIN
ESSELECT
    LDX SISTEMA+1
    CPX #01
    BNE ESSELECT02
    LDX #$ff
ESSELECT02
    INX
    STX SISTEMA+1
    LDA #<VEOAUDIOON
    LDY #>VEOAUDIOON
    CPX #$00
    BEQ ESSELECT03
    LDA #<VEOAUDIOOFF 
    LDY #>VEOAUDIOOFF
ESSELECT03
    STA LOOP_COPIA_SEL+1
    STY LOOP_COPIA_SEL+2
    LDY #$02
LOOP_COPIA_SEL
    LDA VEOAUDIOON,y
    STA MUESTROAUDIO,y
    DEY
    BPL LOOP_COPIA_SEL
FIN
    JMP $E462
CONSOL_ANTERIOR
    .BY $00
.end
    RUN INICIO
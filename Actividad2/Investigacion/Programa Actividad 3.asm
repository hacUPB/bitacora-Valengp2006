(LOOP)
    @KBD
    D=M        // Leer tecla presionada
    @NO_KEY
    D;JEQ      // Si no hay tecla presionada, ir a NO_KEY

    @100
    D=D-A      // Comparar tecla con ASCII 100 ('d')
    @DRAW
    D;JEQ      // Si es igual, ir a rutina de dibujo

    @CLEAR
    0;JMP      // Si no es 'd', ir a limpiar pantalla

(NO_KEY)
    @LOOP
    0;JMP      // Volver al inicio


// SUBRUTINA PARA BORRAR PANTALLA (LIMPIAR SCREEN)
(CLEAR)
    @R0
    M=0           // Contador en R0
(CLEAR_LOOP)
    @R0
    D=M
    @8192         // SCREEN tiene 8192 palabras (32*256 bits)
    D=D-A
    @AFTER_CLEAR
    D;JGE

    @SCREEN
    A=A+R0        // Dirección actual en SCREEN
    M=0           // Limpiar pixel

    @R0
    M=M+1         // Incrementar contador
    @CLEAR_LOOP
    0;JMP

(AFTER_CLEAR)
    @LOOP
    0;JMP         // Volver al inicio


// SUBRUTINA PARA MOSTRAR EL DIBUJO DEL GATO
(DRAW)

   @SCREEN
	D=A
	@R12
	AD=D+M
	// row 5
	@260 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 6
	D=A // D holds previous addr
	@32
	AD=D+A
	@396 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 7
	D=A // D holds previous addr
	@32
	AD=D+A
	@508 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 8
	D=A // D holds previous addr
	@32
	AD=D+A
	@1022 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 9
	D=A // D holds previous addr
	@32
	AD=D+A
	@1022 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 10
	D=A // D holds previous addr
	@32
	AD=D+A
	@508 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 11
	D=A // D holds previous addr
	@32
	AD=D+A
	@248 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 12
	D=A // D holds previous addr
	@32
	AD=D+A
	@508 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 13
	D=A // D holds previous addr
	@32
	AD=D+A
	@1022 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 14
	D=A // D holds previous addr
	@32
	AD=D+A
	@1022 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 15
	D=A // D holds previous addr
	@32
	AD=D+A
	@2047 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 16
	D=A // D holds previous addr
	@32
	AD=D+A
	@2047 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 17
	D=A // D holds previous addr
	@32
	AD=D+A
	@1022 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 18
	D=A // D holds previous addr
	@32
	AD=D+A
	@508 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 19
	D=A // D holds previous addr
	@32
	AD=D+A
	@248 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 20
	D=A // D holds previous addr
	@32
	AD=D+A
	@96 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 21
	D=A // D holds previous addr
	@32
	AD=D+A
	@96 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 22
	D=A // D holds previous addr
	@32
	AD=D+A
	@96 // A holds val
	D=D+A // D = addr + val
	A=D-A 
	M=D-A 

	D=A 
	@32
	AD=D+A
	@32 
	D=D+A 
	A=D-A 
	M=D-A 
	
	D=A 
	@32
	AD=D+A
	@48 
	D=D+A 
	A=D-A 
	M=D-A 
	
	D=A 
	@32
	AD=D+A
	@48
	D=D+A 
	A=D-A 
	M=D-A 
	
	D=A 
	@32
	AD=D+A
	@16 
	D=D+A 
	A=D-A 
	
	D=A 
	@32
	AD=D+A
	@48 
	D=D+A
	A=D-A 
	M=D-A
	
	D=A 
	@32
	AD=D+A
	@96 
	D=D+A 
	A=D-A 
	M=D-A 

	@R13
	A=M
	D;JMP

    @LOOP 
    0;JMP
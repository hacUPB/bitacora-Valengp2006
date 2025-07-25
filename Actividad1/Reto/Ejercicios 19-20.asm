//19. Analiza el siguiente programa en lenguaje de máquina:
    
    0100000000000000
    1110110000010000
    0000000000010000
    1110001100001000
    0110000000000000
    1111110000010000
    0000000000010011
    1110001100000101
    0000000000010000
    1111110000010000
    0100000000000000
    1110010011010000
    0000000000000100
    1110001100000110
    0000000000010000
    1111110010101000
    1110101010001000
    0000000000000100
    1110101010000111
    0000000000010000
    1111110000010000
    0110000000000000
    1110010011010000
    0000000000000100
    1110001100000011
    0000000000010000
    1111110000100000
    1110111010001000
    0000000000010000
    1111110111001000
    0000000000000100
    1110101010000111
    
    //- ¿Qué hace este programa?
    //Este programa pinta en pantalla (a partir de la dirección 16384) mientras no se presione ninguna tecla. Cuando se presiona una tecla, salta a una rutina alterna que intenta modificar datos, pero no realiza un borrado efectivo. El programa sigue ejecutándose en bucle.

    //20. Implementa un programa en lenguaje ensamblador que dibuje el bitmap que diseñaste en la pantalla solo si se presiona la tecla “d”.
# UNP
# uC1_2022_montalban_carlos

Curso: Microcontroladores I

Autor: Montalban Coronado Carlos Raúl

Tarjeta: Curiosity Nano PIC18F57Q84

Entorno: MPLAB X IDE

Lenguaje: AMS - C

UNIVERSIDAD NACIONAL DE PIURA, PERU

# Practicas:
1. P1-Corrimiento_Leds:
    Corrimiento de izquierda a derecha de leds conectados al puerto C, con retardos de 250ms para corrimientos impares y retados de 500ms para pares
2. P2-Display_7SEG:
    Te muestra en un display anodo comun un conteo alfanumerico de 0-9 y A-F
3. Retardos.inc:
    Es un include que contiene la estructura de retardos de 10us, 25us, 50us, 100us, 200us, 250us, 500us, 1ms, 5ms, 10ms, 25ms, 50ms, 100ms, 200ms y 250ms
4. EXAMEN_PARCIAL2.X:
    - Ejercio 2:
    El programa remapea INT0 a RA3, INT1 a RB4 e INT2  a RF2. En este programa, mientras no se realice ninguna interrupcion Se ejecutara el programa principal es cual es     un toggle del led de la placa cada 500 ms. Cuando se reliza le INT0 de baja prioridad, es decir se presiona el button del uC,  Comienza la secuencia de leds del         puerto C. Esta secuencia se detiene si se reliza la INT1 (Si se presiona el button externo RB4) de alta prioridad o hasta que el numero de repeticiones sea 5. Cuando     se lleva a cabo la INT2, es decir se presiona el button externo de RF2 se reinicia toda la secuencia y se apagan los leds. La frecuencia del Oscilador es de 4MHz

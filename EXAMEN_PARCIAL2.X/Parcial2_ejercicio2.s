;---------------------------------------------------------------------------------------------------------------------------------
;@file	    Parcial2_ejercicio2.s
;@brief	    El programa remapea INT0 a RA3, INT1 a RB4 e INT2  a RF2. En este programa, mientras no se 
;	    realice ninguna interrupcion Se ejecutara el programa principal es cual es un toggle del led 
;	    de la placa cada 500 ms. Cuando se reliza le INT0 de baja prioridad, es decir se presiona el 
;	    button del uC,  Comienza la secuencia de leds del puerto C. Esta secuencia se detiene si se 
;	    reliza la INT1 (Si se presiona el button externo RB4) de alta prioridad o hasta que el numero 
;	    de repeticiones sea 5. Cuando se lleva a cabo la INT2, es decir se presiona el button externo 
;	    de RF2 se reinicia toda la secuencia y se apagan los leds. La frecuencia del Oscilador es de 4MHz
;@date	    30/01/23
;@author    Montalban Coronado Carlos Raúl
;----------------------------------------------------------------------------------------------------------------------------------      
PROCESSOR 18F57Q84
#include "Bit_config.inc"   ;/config statements should precede project file includes./
#include <xc.inc>
#include "delays_ms.inc"

PSECT udata_acs			    ;PSECT para utilizar el Access RAM
offset:		DS	1	    ;Reserva (DS) un byte en Access RAM -> Indica el offset que se ejecutara en la table
counter:	DS	1	    ;Reserva (DS) un byte en Access RAM -> Indica el numero de offsets que se mostraran
rep_5:		DS	1	    ;Reserva (DS) un byte en Access RAM -> Indica que numero de veces que se repite la secuencia
stop1_int1:	DS	1	    ;Reserva (DS) un byte en Access RAM -> Sirve para detener o resetar la secuencia
Muestreo_Led:	DS	1	    ;Reserva (DS) un byte en Access RAM -> Mostrara el valor en que se quedo la secuencia

    
PSECT resetVect,class=CODE,reloc=2  
resetVect:
    GOTO Main  
    
;Codigo de INT0 -->Prioridad baja:
PSECT ISRVectlowpriority,class=CODE,reloc=2	
ISRVectlowpriority:
    MOVLW   0x00		;(W) = 00
    MOVWF   stop1_int1,0	;(stop1_int1) = 00
    MOVLW   0x05		;(W) = 05
    MOVWF   rep_5,0		;(rep_5)=05
    BTFSS   PIR1,0,0		;Consulta si se produce la INT0
    GOTO    Exit		;Si no se produce va a Exit y termina la Int0
    GOTO    Reload		;Si la Int0 se produce salta a Reload e inicia el encendido de leds      
Exit:    
    RETFIE			;Retorno de interrupcion Int0 
        
PSECT ISRVecthighpriority,class=CODE,reloc=2  ;Codigo INT1, INT2 --> Alta prioridad
ISRVecthighpriority:
    BTFSC   PIR6,0,0		;Consulta si se produce la INT1
    GOTO    Parar_leds		;Si se produce salta a Parar_leds
    
    ;Instrucciones --> INT2
Borrar_leds:			;Si no se produce la INT1 salta BTFSC
    BTFSC   PIR10,0,0		;Consulta si se produce la INT2		
    BCF	    PIR10,0,0		;Limpiamos el flag
    CLRF    LATC,1		;Apagamos todos los leds del puerto C
    SETF    stop1_int1,0	;Hago (stop1_int1)=1 para que termine INT0
Exit_Int12:
    RETFIE			;Retorno de interrupcion Int2

    
    
    
;Sector de codigo principal:
PSECT CODE  
Main:
    ;Salto a Subrutinas y configuracion del OSC, PORT, PPS e INTX
    CAll    Config_OSC,1	;Configuracion de Oscilador de 4MHz
    CALL    Config_PORT,1	;Configuracion de RF3, RF2, RA3, PORTC, RB4
    CALL    Config_PPS,1	;Remapeo de INT0, INT1, INT2
    CALL    Config_INTX,1	;Configuracion de Interrupciones

Led_uc:
    ;Programa principal
    CALL    delay_250ms		;Retardo
    CALL    delay_250ms		;Retardo
    BSF	    LATF,3,0		;Led de uC Apagado 
    CALL    delay_250ms		;Retardo
    CALL    delay_250ms		;Retardo
    BCF	    LATF,3,0		;Led de uC encendido
    GOTO    Led_uc		;Salta a Led_uc haciendo que se repita el encendido y pagado del led con retardo de 500ms

 
    
    
    
;Inicio de encendido y apagado de 250ms en los leds --> INT0
Reload:				
    BCF	    PIR1,0,0		;Limpiamos el falg
    MOVLW   0x0A		;Definimos el counter 
    MOVWF   counter,0		;Counter = 0x0A -> Mostrara los 10 valores de Table
    MOVLW   0x00		;Definimos el offset
    MOVWF   offset,0		;offset = 0x00 -> Mostrara desde el primer valor de Table
    GOTO    Loop		;Salto a Loop   
Loop:   
    BANKSEL PCLATU		
    MOVLW   low highword(Table)	;Toma el LSB (PCU) del MSB del PC
    MOVWF   PCLATU,1		;Registro PCLATU
    MOVLW   high(Table)		;Toma el MSB (PCH)  del LSM del PC
    MOVWF   PCLATH,1		;Registro PCLATH
    RLNCF   offset,0,0		;(offset) x 2 = 0 x 2 = 0 , el w significa que se guarde en el acumulador
    CALL    Table		;Salto a Table
    BTFSC   stop1_int1,1,0	;Salta y ejecuta la siguiente instruccion si stop1_int1 es cero 
    GOTO    Exit		;cuando stop1_int1 finaliza la INT0
    MOVWF   LATC,0		;Cargo el valor de la tabla a todo el puerto C
    MOVWF   Muestreo_Led,0	;Cargo el valor de la tabla al Muestreo_Led para que me guarde el valor
    CALL    delay_250ms		;Retardo de 250ms entre encendido y apagado de los leds del puerto C
    DECFSZ  counter,1,0		;Si (counter) - 1 = 0 , Salta y ejecuta la siguiente instruccion
    GOTO    Nex_seq		;Si el (Counter) no es cero ejecuta el siguiente offset
    GOTO    SEC_5		;Si el (Counter) es cero Salta a SEC_5 y ejecuta otra vez todos los offset
SEC_5:
    DECFSZ  rep_5,1,0		;si (rep_5) - 1 = 0 , Salta a Exti
    GOTO    Reload		;Si (rep_5) no es cero salta a Reload y carga de nuevo los valores para que inicie otra vez la secuencia de leds
    GOTO    Exit		;Fin de INT0  
Nex_seq:			;Ejecuta el siguiente offset de Table
    INCF    offset,1,0		;Incrementa el offset en 1 y lo guarda en el mismo offset
    GOTO    Loop		;Salta y ejecuta de nuevo el Loop con el nuevo valor del offset    
Table:
    ;Tabla de corrimiento de leds
    ADDWF   PCL,1,0		;(w) + PCL  = (offset) + PCL
    RETLW   10000001B		;offset: 0
    RETLW   01000010B		;offset: 1
    RETLW   00100100B		;offset: 2
    RETLW   00011000B		;offset: 3
    RETLW   00000000B		;offset: 4
    RETLW   00011000B		;offset: 5
    RETLW   00100100B		;offset: 6
    RETLW   01000010B		;offset: 7
    RETLW   10000001B		;offset: 8
    RETLW   00000000B		;offset: 9
    RETURN			;Retorno
    
    
    
    
    
;Instrucciones de INT1
Parar_leds:			;Con el button en RB4 detenies la secuencia de leds
    BCF	    PIR6,0,0		;Limpiamos el falg
    MOVF    Muestreo_Led,0,0	;Hacemos que lo que tenemos en "Muestreo_Led" se argue en el w
    MOVWF   LATC,1		;Mostramos el valor en que se quedo la secuencia de leds
    SETF    stop1_int1,0	;hacemos (stop1_int1)=1 para que termine la INT0
    GOTO    Exit_Int12		;Salto a Exit_Int12



     
    
;Subrutinas
Config_OSC:			;Configuracion del Oscilador
    BANKSEL OSCCON1		;genera el codigo necesario para ubicarme en el banco de cierto registro
    MOVLW   0x60		;(w) = 0x60
    MOVWF   OSCCON1,1		;seleccionamos el bloque del OSC interno con 1 divisor
    MOVLW   0x02		;(w) = 0x02
    MOVWF   OSCFRQ,1		;seleccionamos frecuencia de clock = 4MHz 
    RETURN			;Retorno
    
Config_PORT:			;Configuramos los puertos del uC -> PORT-LAT-ANSEL-TRIS
    ;Configuracion de led de uC -> RF3
    BANKSEL PORTF		
    BCF	    PORTF,3,1		;PORTF<3> = 0 , Mostrara el led del uC encendido 
    BSF	    LATF,3,1		;LATC<3>  = 1 , Estado inicial de Led -> OFF
    CLRF    ANSELF,1		;Puerto -> digital
    BCF	    TRISF,3,1		;Puerto -> salida
    ;Configuracion de button RF2
    BCF	    PORTF,2,1		;PORTF<2> = 0 , Mostrara Cuando se presione el button externo
    BSF	    TRISF,2,1		;Puerto -> entrada
    BSF	    WPUF,2,1		;Activo resistencia Pull Up del pin RF2
    
    ;Configuracion del puertos C como salida (Secuencia de Leds)
    ;RC0=LED1, RC1=LED2, RC2=LED3, RC3=LED4, RC4=LED5, RC5=LED6, RC6=LED7, RC7=LED8
    BANKSEL PORTC	
    SETF    PORTC,1		;PORTC<7:0> = 1 , Me mostrara los LEDS ON
    CLRF    LATC,1		;LATC<7:0>  = 0	, Estado inicial de LEDS -> OFF
    CLRF    ANSELC,1		;Puerto -> digital
    CLRF    TRISC,1		;Puerto -> salida
    
    ;Configuracion de button del uC
    BANKSEL PORTA	
    BCF	    PORTA,3,1		;EL LAT ya no se pone porque no escribire nada, PORTA<7:0> = 0
    CLRF    ANSELA,1		;ANSELF<7:0>  -> puerto A es digital
    BSF	    TRISA,3,1		;Configuramos el pin RA3 como entrada ya que pulsaremos el button
    BSF	    WPUA,3,1		;Activamos la resistencia Pull Up del pin RA3
    
    ;Configuracion de button RB4
    BANKSEL PORTB
    BCF	    PORTB,4,1		;PORTC<4> = 0 , Mostrara Cuando se presione el button externo
    BCF	    ANSELB,4,1		;Puerto -> digital
    BSF     TRISB,4,1		;Puerto -> Entrada 
    BSF	    WPUB,4,1		;Activamos la resistencia Pull Up del pin RB4
    RETURN			;Retorno
       
Config_PPS:
    BANKSEL INT0PPS
    MOVLW   0x03		;(w) = 0x03
    MOVWF   INT0PPS,1		;INT0 --> RA3
    
    BANKSEL INT1PPS
    MOVLW   0x0C		;(w) = 0x0C
    MOVWF   INT1PPS,1		;INT1 --> RB4
    
    BANKSEL INT2PPS
    MOVLW   0x2A		;(w) = 0x2A
    MOVWF   INT2PPS,1		;INT2 --> RF2
    RETURN			;Retorno
    
    
Config_INTX:
;   Secuencia para configurar interrupcion:
;    1. Definir prioridades
;    2. Configurar interrupcion
;    3. Limpiar el flag
;    4. Habilitar la interrupcion
;    5. Habilitar las interrupciones globales
    
    BSF	    INTCON0,5,0		;INTCON0<IPEN> = 1 --> Habilitar prioridades
    BANKSEL IPR1
    BCF	    IPR1,0,1		;IPR1<INT0IP> = 0 --> INT0 de baja prioridad
    BSF	    IPR6,0,1		;IPR6<INT1IP> = 1 --> INT1 de alta prioridad
    BSF	    IPR10,0,1		;IPR10<INT2IP> = 1 --> INT2 de alta prioridad
    
   ;Config. INT0
    BCF	INTCON0,0,0		;INTCON0<INT0EDG> = 0 --> INT0 por flanco de bajada
    BCF	PIR1,0,0		;PIR1<INT0IF> = 0 --> limpiamos el flag de interrupcion
    BSF	PIE1,0,0		;PIE1<INT0IE> = 1 --> habilitamos la interrupcion ext0
    
   ;Config. INT1
    BCF	INTCON0,1,0		;INTCON0<INT1EDG> = 0 --> INT0 por flanco de bajada
    BCF	PIR6,0,0		;PIR6<INT1IF> = 0 --> limpiamos el flag de interrupcion
    BSF	PIE6,0,0		;PIE6<INT1IE> = 1 --> habilitamos la interrupcion ext1
   
   ;Config. INT2
    BCF	INTCON0,2,0		;INTCON0<INT2EDG> = 0 --> INT0 por flanco de bajada
    BCF	PIR10,0,0		;PIR10<INT2IF> = 0 --> limpiamos el flag de interrupcion
    BSF	PIE10,0,0		;PIE10<INT2IE> = 1 --> habilitamos la interrupcion ext2
    
   ;Config. GLOBAL
    BSF	INTCON0,7,0		;INTCON0<GIE/GIEH> = 1 --> habilitamos las interrupciones de forma global
    BSF	INTCON0,6,0		;INTCON0<GIEL> = 1 --> habilitamos las interrupciones de baja prioridad
    RETURN			;Retorno


END resetVect




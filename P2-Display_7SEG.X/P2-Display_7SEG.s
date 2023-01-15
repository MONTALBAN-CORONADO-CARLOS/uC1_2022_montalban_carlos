;------------------------------------------------------------------------------
;@file	    P2-Display_7SEG.s
;@brief	    En este proyecto hace un coteo del 0-9 Si el botón de la placa no esta presionado, pero si el boton
;	    se mantiene presionado entonces hace un contro de A-F
;@date	    15/01/23
;@author    Montalban Coronado Carlos Raúl
;------------------------------------------------------------------------------
   
PROCESSOR 18F57Q84
#include "Bit_config.inc"   /*config statements should precede project file includes.*/
#include <xc.inc>
#include "delay_250ms.inc"
PSECT resetVect,class=CODE,reloc=2
resetVect:
    goto Main
    
PSECT CODE
Main:
    CALL Config_OSC,1	    ;Salto a la Configuracion del oscilador y guarda los valores anteriores
    CALL Config_Port,1	    ;Salto a la configuracion de puertos del PIC18F57Q84 y guarda los valores anteriores
    
Loop_conteo:
    BTFSS   PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un uno(button sin presionar)
    GOTO    Display_A
Display_cero:		    ;Conteo decimal -> 0-9
    CALL    delay_250ms	    ;Retardo de 250 ms
    MOVLW   00000011B	    ;(w) = 00000011B
    MOVWF   LATD,1	    ;Mostrará cero en el display
    CALL    delay_250ms
    CALL    delay_250ms
    CALL    delay_250ms
    BTFSC   PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un cero(button presionado)
    GOTO    Display_uno	    ;Salto a Display_uno
    GOTO    Display_A	    ;Salto a Display_A
Display_uno:
    CALL    delay_250ms
    MOVLW   10011111B	    ;(w)=10011111B
    MOVWF   LATD,1	    ;Mostrara el 1 en el display
    CALL    delay_250ms
    CALL    delay_250ms
    CALL    delay_250ms
    BTFSC   PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un cero(button presionado)
    GOTO    Display_dos	    ;Salto a Display_dos    
    GOTO    Display_A	    ;Salto a Display_A
Display_dos:
    CALL    delay_250ms
    MOVLW   00100101B	    ;(w)=00100101B
    MOVWF   LATD,1	    ;Mostrara el 2 en el display
    CALL    delay_250ms
    CALL    delay_250ms
    CALL    delay_250ms
    BTFSC   PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un cero(button presionado)
    GOTO    Display_tres    ;Salto a Display_tres
    GOTO    Display_A	    ;Salto a Display_A
Display_tres:
    CALL    delay_250ms
    MOVLW   00001101B	    ;(w)=00001101B
    MOVWF   LATD,1	    ;Mostrara el 3 en el display
    CALL    delay_250ms
    CALL    delay_250ms
    CALL    delay_250ms
    BTFSC   PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un cero(button presionado)
    GOTO    Display_cuatro  ;Salto a  Display_cuatro
    GOTO    Display_A	    ;Salto a Display_A
Display_cuatro:
    CALL    delay_250ms
    MOVLW   10011001B	    ;(w)=10011001B
    MOVWF   LATD,1	    ;Mostrara el 4 en el display
    CALL    delay_250ms
    CALL    delay_250ms
    CALL    delay_250ms
    BTFSC   PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un cero(button presionado)
    GOTO    Display_cinco   ;Salto a  Display_cinco
    GOTO    Display_A	    ;Salto a  Display_A
Display_cinco:
    CALL    delay_250ms
    MOVLW   01001001B	    ;(w)=01001001B
    MOVWF   LATD,1	    ;Mostrara el cinco en el dispay
    CALL    delay_250ms
    CALL    delay_250ms
    CALL    delay_250ms
    BTFSC   PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un cero(button presionado)
    GOTO    Display_seis    ;salto a Display_seis 
    GOTO    Display_A	    ;Salto a Display_A
Display_seis:
    CALL    delay_250ms
    MOVLW   01000001B	    ;(w)=01000001B
    MOVWF   LATD,1	    ;Mostrara el seis en el dispay
    CALL    delay_250ms
    CALL    delay_250ms
    CALL    delay_250ms
    BTFSC   PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un cero(button presionado)
    GOTO    Display_siete   ;Salta a
    GOTO    Display_A	    ;Salta a
Display_siete:
    CALL    delay_250ms
    MOVLW   00011111B	    ;(w)=00011111B
    MOVWF   LATD,1	    ;Mostrara el siete en el dispay
    CALL    delay_250ms
    CALL    delay_250ms
    CALL    delay_250ms
    BTFSC   PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un cero(button presionado)
    GOTO    Display_ocho    ;Salta a Display_ocho
    GOTO    Display_A	    ;Salta a Display_A
Display_ocho:
    CALL    delay_250ms
    MOVLW   00000001B	    ;(w)=00000001B
    MOVWF   LATD,1	    ;Mostrara el ocho en el dispay
    CALL    delay_250ms
    CALL    delay_250ms
    CALL    delay_250ms
    BTFSC   PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un cero(button presionado)
    GOTO    Display_nueve   ;Salta a Display_nueve
    GOTO    Display_A	    ;Salta a Display_A
Display_nueve:
    CALL    delay_250ms
    MOVLW   00011001B	    ;(w)=00011001B
    MOVWF   LATD,1	    ;Mostrara el nueve en el dispay
    CALL    delay_250ms
    CALL    delay_250ms
    CALL    delay_250ms
    BTFSC   PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un cero(button presionado)
    GOTO    Display_cero    ;Salta a Display_cero
    GOTO    Display_A	    ;Salta a Display_A
    
Display_A:		    ;Conteo A-F
    CALL    delay_250ms
    MOVLW   00010001B	    ;(w)=00010001B
    MOVWF   LATD,1	    ;Mostrara el A en el dispay
    CALL    delay_250ms
    CALL    delay_250ms
    CALL    delay_250ms
    BTFSS   PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un uno(button sin presionar)
    GOTO    Display_B	    ;Salta a Display_B
    GOTO    Display_cero    ;Salta a Display_cero
Display_B:
    CALL    delay_250ms
    MOVLW   11000001B	    ;(w)=11000001B
    MOVWF   LATD,1	    ;Mostrara el B en el dispay
    CALL    delay_250ms
    CALL    delay_250ms
    CALL    delay_250ms
    BTFSS   PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un uno(button sin presionar)	    	    
    GOTO    Display_C	    ;Salta a Display_C
    GOTO    Display_cero    ;Salta a Display_cero
Display_C:
    CALL    delay_250ms
    MOVLW   01100011B	    ;(w)=01100011B
    MOVWF   LATD,1	    ;Mostrara el C en el dispay
    CALL    delay_250ms
    CALL    delay_250ms
    CALL    delay_250ms
    BTFSS   PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un uno(button sin presionar)
    GOTO    Display_D	    ;Salta a Display_D
    GOTO    Display_cero    ;Salta a Display_cero
Display_D:
    CALL    delay_250ms
    MOVLW   10000101B	    ;(w)=10000101B
    MOVWF   LATD,1	    ;Mostrara el D en el dispay
    CALL    delay_250ms
    CALL    delay_250ms
    CALL    delay_250ms
    BTFSS   PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un uno(button sin presionar)
    GOTO    Display_E	    ;Salta a Display_E
    GOTO    Display_cero    ;Salta a Display_cero
Display_E:
    CALL    delay_250ms
    MOVLW   01100001B	    ;(w)=01100001B
    MOVWF   LATD,1	    ;Mostrara el E en el dispay
    CALL    delay_250ms
    CALL    delay_250ms
    CALL    delay_250ms
    BTFSS   PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un uno(button sin presionar)
    GOTO    Display_F	    ;Salta a Display_F
    GOTO    Display_cero    ;Salta a Display_cero
Display_F:
    CALL    delay_250ms
    MOVLW   01110001B	    ;(w)=01110001B
    MOVWF   LATD,1	    ;Mostrara el F en el dispay
    CALL    delay_250ms
    CALL    delay_250ms
    CALL    delay_250ms
    BTFSS   PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un uno(button sin presionar)
    GOTO    Display_A	    ;Salta a Display_A
    GOTO    Display_cero    ;Salta a Display_cero
    
    
    
    
;SUBRUTINAS:
Config_OSC:		;Configuramos el oscilador interno a una frecuencia de 4MHz
    BANKSEL OSCCON1
    MOVLW   0x60	;seleccionamos el bloque del oscilador interno(HFINTOSC) con un div:1
    MOVWF   OSCCON1,1	;cargo el valor al registro OSCCON1
    MOVLW   0x02	;(w)=02h
    MOVWF   OSCFRQ,1	;Seleccionamos la frecuenta del Oscilador(4MHz)
    RETURN
    
Config_Port:		;Configuramos los puertos del uC -> PORT-LAT-ANSEL-TRIS
    
    ;Configuracion del puerto D como salida
    ;Relacion pines del display y Puerto D:
    ;RD7=a , RD6=b, RD5=c, RD4=d, RD3=e ,RD2=f , RD1=g, RD0=punto decimal 
    BANKSEL PORTD	;En este uC port,lat,ansel y tris estan en un mismo banco
    CLRF    PORTD,1	;PORTC<7:0> = 0 , Me mostrara los LEDS del display ON
    SETF    LATD,1	;LATC<7:0>  = 1	, Estado inicial de LEDS del display -> OFF
    CLRF    ANSELD,1	;Puerto ->   digital
    CLRF    TRISD,1	;Puerto ->  salida
    
    ;Configuracion del button -> PIN RA3:
    BANKSEL PORTA
    CLRF    PORTA,1	;EL LAT ya no se pone porque no escribire nada, PORTA<7:0> = 0
    CLRF    ANSELA,1	;ANSELF<7:0>  -> puerto A es digital
    BSF	    TRISA,3,1	;Configuramos el pin RA3 como entrada ya que pulsaremos el button
    BSF	    WPUA,3,1	;Activamos la resistencia Pull Up del pin RA3
    RETURN		;Retorno a Loop_conteo
        
    
      
END resetVect





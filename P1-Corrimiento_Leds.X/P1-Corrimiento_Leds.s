;------------------------------------------------------------------------------
;@file	    P1-Corrimiento_Leds.s
;@brief	    En este proyecto Se realiza un corrimiento de izquierda a derecha de leds conectados al puerto C del uC con un retardo 
;	    de 500 ms en corrimientos pares y 250 ms en corrimientos impares teniendo encuenta que al presionar 
;	    el button del uC el corrimiento incia y se detiene cuando se vuelve a presinar el button
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
Loop_Button:
    BTFSC PORTA,3,0	    ;Si hay un cero en el RA3 salta la siguiente instruccion (Button presionado)
    GOTO  Loop_Button	    ;Salto a Loop_Button, es decir aun no inicia el corrimiento
RUN_LED1:		    ;Inicio de corrimiento de leds impar con retardo de 250ms
    MOVLW  00000000B	    ;(w)=00000000B
    MOVWF   LATE,1	    ;PORTE<7:0> = 0 , Apago los leds que indican el corrimiento par o impar
    MOVLW  00000001B	    ;(w)=00000001B
    MOVWF   LATE,1	    ;REO = 1 , Prendo el led del  corrimiento impar
    BCF	  LATC,7,1	    ;RC7 = 0
    BSF	  LATC,0,1	    ;RC0 = 1 -> Prende el primer led
    CALL delay_250ms
    BTFSC PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un cero(button presionado)
    GOTO RUN_LED2
STOP_LED1:
    CALL delay_250ms
    BTFSC PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un cero(button presionado)
    GOTO  STOP_LED1     
RUN_LED2:
    BCF	  LATC,0,1	    ;RCO = 0 , apago el primer led
    BSF	  LATC,1,1	    ;RC1 = 1 , Prende el segundo led
    CALL delay_250ms
    BTFSC PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un cero(button presionado)
    GOTO RUN_LED3
STOP_LED2:
    CALL delay_250ms
    BTFSC PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un cero(button presionado)
    GOTO  STOP_LED2   
RUN_LED3:
    BCF	  LATC,1,1	    ;RC1 = 1 , apago el segundo led
    BSF	  LATC,2,1	    ;RC2 = 1 , Prende el tercer led
    CALL delay_250ms
    BTFSC PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un cero(button presionado)
    GOTO RUN_LED4
STOP_LED3:
    CALL delay_250ms
    BTFSC PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un cero(button presionado)
    GOTO  STOP_LED3   
RUN_LED4:
    BCF	  LATC,2,1	    ;RC2 = 0 , apago el tercer led
    BSF	  LATC,3,1	    ;RC3 = 1 , Prende el cuarto led
    CALL delay_250ms
    BTFSC PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un cero(button presionado)
    GOTO RUN_LED5
STOP_LED4:
    CALL delay_250ms
    BTFSC PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un cero(button presionado)
    GOTO  STOP_LED4 
RUN_LED5:
    BCF	 LATC,3,1	    ;RC3 = 0 , apago el cuarto led
    BSF	  LATC,4,1	    ;RC4 = 1 , Prende el quinto led
    CALL delay_250ms	    
    BTFSC PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un cero(button presionado)
    GOTO RUN_LED6
STOP_LED5:
    CALL delay_250ms
    BTFSC PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un cero(button presionado)
    GOTO  STOP_LED5  
RUN_LED6:
    BCF	 LATC,4,1	    ;RC4 = 0 , apago el quinto led
    BSF	  LATC,5,1	    ;RC5 = 1 , Prende el sexto led
    CALL delay_250ms
    BTFSC PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un cero(button presionado)
    GOTO RUN_LED7
STOP_LED6:
    CALL delay_250ms
    BTFSC PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un cero(button presionado)
    GOTO  STOP_LED6  
RUN_LED7:
    BCF	 LATC,5,1	    ;RC5 = 0 , apago el sexto led
    BSF	  LATC,6,1	    ;RC6 = 1 , Prende el septimo led
    CALL delay_250ms
    BTFSC PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un cero(button presionado)
    GOTO RUN_LED8
STOP_LED7:
    CALL delay_250ms
    BTFSC PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un cero(button presionado)
    GOTO  STOP_LED7 
RUN_LED8:
    BCF	 LATC,6,1	    ;RC6 = 0 , apago el septimo led
    BSF	  LATC,7,1	    ;RC7 = 1 , Prende el octavo led
    CALL delay_250ms
    BTFSC PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un cero(button presionado)
    GOTO RUN_LED1I
STOP_LED8:
    CALL delay_250ms
    BTFSC PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un cero(button presionado)
    GOTO  STOP_LED8
    GOTO RUN_LED1I
   
RUN_LED1I:		    ;Inicio de corrimiento de leds par con retardo de 500ms
    MOVLW  00000000B	    ;(w)=00000000B
    MOVWF   LATE,1	    ;PORTE<7:0> = 0 , Apago los leds que indican el corrimiento par o impar
    MOVLW  00000010B	    ;(w)=00000010B
    MOVWF   LATE,1	    ;RE1 = 1 , Prendo el led del  corrimiento par
    BCF	  LATC,7,1	    ;RC7 = 0
    BSF	  LATC,0,1	    ;RC0 = 1 -> Prende el primer led
    CALL delay_250ms
    CALL delay_250ms
    BTFSC PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un cero(button presionado)
    GOTO RUN_LED2I
STOP_LED1I:
    CALL delay_250ms
    BTFSC PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un cero(button presionado)
    GOTO  STOP_LED1I     
RUN_LED2I:
    BCF	  LATC,0,1	    ;RCO = 0 , apago el primer led
    BSF	  LATC,1,1	    ;RC1 = 1 , Prende el segundo led
    CALL delay_250ms
    CALL delay_250ms
    BTFSC PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un cero(button presionado)
    GOTO RUN_LED3I
STOP_LED2I:
    CALL delay_250ms
    BTFSC PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un cero(button presionado)
    GOTO  STOP_LED2I   
RUN_LED3I:
    BCF	  LATC,1,1	    ;RC1 = 1 , apago el segundo led
    BSF	  LATC,2,1	    ;RC2 = 1 , Prende el tercer led
    CALL delay_250ms
    CALL delay_250ms
    BTFSC PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un cero(button presionado)
    GOTO RUN_LED4I
STOP_LED3I:
    CALL delay_250ms
    BTFSC PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un cero(button presionado)
    GOTO  STOP_LED3I   
RUN_LED4I:
    BCF	  LATC,2,1	    ;RC2 = 0 , apago el tercer led
    BSF	  LATC,3,1	    ;RC3 = 1 , Prende el cuarto led
    CALL delay_250ms
    CALL delay_250ms
    BTFSC PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un cero(button presionado)
    GOTO RUN_LED5I
STOP_LED4I:
    CALL delay_250ms
    BTFSC PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un cero(button presionado)
    GOTO  STOP_LED4I 
RUN_LED5I:
    BCF	 LATC,3,1	    ;RC3 = 0 , apago el cuarto led
    BSF	  LATC,4,1	    ;RC4 = 1 , Prende el quinto led
    CALL delay_250ms
    CALL delay_250ms
    BTFSC PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un cero(button presionado)
    GOTO RUN_LED6I
STOP_LED5I:
    CALL delay_250ms
    BTFSC PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un cero(button presionado)
    GOTO  STOP_LED5I  
RUN_LED6I:
    BCF	 LATC,4,1	    ;RC4 = 0 , apago el quinto led
    BSF	  LATC,5,1	    ;RC5 = 1 , Prende el sexto led
    CALL delay_250ms
    CALL delay_250ms
    BTFSC PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un cero(button presionado)
    GOTO RUN_LED7I
STOP_LED6I:
    CALL delay_250ms
    BTFSC PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un cero(button presionado)
    GOTO  STOP_LED6I  
RUN_LED7I:
    BCF	 LATC,5,1	    ;RC5 = 0 , apago el sexto led
    BSF	  LATC,6,1	    ;RC6 = 1 , Prende el septimo led
    CALL delay_250ms
    CALL delay_250ms
    BTFSC PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un cero(button presionado)
    GOTO RUN_LED8I
STOP_LED7I:
    CALL delay_250ms
    BTFSC PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un cero(button presionado)
    GOTO  STOP_LED7I 
RUN_LED8I:
    BCF	 LATC,6,1	    ;RC6 = 0 , apago el septimo led
    BSF	  LATC,7,1	    ;RC7 = 1 , Prende el octavo led
    CALL delay_250ms
    CALL delay_250ms
    BTFSC PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un cero(button presionado)
    GOTO RUN_LED1	    ;Vuelve al corrimiento Impar
STOP_LED8I:
    CALL delay_250ms
    BTFSC PORTA,3,0	    ;Salta la siguiente instruccion si en el RA3 hay un cero(button presionado)
    GOTO  STOP_LED8I
    GOTO RUN_LED1	    ;Vuelve al corrimiento Impar   
    
       
;SUBRUTINAS:
Config_OSC:		;Configuramos el oscilador interno a una frecuencia de 4MHz
    BANKSEL OSCCON1
    MOVLW   0x60	;seleccionamos el bloque del oscilador interno(HFINTOSC) con un div:1
    MOVWF   OSCCON1,1	;cargo el valor al Osc
    MOVLW   0x02	;(W)=02h
    MOVWF   OSCFRQ,1	;Seleccionamos la frecuenta del Oscilador(4MHz)
    RETURN
    
Config_Port:		;Configuramos los puertos del uC -> PORT-LAT-ANSEL-TRIS
    
    ;Configuracion del puertos C como salida (Leds de corrimiento)
    ;RC0=LED1, RC1=LED2, RC2=LED3, RC3=LED4, RC4=LED5, RC5=LED6, RC6=LED7, RC7=LED8
    BANKSEL PORTC	;En este uC port,lat,ansel y tris estan en un mismo banco
    SETF    PORTC,1	;PORTC<7:0> = 1 , Me mostrara los LEDS ON
    CLRF    LATC,1	;LATC<7:0>  = 0	, Estado inicial de LEDS -> OFF
    CLRF    ANSELC,1	;Puerto ->   digital
    CLRF    TRISC,1	;Puerto -> salida
    
    
    ;Configuracion del puerto E como salida (Leds que indican elc orrimiento par o impar)
    BANKSEL PORTE
    SETF    PORTE,1	;PORTC<7:0> = 1 , Me mostrara los LEDS ON
    CLRF    LATE,1	;LATC<7:0>  = 0	, Estado inicial de LEDS -> OFF
    CLRF    ANSELE,1	;Puerto ->   digital
    CLRF    TRISE,1	;Puerto -> salida
    
    ;Configuracion del button -> PIN RA3:
    BANKSEL PORTA
    CLRF    PORTA,1	;EL LAT ya no se pone porque no escribire nada, PORTA<7:0> = 0
    CLRF    ANSELA,1	;ANSELF<7:0>  -> puerto A es digital
    BSF	    TRISA,3,1	;Configuramos el pin RA3 como entrada ya que pulsaremos el button
    BSF	    WPUA,3,1	;Activamos la resistencia Pull Up del pin RA3
    RETURN
    
END resetVect







;------------------------------------------------------------------------------
;@file	    Retardos_montalbancoronado_carlos.inc
;@ide	    MPLAB X IDE
;Version Ensamblador	v6.05
;@brief	    Este include contiene el codigo de los retardos para us y ms con una
;	    frecuencia de oscilador de 4 MHz
;	    
;@date	    08/01/2023
;@author    Montalban Coronado Carlos Raúl
;------------------------------------------------------------------------------
    
PSECT udata_acs
Contador1: DS 1
Contador2: DS 1
 
PSECT code

;Retardos en us con Oscillador de 4MHZ:
;Tiempo_aprox = (6 + 4*k)us  ---  1Tcy = 1us 
 
delay_10us:		    ;2Tcy -- CALL
    MOVLW   1		    ;1Tcy, (w)=1
    MOVWF   Contador1,0	    ;1Tcy, (Contador1) = 1 = k
int_10us:		    
    NOP			    ;k*Tcy
    DECFSZ  Contador1,1,0   ;(k-1)+ 3Tcy
    GOTO    int_10us	    ;(k-1)*2Tcy
    RETURN		    ;2Tcy
    
delay_25us:		    ;2Tcy -- CALL
    MOVLW   5		    ;1Tcy, (w)=5
    MOVWF   Contador1,0	    ;1Tcy, (Contador1) = 5 = k
int_25us:		    
    NOP			    ;k*Tcy
    DECFSZ  Contador1,1,0   ;(k-1)+ 3Tcy
    GOTO    int_25us	    ;(k-1)*2Tcy
    RETURN		    ;2Tcy
    
delay_50us:		    ;2Tcy -- CALL
    MOVLW   11		    ;1Tcy, (w)=11
    MOVWF   Contador1,0	    ;1Tcy, (Contador1) = 11 = k
int_50us:		    
    NOP			    ;k*Tcy
    DECFSZ  Contador1,1,0   ;(k-1)+ 3Tcy
    GOTO    int_50us	    ;(k-1)*2Tcy
    RETURN		    ;2Tcy
    
delay_100us:		    ;2Tcy -- CALL
    MOVLW   24		    ;1Tcy, (w)=24
    MOVWF   Contador1,0	    ;1Tcy, (Contador1) = 24 = k
int_100us:			    
    NOP			    ;k*Tcy
    DECFSZ  Contador1,1,0   ;(k-1)+ 3Tcy
    GOTO    int_100us	    ;(k-1)*2Tcy
    RETURN		    ;2Tcy
    
delay_200us:		    ;2Tcy -- CALL
    MOVLW   49		    ;1Tcy, (w)=49
    MOVWF   Contador1,0	    ;1Tcy, (Contador1) = 24 = k
int_200us:			   
    NOP			    ;k*Tcy
    DECFSZ  Contador1,1,0   ;(k-1)+ 3Tcy
    GOTO    int_200us	    ;(k-1)*2Tcy
    RETURN		    ;2Tcy
    
delay_250us:		    ;2Tcy -- CALL
    MOVLW   61		    ;1Tcy, (w)=61
    MOVWF   Contador1,0	    ;1Tcy, (Contador1) = 61 = k
int_250us:			    
    NOP			    ;;k*Tcy
    DECFSZ  Contador1,1,0   ;(k-1)+ 3Tcy
    GOTO    int_250us	    ;(k-1)*2Tcy
    RETURN		    ;2Tcy
    
delay_500us:		    ;2Tcy -- CALL
    MOVLW   124		    ;1Tcy, (w)=124
    MOVWF   Contador1,0	    ;1Tcy, (Contador1) = 124 = k
int_500us:			    
    NOP			    ;k*Tcy
    DECFSZ  Contador1,1,0   ;(k-1)+ 3Tcy
    GOTO    int_500us	    ;(k-1)*2Tcy
    RETURN		    ;2Tcy
    
;Retardos en ms con Oscillador de 4MHZ:
;Tiempo_aprox = [(6 + 4*k1)*K2*(10^(-3))]ms  ---  1Tcy = 1us 
    
delay_1ms:
    MOVLW   1		    ;(W) = 1
    MOVWF   Contador2,0	    ;(Contador2) = 1 = K2
ext_1ms_a:		    
    MOVLW   250		    ;(W) = 250
    MOVWF   Contador1,0	    ;(Contador1) = 250 = K1
int_1ms_b:
    NOP			    
    DECFSZ  Contador1,1,0   ;(K1) - 1 --> (d), salta si el resultado del decremento es cero 
    GOTO    int_1ms_b	    ;Salto a etiqueta 
    DECFSZ  Contador2,1,0   ;(K2) - 1 --> (d), salta si el resultado del decremento es cero 
    GOTO    ext_1ms_a	    ;Salto a etiqueta 
    RETURN		    
    
delay_5ms:
    MOVLW   5		    ;(W) = 5
    MOVWF   Contador2,0	    ;(Contador2) = 5 = K2
ext_5ms_a:		
    MOVLW   250		    ;(W) = 250
    MOVWF   Contador1,0	    ;(Contador1) = 250 = K1
int_5ms_b:
    NOP			    
    DECFSZ  Contador1,1,0   ;(K1) - 1 --> (d), salta si el resultado del decremento es cero 
    GOTO    int_5ms_b	    ;Salto a etiqueta
    DECFSZ  Contador2,1,0   ;(K2) - 1 --> (d), salta si el resultado del decremento es cero 
    GOTO    ext_5ms_a	    ;Salto a etiqueta
    RETURN		   
    
delay_10ms:
    MOVLW   10		    ;(W) = 10
    MOVWF   Contador2,0	    ;(Contador2) = 10 = K2
ext_10ms_a:		
    MOVLW   250		    ;(W) = 250
    MOVWF   Contador1,0	    ;(Contador1) = 250 = K1
int_10ms_b:
    NOP			    
    DECFSZ  Contador1,1,0   ;(K1) - 1 --> (d), salta si el resultado del decremento es cero 
    GOTO    int_10ms_b	    ;Salto a etiqueta
    DECFSZ  Contador2,1,0   ;(K2) - 1 --> (d), salta si el resultado del decremento es cero 
    GOTO    ext_10ms_a	    ;Salto a etiqueta
    RETURN		    

delay_25ms:  
    MOVLW   25		    ;(W) = 25
    MOVWF   Contador2,0	    ;(Contador2) = 25 = K2
ext_25ms_a:		
    MOVLW   250		    ;(W) = 250
    MOVWF   Contador1,0	    ;(Contador1) = 250 = K1
int_25ms_b:
    NOP			    
    DECFSZ  Contador1,1,0   ;(K1) - 1 --> (d), salta si el resultado del decremento es cero   
    GOTO    int_25ms_b	    ;Salto a etiqueta  
    DECFSZ  Contador2,1,0   ;(K2) - 1 --> (d), salta si el resultado del decremento es cero 
    GOTO    ext_25ms_a	    ;Salto a etiqueta
    RETURN		    
    
delay_50ms:  
    MOVLW   50		    ;(W) = 50
    MOVWF   Contador2,0	    ;(Contador2) = 50 = K2
ext_50ms_a:		
    MOVLW   250		    ;(W) = 250
    MOVWF   Contador1,0	    ;(Contador1) = 250 = K1
int_50ms_b:
    NOP			   
    DECFSZ  Contador1,1,0   ;(K1) - 1 --> (d), salta si el resultado del decremento es cero   
    GOTO    int_50ms_b	    ;Salto a etiqueta	    
    DECFSZ  Contador2,1,0   ;(K2) - 1 --> (d), salta si el resultado del decremento es cero
    GOTO    ext_50ms_a	    ;Salto a etiqueta 
    RETURN		    

delay_100ms:		    
    MOVLW   100		    ;(W) = 100
    MOVWF   Contador2,0	    ;(Contador2) = 100 = K2
ext_100ms_a:		
    MOVLW   250		    ;(W) = 250
    MOVWF   Contador1,0	    ;(Contador1) = 250 = K1
int_100ms_b:
    NOP			   
    DECFSZ  Contador1,1,0   ;(K1) - 1 --> (d), salta si el resultado del decremento es cero
    GOTO    int_100ms_b	    ;salto a etiqueta   
    DECFSZ  Contador2,1,0   ;(K2) - 1 --> (d), salta si el resultado del decremento es cero
    GOTO    ext_100ms_a	    ;salto a etiqueta
    RETURN		   
    
delay_200ms:  
    MOVLW   200		    ;(W) = 200
    MOVWF   Contador2,0	    ;(Contador2) = 200 = K2 
ext_200ms_a:		
    MOVLW   249		    ;(W) = 249
    MOVWF   Contador1,0	    ;(Contador1) = 249 = K1
int_200ms_b:
    NOP			    
    DECFSZ  Contador1,1,0    ;(K1) - 1 --> (d), salta si el resultado del decremento es cero
    GOTO    int_200ms_b		;salto a etiqueta   
    DECFSZ  Contador2,1,0	;(K2) - 1 --> (d), salta si el resultado del decremento es cero
    GOTO    ext_200ms_a		;salto a etiqueta
    RETURN		   
    
delay_250ms:  
    MOVLW   250		    ;(W) = 250
    MOVWF   Contador2,0	    ;(Contador2) = 200 = K2
ext_250ms_a:		
    MOVLW   249		    ;(W) = 249
    MOVWF   Contador1,0	    ;(Contador1) = 249 = K1
ext_250ms_b:
    NOP			   
    DECFSZ  Contador1,1,0   ;(K1) - 1 --> (d), salta si el resultado del decremento es cero
    GOTO    ext_250ms_b	    ;salto a etiqueta    
    DECFSZ  Contador2,1,0   ;(K2) - 1 --> (d), salta si el resultado del decremento es cero
    GOTO    ext_250ms_a	    ;salto a etiqueta 
    RETURN		    
    




PSECT udata_acs
    Contador1: DS 1
    Contador2: DS 1 

PSECT code


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





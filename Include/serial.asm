
serial_InitTimer0:

;serial.h,18 :: 		static void InitTimer0()
;serial.h,20 :: 		T0CON         = 0x83;
	MOVLW       131
	MOVWF       T0CON+0 
;serial.h,21 :: 		TMR0H         = 0x0B;
	MOVLW       11
	MOVWF       TMR0H+0 
;serial.h,22 :: 		TMR0L         = 0xDC;
	MOVLW       220
	MOVWF       TMR0L+0 
;serial.h,23 :: 		GIE_bit       = 1;
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;serial.h,24 :: 		TMR0IE_bit    = 1;
	BSF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;serial.h,25 :: 		}
L_end_InitTimer0:
	RETURN      0
; end of serial_InitTimer0

serial_Serial_Init:

;serial.h,29 :: 		static void Serial_Init()
;serial.h,39 :: 		UART1_Init(9600); // initialize hardware UART @baudrate=115200, the same setting for the sensor
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       207
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;serial.h,40 :: 		Delay_ms(100);    // let them stablize
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_serial_Serial_Init0:
	DECFSZ      R13, 1, 1
	BRA         L_serial_Serial_Init0
	DECFSZ      R12, 1, 1
	BRA         L_serial_Serial_Init0
	DECFSZ      R11, 1, 1
	BRA         L_serial_Serial_Init0
	NOP
;serial.h,42 :: 		PIE1.RCIE = 1; // enable interrupt source
	BSF         PIE1+0, 5 
;serial.h,43 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;serial.h,44 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;serial.h,45 :: 		}
L_end_Serial_Init:
	RETURN      0
; end of serial_Serial_Init

_Serial_clear:

;serial.c,12 :: 		void Serial_clear()
;serial.c,14 :: 		uartPos_w = 0;
	CLRF        serial_uartPos_w+0 
;serial.c,15 :: 		uartPos_r = 0;
	CLRF        serial_uartPos_r+0 
;serial.c,16 :: 		}
L_end_Serial_clear:
	RETURN      0
; end of _Serial_clear

_Serial_available:

;serial.c,18 :: 		size_t Serial_available()
;serial.c,20 :: 		uint8 n = uartPos_w - uartPos_r;
	MOVF        serial_uartPos_r+0, 0 
	SUBWF       serial_uartPos_w+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
;serial.c,21 :: 		return n;
	MOVLW       0
	MOVWF       R1 
;serial.c,22 :: 		}
L_end_Serial_available:
	RETURN      0
; end of _Serial_available

_Serial_Write:

;serial.c,24 :: 		size_t Serial_Write(void *buf, size_t n)
;serial.c,27 :: 		uint8 *p = (uint8 *)buf;
	MOVF        FARG_Serial_Write_buf+0, 0 
	MOVWF       Serial_Write_p_L0+0 
	MOVF        FARG_Serial_Write_buf+1, 0 
	MOVWF       Serial_Write_p_L0+1 
;serial.c,29 :: 		for (i = 0; i < n;)
	CLRF        Serial_Write_i_L0+0 
	CLRF        Serial_Write_i_L0+1 
L_Serial_Write1:
	MOVF        FARG_Serial_Write_n+1, 0 
	SUBWF       Serial_Write_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Serial_Write19
	MOVF        FARG_Serial_Write_n+0, 0 
	SUBWF       Serial_Write_i_L0+0, 0 
L__Serial_Write19:
	BTFSC       STATUS+0, 0 
	GOTO        L_Serial_Write2
;serial.c,31 :: 		if (UART1_Tx_Idle() == 1)
	CALL        _UART1_Tx_Idle+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Serial_Write4
;serial.c,33 :: 		c = p[i];
	MOVF        Serial_Write_i_L0+0, 0 
	ADDWF       Serial_Write_p_L0+0, 0 
	MOVWF       FSR0L+0 
	MOVF        Serial_Write_i_L0+1, 0 
	ADDWFC      Serial_Write_p_L0+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
;serial.c,34 :: 		UART1_Write(c);
	CALL        _UART1_Write+0, 0
;serial.c,35 :: 		i++;
	INFSNZ      Serial_Write_i_L0+0, 1 
	INCF        Serial_Write_i_L0+1, 1 
;serial.c,36 :: 		}
L_Serial_Write4:
;serial.c,37 :: 		}
	GOTO        L_Serial_Write1
L_Serial_Write2:
;serial.c,38 :: 		return n;
	MOVF        FARG_Serial_Write_n+0, 0 
	MOVWF       R0 
	MOVF        FARG_Serial_Write_n+1, 0 
	MOVWF       R1 
;serial.c,39 :: 		}
L_end_Serial_Write:
	RETURN      0
; end of _Serial_Write

_Serial_Read:

;serial.c,41 :: 		size_t Serial_Read(void *buf, size_t n)
;serial.c,44 :: 		memcpy(buf, uartRx + uartPos_r, n);
	MOVF        FARG_Serial_Read_buf+0, 0 
	MOVWF       FARG_memcpy_d1+0 
	MOVF        FARG_Serial_Read_buf+1, 0 
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       serial_uartRx+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(serial_uartRx+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVF        serial_uartPos_r+0, 0 
	ADDWF       FARG_memcpy_s1+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FARG_memcpy_s1+1, 1 
	MOVF        FARG_Serial_Read_n+0, 0 
	MOVWF       FARG_memcpy_n+0 
	MOVF        FARG_Serial_Read_n+1, 0 
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;serial.c,45 :: 		uartPos_r += n;
	MOVF        FARG_Serial_Read_n+0, 0 
	ADDWF       serial_uartPos_r+0, 1 
;serial.c,46 :: 		return n;
	MOVF        FARG_Serial_Read_n+0, 0 
	MOVWF       R0 
	MOVF        FARG_Serial_Read_n+1, 0 
	MOVWF       R1 
;serial.c,47 :: 		}
L_end_Serial_Read:
	RETURN      0
; end of _Serial_Read

_Interrupt:

;serial.c,59 :: 		void Interrupt()
;serial.c,64 :: 		if (PIE1.RCIE)
	BTFSS       PIE1+0, 5 
	GOTO        L_Interrupt5
;serial.c,67 :: 		uint8 n = uartPos_w - uartPos_r;
	MOVF        serial_uartPos_r+0, 0 
	SUBWF       serial_uartPos_w+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVF        R0, 0 
	MOVWF       Interrupt_n_L1+0 
;serial.c,68 :: 		if (uartPos_w > 0 && n == 0)
	MOVF        serial_uartPos_w+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Interrupt8
	MOVF        Interrupt_n_L1+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Interrupt8
L__Interrupt13:
;serial.c,70 :: 		Serial_clear();
	CALL        _Serial_clear+0, 0
;serial.c,71 :: 		}
L_Interrupt8:
;serial.c,74 :: 		uartRx[uartPos_w] = UART1_Read(); // put a byte to a buffer
	MOVLW       serial_uartRx+0
	MOVWF       FLOC__Interrupt+0 
	MOVLW       hi_addr(serial_uartRx+0)
	MOVWF       FLOC__Interrupt+1 
	MOVF        serial_uartPos_w+0, 0 
	ADDWF       FLOC__Interrupt+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FLOC__Interrupt+1, 1 
	CALL        _UART1_Read+0, 0
	MOVFF       FLOC__Interrupt+0, FSR1L+0
	MOVFF       FLOC__Interrupt+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;serial.c,75 :: 		uartPos_w++;
	INCF        serial_uartPos_w+0, 1 
;serial.c,76 :: 		if (uartPos_w == 64)
	MOVF        serial_uartPos_w+0, 0 
	XORLW       64
	BTFSS       STATUS+0, 2 
	GOTO        L_Interrupt9
;serial.c,78 :: 		Serial_clear();
	CALL        _Serial_clear+0, 0
;serial.c,79 :: 		} // reset pointer.
L_Interrupt9:
;serial.c,80 :: 		}
L_Interrupt5:
;serial.c,83 :: 		if (TMR0IF_bit)
	BTFSS       TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
	GOTO        L_Interrupt10
;serial.c,85 :: 		TMR0IF_bit    = 0;
	BCF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
;serial.c,86 :: 		TMR0H         = 0x0B;
	MOVLW       11
	MOVWF       TMR0H+0 
;serial.c,87 :: 		TMR0L         = 0xDC;
	MOVLW       220
	MOVWF       TMR0L+0 
;serial.c,89 :: 		contador_ms++;
	INCF        _contador_ms+0, 1 
;serial.c,90 :: 		if (contador_ms >= 2)
	MOVLW       2
	SUBWF       _contador_ms+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_Interrupt11
;serial.c,92 :: 		timeFlag = 1;
	MOVLW       1
	MOVWF       _timeFlag+0 
;serial.c,93 :: 		contador_ms = 0;
	CLRF        _contador_ms+0 
;serial.c,94 :: 		}
L_Interrupt11:
;serial.c,95 :: 		}
L_Interrupt10:
;serial.c,100 :: 		}
L_end_Interrupt:
L__Interrupt22:
	RETFIE      1
; end of _Interrupt

_Serial_writeByte:

;serial.c,102 :: 		void Serial_writeByte(uint8 b) {
;serial.c,103 :: 		Serial_write(&b, 1);
	MOVLW       FARG_Serial_writeByte_b+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(FARG_Serial_writeByte_b+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       1
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;serial.c,104 :: 		}
L_end_Serial_writeByte:
	RETURN      0
; end of _Serial_writeByte

_getMark:

;serial.c,107 :: 		uint8 getMark(){
;serial.c,108 :: 		uint8 mark = 0;
	CLRF        getMark_mark_L0+0 
;serial.c,109 :: 		if (Serial_available() >= 3)
	CALL        _Serial_available+0, 0
	MOVLW       0
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__getMark25
	MOVLW       3
	SUBWF       R0, 0 
L__getMark25:
	BTFSS       STATUS+0, 0 
	GOTO        L_getMark12
;serial.c,111 :: 		Serial_Read(&mark, 1);
	MOVLW       getMark_mark_L0+0
	MOVWF       FARG_Serial_Read_buf+0 
	MOVLW       hi_addr(getMark_mark_L0+0)
	MOVWF       FARG_Serial_Read_buf+1 
	MOVLW       1
	MOVWF       FARG_Serial_Read_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Read_n+1 
	CALL        _Serial_Read+0, 0
;serial.c,112 :: 		}
L_getMark12:
;serial.c,113 :: 		return mark;
	MOVF        getMark_mark_L0+0, 0 
	MOVWF       R0 
;serial.c,115 :: 		}
L_end_getMark:
	RETURN      0
; end of _getMark

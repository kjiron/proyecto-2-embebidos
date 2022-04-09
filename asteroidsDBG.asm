
asteroidsDBG_InitTimer0:

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
; end of asteroidsDBG_InitTimer0

asteroidsDBG_Serial_Init:

;serial.h,29 :: 		static void Serial_Init()
;serial.h,39 :: 		UART1_Init(19200); // initialize hardware UART @baudrate=115200, the same setting for the sensor
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       103
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
L_asteroidsDBG_Serial_Init0:
	DECFSZ      R13, 1, 1
	BRA         L_asteroidsDBG_Serial_Init0
	DECFSZ      R12, 1, 1
	BRA         L_asteroidsDBG_Serial_Init0
	DECFSZ      R11, 1, 1
	BRA         L_asteroidsDBG_Serial_Init0
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
; end of asteroidsDBG_Serial_Init

_Asteroids_Init:

;asteroidsDBG.c,113 :: 		void Asteroids_Init(Rect *s)
;asteroidsDBG.c,116 :: 		offset_y = 53;
	MOVLW       53
	MOVWF       Asteroids_Init_offset_y_L0+0 
;asteroidsDBG.c,117 :: 		for (i = 0; i < NUM_ASTEROIDS; i++)
	CLRF        Asteroids_Init_i_L0+0 
L_Asteroids_Init1:
	MOVLW       13
	SUBWF       Asteroids_Init_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Asteroids_Init2
;asteroidsDBG.c,119 :: 		offset_x = randint(0, 123);
	CLRF        FARG_randint_min+0 
	CLRF        FARG_randint_min+1 
	MOVLW       123
	MOVWF       FARG_randint_max+0 
	MOVLW       0
	MOVWF       FARG_randint_max+1 
	CALL        _randint+0, 0
;asteroidsDBG.c,120 :: 		s[i].x = offset_x;
	MOVF        Asteroids_Init_i_L0+0, 0 
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	RLCF        R2, 1 
	BCF         R2, 0 
	RLCF        R3, 1 
	RLCF        R2, 1 
	BCF         R2, 0 
	RLCF        R3, 1 
	MOVF        R2, 0 
	ADDWF       FARG_Asteroids_Init_s+0, 0 
	MOVWF       FSR1L+0 
	MOVF        R3, 0 
	ADDWFC      FARG_Asteroids_Init_s+1, 0 
	MOVWF       FSR1L+1 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;asteroidsDBG.c,121 :: 		s[i].y = offset_y;
	MOVF        Asteroids_Init_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        FARG_Asteroids_Init_s+0, 0 
	ADDWF       R0, 1 
	MOVF        FARG_Asteroids_Init_s+1, 0 
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1L+1 
	MOVF        Asteroids_Init_offset_y_L0+0, 0 
	MOVWF       POSTINC1+0 
;asteroidsDBG.c,122 :: 		s[i].w = 3;
	MOVF        Asteroids_Init_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        FARG_Asteroids_Init_s+0, 0 
	ADDWF       R0, 1 
	MOVF        FARG_Asteroids_Init_s+1, 0 
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1L+1 
	MOVLW       3
	MOVWF       POSTINC1+0 
;asteroidsDBG.c,123 :: 		s[i].h = 1;
	MOVF        Asteroids_Init_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        FARG_Asteroids_Init_s+0, 0 
	ADDWF       R0, 1 
	MOVF        FARG_Asteroids_Init_s+1, 0 
	ADDWFC      R1, 1 
	MOVLW       3
	ADDWF       R0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1L+1 
	MOVLW       1
	MOVWF       POSTINC1+0 
;asteroidsDBG.c,126 :: 		offset_y = offset_y - 4;
	MOVLW       4
	SUBWF       Asteroids_Init_offset_y_L0+0, 1 
;asteroidsDBG.c,117 :: 		for (i = 0; i < NUM_ASTEROIDS; i++)
	INCF        Asteroids_Init_i_L0+0, 1 
;asteroidsDBG.c,127 :: 		}
	GOTO        L_Asteroids_Init1
L_Asteroids_Init2:
;asteroidsDBG.c,129 :: 		timer.x = 62;
	MOVLW       62
	MOVWF       _timer+0 
;asteroidsDBG.c,130 :: 		timer.y = 3;
	MOVLW       3
	MOVWF       _timer+1 
;asteroidsDBG.c,131 :: 		timer.w = 1;
	MOVLW       1
	MOVWF       _timer+2 
;asteroidsDBG.c,132 :: 		timer.h = 60;
	MOVLW       60
	MOVWF       _timer+3 
;asteroidsDBG.c,133 :: 		}
L_end_Asteroids_Init:
	RETURN      0
; end of _Asteroids_Init

_check_collision:

;asteroidsDBG.c,138 :: 		bool check_collision(Rect rect1, Rect rect2)
;asteroidsDBG.c,140 :: 		return rect1.x < rect2.x + rect2.w &&
	MOVF        FARG_check_collision_rect2+2, 0 
	ADDWF       FARG_check_collision_rect2+0, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       FARG_check_collision_rect2+0, 7 
	MOVLW       255
	MOVWF       R2 
	MOVLW       0
	BTFSC       FARG_check_collision_rect2+2, 7 
	MOVLW       255
	ADDWFC      R2, 1 
;asteroidsDBG.c,141 :: 		rect1.x + rect1.w > rect2.x &&
	MOVLW       128
	BTFSC       FARG_check_collision_rect1+0, 7 
	MOVLW       127
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__check_collision57
	MOVF        R1, 0 
	SUBWF       FARG_check_collision_rect1+0, 0 
L__check_collision57:
	BTFSC       STATUS+0, 0 
	GOTO        L_check_collision5
	MOVF        FARG_check_collision_rect1+2, 0 
	ADDWF       FARG_check_collision_rect1+0, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       FARG_check_collision_rect1+0, 7 
	MOVLW       255
	MOVWF       R2 
	MOVLW       0
	BTFSC       FARG_check_collision_rect1+2, 7 
	MOVLW       255
	ADDWFC      R2, 1 
	MOVLW       128
	BTFSC       FARG_check_collision_rect2+0, 7 
	MOVLW       127
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__check_collision58
	MOVF        R1, 0 
	SUBWF       FARG_check_collision_rect2+0, 0 
L__check_collision58:
	BTFSC       STATUS+0, 0 
	GOTO        L_check_collision5
;asteroidsDBG.c,142 :: 		rect1.y < rect2.y + rect2.h &&
	MOVF        FARG_check_collision_rect2+3, 0 
	ADDWF       FARG_check_collision_rect2+1, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       FARG_check_collision_rect2+1, 7 
	MOVLW       255
	MOVWF       R2 
	MOVLW       0
	BTFSC       FARG_check_collision_rect2+3, 7 
	MOVLW       255
	ADDWFC      R2, 1 
	MOVLW       128
	BTFSC       FARG_check_collision_rect1+1, 7 
	MOVLW       127
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__check_collision59
	MOVF        R1, 0 
	SUBWF       FARG_check_collision_rect1+1, 0 
L__check_collision59:
	BTFSC       STATUS+0, 0 
	GOTO        L_check_collision5
;asteroidsDBG.c,143 :: 		rect1.h + rect1.y > rect2.y;
	MOVF        FARG_check_collision_rect1+1, 0 
	ADDWF       FARG_check_collision_rect1+3, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       FARG_check_collision_rect1+3, 7 
	MOVLW       255
	MOVWF       R2 
	MOVLW       0
	BTFSC       FARG_check_collision_rect1+1, 7 
	MOVLW       255
	ADDWFC      R2, 1 
	MOVLW       128
	BTFSC       FARG_check_collision_rect2+1, 7 
	MOVLW       127
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__check_collision60
	MOVF        R1, 0 
	SUBWF       FARG_check_collision_rect2+1, 0 
L__check_collision60:
	BTFSC       STATUS+0, 0 
	GOTO        L_check_collision5
	MOVLW       1
	MOVWF       R0 
	GOTO        L_check_collision4
L_check_collision5:
	CLRF        R0 
L_check_collision4:
;asteroidsDBG.c,144 :: 		}
L_end_check_collision:
	RETURN      0
; end of _check_collision

_Update_Asteroids:

;asteroidsDBG.c,151 :: 		void Update_Asteroids(Rect *s)
;asteroidsDBG.c,154 :: 		for (i = 0; i < NUM_ASTEROIDS; i++)
	CLRF        Update_Asteroids_i_L0+0 
L_Update_Asteroids6:
	MOVLW       13
	SUBWF       Update_Asteroids_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Update_Asteroids7
;asteroidsDBG.c,156 :: 		if (check_collision(s[i], playerOne))
	MOVF        Update_Asteroids_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       FARG_Update_Asteroids_s+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_Update_Asteroids_s+1, 0 
	MOVWF       FSR0L+1 
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_check_collision_rect1+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_check_collision_rect1+0)
	MOVWF       FSR1L+1 
L_Update_Asteroids9:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_Update_Asteroids9
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_check_collision_rect2+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_check_collision_rect2+0)
	MOVWF       FSR1L+1 
	MOVLW       _playerOne+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_playerOne+0)
	MOVWF       FSR0L+1 
L_Update_Asteroids10:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_Update_Asteroids10
	CALL        _check_collision+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Update_Asteroids11
;asteroidsDBG.c,158 :: 		playerOne.y = 55;
	MOVLW       55
	MOVWF       _playerOne+1 
;asteroidsDBG.c,159 :: 		Serial_Write(&SendPlayer, 2);
	MOVLW       _SendPlayer+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_SendPlayer+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       2
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;asteroidsDBG.c,160 :: 		Serial_Write(&playerOne, sizeof(Rect));
	MOVLW       _playerOne+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_playerOne+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       4
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;asteroidsDBG.c,161 :: 		}
L_Update_Asteroids11:
;asteroidsDBG.c,163 :: 		draw_horizontal_line(s[i], ERASE);
	MOVF        Update_Asteroids_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       FARG_Update_Asteroids_s+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_Update_Asteroids_s+1, 0 
	MOVWF       FSR0L+1 
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_draw_horizontal_line_asteroid+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_horizontal_line_asteroid+0)
	MOVWF       FSR1L+1 
L_Update_Asteroids12:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_Update_Asteroids12
	CLRF        FARG_draw_horizontal_line_color+0 
	CALL        _draw_horizontal_line+0, 0
;asteroidsDBG.c,165 :: 		if ((i % 2) == 1)
	MOVLW       1
	ANDWF       Update_Asteroids_i_L0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Update_Asteroids13
;asteroidsDBG.c,167 :: 		if (s[i].x <= 0)
	MOVF        Update_Asteroids_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       FARG_Update_Asteroids_s+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_Update_Asteroids_s+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	XORWF       R1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_Update_Asteroids14
;asteroidsDBG.c,169 :: 		s[i].x = 124;
	MOVF        Update_Asteroids_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       FARG_Update_Asteroids_s+0, 0 
	MOVWF       FSR1L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_Update_Asteroids_s+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       124
	MOVWF       POSTINC1+0 
;asteroidsDBG.c,170 :: 		}
L_Update_Asteroids14:
;asteroidsDBG.c,171 :: 		s[i].x--;
	MOVF        Update_Asteroids_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       FARG_Update_Asteroids_s+0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	ADDWFC      FARG_Update_Asteroids_s+1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0L+0
	MOVFF       R3, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	DECF        R0, 1 
	MOVFF       R2, FSR1L+0
	MOVFF       R3, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;asteroidsDBG.c,172 :: 		}
	GOTO        L_Update_Asteroids15
L_Update_Asteroids13:
;asteroidsDBG.c,175 :: 		if (s[i].x >= 124)
	MOVF        Update_Asteroids_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       FARG_Update_Asteroids_s+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_Update_Asteroids_s+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       128
	XORWF       R1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       124
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_Update_Asteroids16
;asteroidsDBG.c,177 :: 		s[i].x = 0;
	MOVF        Update_Asteroids_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       FARG_Update_Asteroids_s+0, 0 
	MOVWF       FSR1L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_Update_Asteroids_s+1, 0 
	MOVWF       FSR1L+1 
	CLRF        POSTINC1+0 
;asteroidsDBG.c,178 :: 		}
L_Update_Asteroids16:
;asteroidsDBG.c,179 :: 		s[i].x++;
	MOVF        Update_Asteroids_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       FARG_Update_Asteroids_s+0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	ADDWFC      FARG_Update_Asteroids_s+1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0L+0
	MOVFF       R3, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	INCF        R0, 1 
	MOVFF       R2, FSR1L+0
	MOVFF       R3, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;asteroidsDBG.c,180 :: 		}
L_Update_Asteroids15:
;asteroidsDBG.c,181 :: 		draw_horizontal_line(s[i], DRAW);
	MOVF        Update_Asteroids_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       FARG_Update_Asteroids_s+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_Update_Asteroids_s+1, 0 
	MOVWF       FSR0L+1 
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_draw_horizontal_line_asteroid+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_horizontal_line_asteroid+0)
	MOVWF       FSR1L+1 
L_Update_Asteroids17:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_Update_Asteroids17
	MOVLW       1
	MOVWF       FARG_draw_horizontal_line_color+0 
	CALL        _draw_horizontal_line+0, 0
;asteroidsDBG.c,154 :: 		for (i = 0; i < NUM_ASTEROIDS; i++)
	INCF        Update_Asteroids_i_L0+0, 1 
;asteroidsDBG.c,182 :: 		}
	GOTO        L_Update_Asteroids6
L_Update_Asteroids7:
;asteroidsDBG.c,184 :: 		Serial_Write(&SendUpdateAst, 2);
	MOVLW       _SendUpdateAst+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_SendUpdateAst+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       2
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;asteroidsDBG.c,185 :: 		}
L_end_Update_Asteroids:
	RETURN      0
; end of _Update_Asteroids

_draw_score:

;asteroidsDBG.c,191 :: 		void draw_score(uint8_t a, uint8_t b){ //function to draw the score
;asteroidsDBG.c,194 :: 		ShortToStr(a, score_text);
	MOVF        FARG_draw_score_a+0, 0 
	MOVWF       FARG_ShortToStr_input+0 
	MOVLW       _score_text+0
	MOVWF       FARG_ShortToStr_output+0 
	MOVLW       hi_addr(_score_text+0)
	MOVWF       FARG_ShortToStr_output+1 
	CALL        _ShortToStr+0, 0
;asteroidsDBG.c,195 :: 		fix_text = Ltrim(score_text);
	MOVLW       _score_text+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(_score_text+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
;asteroidsDBG.c,196 :: 		Glcd_Write_Text(fix_text, 15, 7, 1);
	MOVF        R0, 0 
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVF        R1, 0 
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       15
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       7
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;asteroidsDBG.c,197 :: 		ShortToStr(b, score_text);
	MOVF        FARG_draw_score_b+0, 0 
	MOVWF       FARG_ShortToStr_input+0 
	MOVLW       _score_text+0
	MOVWF       FARG_ShortToStr_output+0 
	MOVLW       hi_addr(_score_text+0)
	MOVWF       FARG_ShortToStr_output+1 
	CALL        _ShortToStr+0, 0
;asteroidsDBG.c,198 :: 		fix_text = Ltrim(score_text);
	MOVLW       _score_text+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(_score_text+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
;asteroidsDBG.c,199 :: 		Glcd_Write_Text(fix_text, 107, 7, 1);
	MOVF        R0, 0 
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVF        R1, 0 
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       107
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       7
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;asteroidsDBG.c,200 :: 		}
L_end_draw_score:
	RETURN      0
; end of _draw_score

_updateData:

;asteroidsDBG.c,209 :: 		void updateData() {
;asteroidsDBG.c,213 :: 		while (1)
L_updateData18:
;asteroidsDBG.c,216 :: 		n = Serial_available();
	CALL        _Serial_available+0, 0
;asteroidsDBG.c,217 :: 		if (n >= (2)) {
	MOVLW       128
	XORWF       R1, 0 
	MOVWF       R2 
	MOVLW       128
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__updateData64
	MOVLW       2
	SUBWF       R0, 0 
L__updateData64:
	BTFSS       STATUS+0, 0 
	GOTO        L_updateData20
;asteroidsDBG.c,218 :: 		Serial_Read(&mark, 2);
	MOVLW       updateData_mark_L0+0
	MOVWF       FARG_Serial_Read_buf+0 
	MOVLW       hi_addr(updateData_mark_L0+0)
	MOVWF       FARG_Serial_Read_buf+1 
	MOVLW       2
	MOVWF       FARG_Serial_Read_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Read_n+1 
	CALL        _Serial_Read+0, 0
;asteroidsDBG.c,220 :: 		if (mark == SendTime) {
	MOVF        updateData_mark_L0+1, 0 
	XORWF       _SendTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__updateData65
	MOVF        _SendTime+0, 0 
	XORWF       updateData_mark_L0+0, 0 
L__updateData65:
	BTFSS       STATUS+0, 2 
	GOTO        L_updateData21
;asteroidsDBG.c,221 :: 		flag = 1;
	MOVLW       1
	MOVWF       _flag+0 
;asteroidsDBG.c,222 :: 		continue;
	GOTO        L_updateData18
;asteroidsDBG.c,223 :: 		}
L_updateData21:
;asteroidsDBG.c,225 :: 		if (mark == SendPlayer)
	MOVF        updateData_mark_L0+1, 0 
	XORWF       _SendPlayer+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__updateData66
	MOVF        _SendPlayer+0, 0 
	XORWF       updateData_mark_L0+0, 0 
L__updateData66:
	BTFSS       STATUS+0, 2 
	GOTO        L_updateData22
;asteroidsDBG.c,227 :: 		Serial_Read(&playerTwo, sizeof(Rect));
	MOVLW       _playerTwo+0
	MOVWF       FARG_Serial_Read_buf+0 
	MOVLW       hi_addr(_playerTwo+0)
	MOVWF       FARG_Serial_Read_buf+1 
	MOVLW       4
	MOVWF       FARG_Serial_Read_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Read_n+1 
	CALL        _Serial_Read+0, 0
;asteroidsDBG.c,228 :: 		continue;
	GOTO        L_updateData18
;asteroidsDBG.c,229 :: 		}
L_updateData22:
;asteroidsDBG.c,231 :: 		if (mark == SendPlayerX)
	MOVF        updateData_mark_L0+1, 0 
	XORWF       _SendPlayerX+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__updateData67
	MOVF        _SendPlayerX+0, 0 
	XORWF       updateData_mark_L0+0, 0 
L__updateData67:
	BTFSS       STATUS+0, 2 
	GOTO        L_updateData23
;asteroidsDBG.c,233 :: 		Serial_Read(&playerTwo, sizeof(Rect));
	MOVLW       _playerTwo+0
	MOVWF       FARG_Serial_Read_buf+0 
	MOVLW       hi_addr(_playerTwo+0)
	MOVWF       FARG_Serial_Read_buf+1 
	MOVLW       4
	MOVWF       FARG_Serial_Read_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Read_n+1 
	CALL        _Serial_Read+0, 0
;asteroidsDBG.c,234 :: 		continue;
	GOTO        L_updateData18
;asteroidsDBG.c,235 :: 		}
L_updateData23:
;asteroidsDBG.c,237 :: 		if (mark == SendScore)
	MOVF        updateData_mark_L0+1, 0 
	XORWF       _SendScore+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__updateData68
	MOVF        _SendScore+0, 0 
	XORWF       updateData_mark_L0+0, 0 
L__updateData68:
	BTFSS       STATUS+0, 2 
	GOTO        L_updateData24
;asteroidsDBG.c,239 :: 		flagScore = 1;
	MOVLW       1
	MOVWF       _flagScore+0 
;asteroidsDBG.c,240 :: 		continue;
	GOTO        L_updateData18
;asteroidsDBG.c,241 :: 		}
L_updateData24:
;asteroidsDBG.c,243 :: 		if (mark == SendTimeOut)
	MOVF        updateData_mark_L0+1, 0 
	XORWF       _SendTimeOut+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__updateData69
	MOVF        _SendTimeOut+0, 0 
	XORWF       updateData_mark_L0+0, 0 
L__updateData69:
	BTFSS       STATUS+0, 2 
	GOTO        L_updateData25
;asteroidsDBG.c,245 :: 		flagTimeOut = 1;
	MOVLW       1
	MOVWF       _flagTimeOut+0 
;asteroidsDBG.c,246 :: 		continue;
	GOTO        L_updateData18
;asteroidsDBG.c,247 :: 		}
L_updateData25:
;asteroidsDBG.c,249 :: 		Serial_clear();
	CALL        _Serial_clear+0, 0
;asteroidsDBG.c,250 :: 		}
L_updateData20:
;asteroidsDBG.c,252 :: 		return;
;asteroidsDBG.c,255 :: 		}
L_end_updateData:
	RETURN      0
; end of _updateData

_syncGame:

;asteroidsDBG.c,262 :: 		void syncGame()
;asteroidsDBG.c,266 :: 		while (1)
L_syncGame26:
;asteroidsDBG.c,268 :: 		Serial_Write(&SendInit, 2);
	MOVLW       _SendInit+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_SendInit+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       2
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;asteroidsDBG.c,270 :: 		n = Serial_available();
	CALL        _Serial_available+0, 0
;asteroidsDBG.c,272 :: 		if (n > 2)
	MOVLW       128
	MOVWF       R2 
	MOVLW       128
	XORWF       R1, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__syncGame71
	MOVF        R0, 0 
	SUBLW       2
L__syncGame71:
	BTFSC       STATUS+0, 0 
	GOTO        L_syncGame28
;asteroidsDBG.c,274 :: 		Serial_Read(&mark, 2);
	MOVLW       syncGame_mark_L0+0
	MOVWF       FARG_Serial_Read_buf+0 
	MOVLW       hi_addr(syncGame_mark_L0+0)
	MOVWF       FARG_Serial_Read_buf+1 
	MOVLW       2
	MOVWF       FARG_Serial_Read_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Read_n+1 
	CALL        _Serial_Read+0, 0
;asteroidsDBG.c,276 :: 		if (mark == SendAck)
	MOVF        syncGame_mark_L0+1, 0 
	XORWF       _SendAck+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__syncGame72
	MOVF        _SendAck+0, 0 
	XORWF       syncGame_mark_L0+0, 0 
L__syncGame72:
	BTFSS       STATUS+0, 2 
	GOTO        L_syncGame29
;asteroidsDBG.c,278 :: 		break;
	GOTO        L_syncGame27
;asteroidsDBG.c,279 :: 		}
L_syncGame29:
;asteroidsDBG.c,281 :: 		Serial_clear();
	CALL        _Serial_clear+0, 0
;asteroidsDBG.c,282 :: 		}
L_syncGame28:
;asteroidsDBG.c,284 :: 		Delay_ms(200);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_syncGame30:
	DECFSZ      R13, 1, 1
	BRA         L_syncGame30
	DECFSZ      R12, 1, 1
	BRA         L_syncGame30
	DECFSZ      R11, 1, 1
	BRA         L_syncGame30
;asteroidsDBG.c,287 :: 		}
	GOTO        L_syncGame26
L_syncGame27:
;asteroidsDBG.c,289 :: 		}
L_end_syncGame:
	RETURN      0
; end of _syncGame

_draw_box:

;asteroidsDBG.c,291 :: 		void draw_box(Rect r, uint8_t color)
;asteroidsDBG.c,294 :: 		Glcd_Box(r.x, r.y, r.x + r.w, r.y + r.h, color);
	MOVF        FARG_draw_box_r+0, 0 
	MOVWF       FARG_Glcd_Box_x_upper_left+0 
	MOVF        FARG_draw_box_r+1, 0 
	MOVWF       FARG_Glcd_Box_y_upper_left+0 
	MOVF        FARG_draw_box_r+2, 0 
	ADDWF       FARG_draw_box_r+0, 0 
	MOVWF       FARG_Glcd_Box_x_bottom_right+0 
	MOVF        FARG_draw_box_r+3, 0 
	ADDWF       FARG_draw_box_r+1, 0 
	MOVWF       FARG_Glcd_Box_y_bottom_right+0 
	MOVF        FARG_draw_box_color+0, 0 
	MOVWF       FARG_Glcd_Box_color+0 
	CALL        _Glcd_Box+0, 0
;asteroidsDBG.c,295 :: 		}
L_end_draw_box:
	RETURN      0
; end of _draw_box

_initGame:

;asteroidsDBG.c,301 :: 		void initGame()
;asteroidsDBG.c,303 :: 		playerOne.x = 32;
	MOVLW       32
	MOVWF       _playerOne+0 
;asteroidsDBG.c,304 :: 		playerOne.y = 55;
	MOVLW       55
	MOVWF       _playerOne+1 
;asteroidsDBG.c,305 :: 		playerOne.w = 9;
	MOVLW       9
	MOVWF       _playerOne+2 
;asteroidsDBG.c,306 :: 		playerOne.h = 9;
	MOVLW       9
	MOVWF       _playerOne+3 
;asteroidsDBG.c,308 :: 		playerTwo.x = 94;
	MOVLW       94
	MOVWF       _playerTwo+0 
;asteroidsDBG.c,309 :: 		playerTwo.y = 55;
	MOVLW       55
	MOVWF       _playerTwo+1 
;asteroidsDBG.c,310 :: 		playerTwo.w = 9;
	MOVLW       9
	MOVWF       _playerTwo+2 
;asteroidsDBG.c,311 :: 		playerTwo.h = 9;
	MOVLW       9
	MOVWF       _playerTwo+3 
;asteroidsDBG.c,312 :: 		}
L_end_initGame:
	RETURN      0
; end of _initGame

_main:

;asteroidsDBG.c,316 :: 		void main()
;asteroidsDBG.c,323 :: 		ADCON1 = 0x0F;
	MOVLW       15
	MOVWF       ADCON1+0 
;asteroidsDBG.c,325 :: 		Serial_Init();
	CALL        asteroidsDBG_Serial_Init+0, 0
;asteroidsDBG.c,326 :: 		Serial_clear();
	CALL        _Serial_clear+0, 0
;asteroidsDBG.c,327 :: 		initGame();
	CALL        _initGame+0, 0
;asteroidsDBG.c,328 :: 		randomSeed(33);
	MOVLW       33
	MOVWF       FARG_randomSeed_seed+0 
	MOVLW       0
	MOVWF       FARG_randomSeed_seed+1 
	MOVWF       FARG_randomSeed_seed+2 
	MOVWF       FARG_randomSeed_seed+3 
	CALL        _randomSeed+0, 0
;asteroidsDBG.c,329 :: 		Asteroids_Init(asteroids);
	MOVLW       _asteroids+0
	MOVWF       FARG_Asteroids_Init_s+0 
	MOVLW       hi_addr(_asteroids+0)
	MOVWF       FARG_Asteroids_Init_s+1 
	CALL        _Asteroids_Init+0, 0
;asteroidsDBG.c,330 :: 		Glcd_Init();
	CALL        _Glcd_Init+0, 0
;asteroidsDBG.c,331 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;asteroidsDBG.c,332 :: 		syncGame();
	CALL        _syncGame+0, 0
;asteroidsDBG.c,333 :: 		draw_score(scoreA, scoreB);
	MOVF        _scoreA+0, 0 
	MOVWF       FARG_draw_score_a+0 
	MOVF        _scoreB+0, 0 
	MOVWF       FARG_draw_score_b+0 
	CALL        _draw_score+0, 0
;asteroidsDBG.c,335 :: 		while (1)
L_main31:
;asteroidsDBG.c,338 :: 		Update_Asteroids(asteroids);
	MOVLW       _asteroids+0
	MOVWF       FARG_Update_Asteroids_s+0 
	MOVLW       hi_addr(_asteroids+0)
	MOVWF       FARG_Update_Asteroids_s+1 
	CALL        _Update_Asteroids+0, 0
;asteroidsDBG.c,339 :: 		updateData();
	CALL        _updateData+0, 0
;asteroidsDBG.c,341 :: 		if (flag)
	MOVF        _flag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main33
;asteroidsDBG.c,343 :: 		timer.y++;
	MOVF        _timer+1, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _timer+1 
;asteroidsDBG.c,344 :: 		flag = 0;
	CLRF        _flag+0 
;asteroidsDBG.c,345 :: 		}
L_main33:
;asteroidsDBG.c,347 :: 		if (flagScore)
	MOVF        _flagScore+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main34
;asteroidsDBG.c,349 :: 		flagScore = 0;
	CLRF        _flagScore+0 
;asteroidsDBG.c,350 :: 		scoreB++;
	INCF        _scoreB+0, 1 
;asteroidsDBG.c,351 :: 		draw_score(scoreA, scoreB);
	MOVF        _scoreA+0, 0 
	MOVWF       FARG_draw_score_a+0 
	MOVF        _scoreB+0, 0 
	MOVWF       FARG_draw_score_b+0 
	CALL        _draw_score+0, 0
;asteroidsDBG.c,352 :: 		}
L_main34:
;asteroidsDBG.c,356 :: 		if (PORTA.B2 == 1) //up
	BTFSS       PORTA+0, 2 
	GOTO        L_main35
;asteroidsDBG.c,358 :: 		playerOne.y--;
	DECF        _playerOne+1, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _playerOne+1 
;asteroidsDBG.c,359 :: 		if (playerOne.y <= 0){
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	XORWF       _playerOne+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main36
;asteroidsDBG.c,360 :: 		playerOne.x = 32;
	MOVLW       32
	MOVWF       _playerOne+0 
;asteroidsDBG.c,361 :: 		playerOne.y = 55;
	MOVLW       55
	MOVWF       _playerOne+1 
;asteroidsDBG.c,362 :: 		scoreA++;
	INCF        _scoreA+0, 1 
;asteroidsDBG.c,363 :: 		Serial_Write(&SendScore, 2);
	MOVLW       _SendScore+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_SendScore+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       2
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;asteroidsDBG.c,364 :: 		draw_score(scoreA, scoreB);
	MOVF        _scoreA+0, 0 
	MOVWF       FARG_draw_score_a+0 
	MOVF        _scoreB+0, 0 
	MOVWF       FARG_draw_score_b+0 
	CALL        _draw_score+0, 0
;asteroidsDBG.c,365 :: 		}
L_main36:
;asteroidsDBG.c,366 :: 		Serial_Write(&SendPlayer, 2);
	MOVLW       _SendPlayer+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_SendPlayer+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       2
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;asteroidsDBG.c,367 :: 		Serial_Write(&playerOne, sizeof(Rect));
	MOVLW       _playerOne+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_playerOne+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       4
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;asteroidsDBG.c,368 :: 		}
L_main35:
;asteroidsDBG.c,370 :: 		if (PORTA.B3 == 1) //down
	BTFSS       PORTA+0, 3 
	GOTO        L_main37
;asteroidsDBG.c,372 :: 		playerOne.y++;
	MOVF        _playerOne+1, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _playerOne+1 
;asteroidsDBG.c,373 :: 		if (playerOne.y + (playerOne.h - 1) >= 63){
	DECF        _playerOne+3, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _playerOne+3, 7 
	MOVLW       255
	MOVWF       R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVF        _playerOne+1, 0 
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       0
	BTFSC       _playerOne+1, 7 
	MOVLW       255
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVLW       128
	XORWF       R3, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main76
	MOVLW       63
	SUBWF       R2, 0 
L__main76:
	BTFSS       STATUS+0, 0 
	GOTO        L_main38
;asteroidsDBG.c,374 :: 		playerOne.y = 55;
	MOVLW       55
	MOVWF       _playerOne+1 
;asteroidsDBG.c,375 :: 		}
L_main38:
;asteroidsDBG.c,376 :: 		Serial_Write(&SendPlayer, 2);
	MOVLW       _SendPlayer+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_SendPlayer+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       2
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;asteroidsDBG.c,377 :: 		Serial_Write(&playerOne, sizeof(Rect));
	MOVLW       _playerOne+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_playerOne+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       4
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;asteroidsDBG.c,378 :: 		}
L_main37:
;asteroidsDBG.c,380 :: 		if (flagTimeOut)
	MOVF        _flagTimeOut+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main39
;asteroidsDBG.c,382 :: 		flagTimeOut = 0;
	CLRF        _flagTimeOut+0 
;asteroidsDBG.c,383 :: 		if (scoreA > scoreB)
	MOVF        _scoreA+0, 0 
	SUBWF       _scoreB+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main40
;asteroidsDBG.c,385 :: 		draw_winFrame();
	CALL        _draw_winFrame+0, 0
;asteroidsDBG.c,386 :: 		}
	GOTO        L_main41
L_main40:
;asteroidsDBG.c,388 :: 		else if (scoreB > scoreA)
	MOVF        _scoreB+0, 0 
	SUBWF       _scoreA+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main42
;asteroidsDBG.c,390 :: 		draw_loseFrame();
	CALL        _draw_loseFrame+0, 0
;asteroidsDBG.c,391 :: 		}
	GOTO        L_main43
L_main42:
;asteroidsDBG.c,395 :: 		draw_loseFrame();
	CALL        _draw_loseFrame+0, 0
;asteroidsDBG.c,396 :: 		}
L_main43:
L_main41:
;asteroidsDBG.c,397 :: 		}
L_main39:
;asteroidsDBG.c,401 :: 		draw_box(timer, DRAW);
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_draw_box_r+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_box_r+0)
	MOVWF       FSR1L+1 
	MOVLW       _timer+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_timer+0)
	MOVWF       FSR0L+1 
L_main44:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main44
	MOVLW       1
	MOVWF       FARG_draw_box_color+0 
	CALL        _draw_box+0, 0
;asteroidsDBG.c,402 :: 		draw_partial_image(playerOne, ship);
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_draw_partial_image_player+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_partial_image_player+0)
	MOVWF       FSR1L+1 
	MOVLW       _playerOne+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_playerOne+0)
	MOVWF       FSR0L+1 
L_main45:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main45
	MOVLW       _ship+0
	MOVWF       FARG_draw_partial_image_image+0 
	MOVLW       hi_addr(_ship+0)
	MOVWF       FARG_draw_partial_image_image+1 
	MOVLW       higher_addr(_ship+0)
	MOVWF       FARG_draw_partial_image_image+2 
	CALL        _draw_partial_image+0, 0
;asteroidsDBG.c,403 :: 		draw_partial_image(playerTwo, ship);
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_draw_partial_image_player+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_partial_image_player+0)
	MOVWF       FSR1L+1 
	MOVLW       _playerTwo+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_playerTwo+0)
	MOVWF       FSR0L+1 
L_main46:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main46
	MOVLW       _ship+0
	MOVWF       FARG_draw_partial_image_image+0 
	MOVLW       hi_addr(_ship+0)
	MOVWF       FARG_draw_partial_image_image+1 
	MOVLW       higher_addr(_ship+0)
	MOVWF       FARG_draw_partial_image_image+2 
	CALL        _draw_partial_image+0, 0
;asteroidsDBG.c,404 :: 		Delay_ms(60);
	MOVLW       156
	MOVWF       R12, 0
	MOVLW       215
	MOVWF       R13, 0
L_main47:
	DECFSZ      R13, 1, 1
	BRA         L_main47
	DECFSZ      R12, 1, 1
	BRA         L_main47
;asteroidsDBG.c,405 :: 		draw_box(timer, ERASE);
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_draw_box_r+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_box_r+0)
	MOVWF       FSR1L+1 
	MOVLW       _timer+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_timer+0)
	MOVWF       FSR0L+1 
L_main48:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main48
	CLRF        FARG_draw_box_color+0 
	CALL        _draw_box+0, 0
;asteroidsDBG.c,406 :: 		draw_partial_image(playerOne, parche);
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_draw_partial_image_player+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_partial_image_player+0)
	MOVWF       FSR1L+1 
	MOVLW       _playerOne+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_playerOne+0)
	MOVWF       FSR0L+1 
L_main49:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main49
	MOVLW       _parche+0
	MOVWF       FARG_draw_partial_image_image+0 
	MOVLW       hi_addr(_parche+0)
	MOVWF       FARG_draw_partial_image_image+1 
	MOVLW       higher_addr(_parche+0)
	MOVWF       FARG_draw_partial_image_image+2 
	CALL        _draw_partial_image+0, 0
;asteroidsDBG.c,407 :: 		draw_partial_image(playerTwo, parche);
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_draw_partial_image_player+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_partial_image_player+0)
	MOVWF       FSR1L+1 
	MOVLW       _playerTwo+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_playerTwo+0)
	MOVWF       FSR0L+1 
L_main50:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main50
	MOVLW       _parche+0
	MOVWF       FARG_draw_partial_image_image+0 
	MOVLW       hi_addr(_parche+0)
	MOVWF       FARG_draw_partial_image_image+1 
	MOVLW       higher_addr(_parche+0)
	MOVWF       FARG_draw_partial_image_image+2 
	CALL        _draw_partial_image+0, 0
;asteroidsDBG.c,409 :: 		}
	GOTO        L_main31
;asteroidsDBG.c,410 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_draw_horizontal_line:

;asteroidsDBG.c,413 :: 		void draw_horizontal_line(Rect asteroid, uint8_t color)
;asteroidsDBG.c,415 :: 		Glcd_H_Line(asteroid.x, asteroid.x + asteroid.w, asteroid.y,  color);
	MOVF        FARG_draw_horizontal_line_asteroid+0, 0 
	MOVWF       FARG_Glcd_H_Line_x_start+0 
	MOVF        FARG_draw_horizontal_line_asteroid+2, 0 
	ADDWF       FARG_draw_horizontal_line_asteroid+0, 0 
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVF        FARG_draw_horizontal_line_asteroid+1, 0 
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	MOVF        FARG_draw_horizontal_line_color+0, 0 
	MOVWF       FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;asteroidsDBG.c,416 :: 		}
L_end_draw_horizontal_line:
	RETURN      0
; end of _draw_horizontal_line

_draw_dot:

;asteroidsDBG.c,418 :: 		void draw_dot(Rect player, uint8_t color)
;asteroidsDBG.c,420 :: 		Glcd_Dot(player.x, player.y, color);
	MOVF        FARG_draw_dot_player+0, 0 
	MOVWF       FARG_Glcd_Dot_x_pos+0 
	MOVF        FARG_draw_dot_player+1, 0 
	MOVWF       FARG_Glcd_Dot_y_pos+0 
	MOVF        FARG_draw_dot_color+0, 0 
	MOVWF       FARG_Glcd_Dot_color+0 
	CALL        _Glcd_Dot+0, 0
;asteroidsDBG.c,421 :: 		}
L_end_draw_dot:
	RETURN      0
; end of _draw_dot

_draw_partial_image:

;asteroidsDBG.c,423 :: 		void draw_partial_image(Rect player, code const unsigned short * image)
;asteroidsDBG.c,425 :: 		Glcd_PartialImage(player.x, player.y, player.w, player.h, player.w, player.h, image);
	MOVF        FARG_draw_partial_image_player+0, 0 
	MOVWF       FARG_Glcd_PartialImage_x_left+0 
	MOVLW       0
	BTFSC       FARG_draw_partial_image_player+0, 7 
	MOVLW       255
	MOVWF       FARG_Glcd_PartialImage_x_left+1 
	MOVF        FARG_draw_partial_image_player+1, 0 
	MOVWF       FARG_Glcd_PartialImage_y_top+0 
	MOVLW       0
	BTFSC       FARG_draw_partial_image_player+1, 7 
	MOVLW       255
	MOVWF       FARG_Glcd_PartialImage_y_top+1 
	MOVF        FARG_draw_partial_image_player+2, 0 
	MOVWF       FARG_Glcd_PartialImage_width+0 
	MOVLW       0
	BTFSC       FARG_draw_partial_image_player+2, 7 
	MOVLW       255
	MOVWF       FARG_Glcd_PartialImage_width+1 
	MOVF        FARG_draw_partial_image_player+3, 0 
	MOVWF       FARG_Glcd_PartialImage_height+0 
	MOVLW       0
	BTFSC       FARG_draw_partial_image_player+3, 7 
	MOVLW       255
	MOVWF       FARG_Glcd_PartialImage_height+1 
	MOVF        FARG_draw_partial_image_player+2, 0 
	MOVWF       FARG_Glcd_PartialImage_picture_width+0 
	MOVLW       0
	BTFSC       FARG_draw_partial_image_player+2, 7 
	MOVLW       255
	MOVWF       FARG_Glcd_PartialImage_picture_width+1 
	MOVF        FARG_draw_partial_image_player+3, 0 
	MOVWF       FARG_Glcd_PartialImage_picture_height+0 
	MOVLW       0
	BTFSC       FARG_draw_partial_image_player+3, 7 
	MOVLW       255
	MOVWF       FARG_Glcd_PartialImage_picture_height+1 
	MOVF        FARG_draw_partial_image_image+0, 0 
	MOVWF       FARG_Glcd_PartialImage_image+0 
	MOVF        FARG_draw_partial_image_image+1, 0 
	MOVWF       FARG_Glcd_PartialImage_image+1 
	MOVF        FARG_draw_partial_image_image+2, 0 
	MOVWF       FARG_Glcd_PartialImage_image+2 
	CALL        _Glcd_PartialImage+0, 0
;asteroidsDBG.c,426 :: 		}
L_end_draw_partial_image:
	RETURN      0
; end of _draw_partial_image

_draw_winFrame:

;asteroidsDBG.c,429 :: 		void draw_winFrame(){
;asteroidsDBG.c,430 :: 		Glcd_Image(winScreen);
	MOVLW       _winScreen+0
	MOVWF       FARG_Glcd_Image_image+0 
	MOVLW       hi_addr(_winScreen+0)
	MOVWF       FARG_Glcd_Image_image+1 
	MOVLW       higher_addr(_winScreen+0)
	MOVWF       FARG_Glcd_Image_image+2 
	CALL        _Glcd_Image+0, 0
;asteroidsDBG.c,431 :: 		Delay_ms(4000);
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_draw_winFrame51:
	DECFSZ      R13, 1, 1
	BRA         L_draw_winFrame51
	DECFSZ      R12, 1, 1
	BRA         L_draw_winFrame51
	DECFSZ      R11, 1, 1
	BRA         L_draw_winFrame51
;asteroidsDBG.c,432 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;asteroidsDBG.c,433 :: 		}
L_end_draw_winFrame:
	RETURN      0
; end of _draw_winFrame

_draw_loseFrame:

;asteroidsDBG.c,435 :: 		void draw_loseFrame(){
;asteroidsDBG.c,436 :: 		Glcd_Image(loseScreen);
	MOVLW       _loseScreen+0
	MOVWF       FARG_Glcd_Image_image+0 
	MOVLW       hi_addr(_loseScreen+0)
	MOVWF       FARG_Glcd_Image_image+1 
	MOVLW       higher_addr(_loseScreen+0)
	MOVWF       FARG_Glcd_Image_image+2 
	CALL        _Glcd_Image+0, 0
;asteroidsDBG.c,437 :: 		Delay_ms(4000);
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_draw_loseFrame52:
	DECFSZ      R13, 1, 1
	BRA         L_draw_loseFrame52
	DECFSZ      R12, 1, 1
	BRA         L_draw_loseFrame52
	DECFSZ      R11, 1, 1
	BRA         L_draw_loseFrame52
;asteroidsDBG.c,438 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;asteroidsDBG.c,439 :: 		}
L_end_draw_loseFrame:
	RETURN      0
; end of _draw_loseFrame

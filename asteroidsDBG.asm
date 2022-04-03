
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

_randint:

;asteroidsDBG.c,57 :: 		uint8_t randint(uint8_t n)
;asteroidsDBG.c,59 :: 		return (uint8_t)(rand() % (n+1));
	CALL        _rand+0, 0
	MOVF        FARG_randint_n+0, 0 
	ADDLW       1
	MOVWF       R4 
	CLRF        R5 
	MOVLW       0
	ADDWFC      R5, 1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
;asteroidsDBG.c,60 :: 		}
L_end_randint:
	RETURN      0
; end of _randint

_Asteroids_Init:

;asteroidsDBG.c,62 :: 		void Asteroids_Init(Rect *s)
;asteroidsDBG.c,65 :: 		offset_x = 0;
	CLRF        Asteroids_Init_offset_x_L0+0 
;asteroidsDBG.c,66 :: 		offset_y = 53;
	MOVLW       53
	MOVWF       Asteroids_Init_offset_y_L0+0 
;asteroidsDBG.c,67 :: 		for (i = 0; i < NUM_ASTEROIDS; i++)
	CLRF        Asteroids_Init_i_L0+0 
L_Asteroids_Init1:
	MOVLW       13
	SUBWF       Asteroids_Init_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Asteroids_Init2
;asteroidsDBG.c,69 :: 		s[i].x = offset_x;
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
	MOVF        R0, 0 
	ADDWF       FARG_Asteroids_Init_s+0, 0 
	MOVWF       FSR1L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_Asteroids_Init_s+1, 0 
	MOVWF       FSR1L+1 
	MOVF        Asteroids_Init_offset_x_L0+0, 0 
	MOVWF       POSTINC1+0 
;asteroidsDBG.c,70 :: 		s[i].y = offset_y;
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
;asteroidsDBG.c,71 :: 		s[i].w = 3;
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
;asteroidsDBG.c,72 :: 		s[i].h = 1;
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
;asteroidsDBG.c,74 :: 		offset_x = randint(123);
	MOVLW       123
	MOVWF       FARG_randint_n+0 
	CALL        _randint+0, 0
	MOVF        R0, 0 
	MOVWF       Asteroids_Init_offset_x_L0+0 
;asteroidsDBG.c,75 :: 		offset_y = offset_y - 4;
	MOVLW       4
	SUBWF       Asteroids_Init_offset_y_L0+0, 1 
;asteroidsDBG.c,67 :: 		for (i = 0; i < NUM_ASTEROIDS; i++)
	INCF        Asteroids_Init_i_L0+0, 1 
;asteroidsDBG.c,76 :: 		}
	GOTO        L_Asteroids_Init1
L_Asteroids_Init2:
;asteroidsDBG.c,78 :: 		timer.x = 62;
	MOVLW       62
	MOVWF       _timer+0 
;asteroidsDBG.c,79 :: 		timer.y = 3;
	MOVLW       3
	MOVWF       _timer+1 
;asteroidsDBG.c,80 :: 		timer.w = 1;
	MOVLW       1
	MOVWF       _timer+2 
;asteroidsDBG.c,81 :: 		timer.h = 60;
	MOVLW       60
	MOVWF       _timer+3 
;asteroidsDBG.c,82 :: 		}
L_end_Asteroids_Init:
	RETURN      0
; end of _Asteroids_Init

_Update_Asteroids:

;asteroidsDBG.c,85 :: 		void Update_Asteroids(Rect *s)
;asteroidsDBG.c,88 :: 		for (i = 0; i < NUM_ASTEROIDS; i++)
	CLRF        Update_Asteroids_i_L0+0 
L_Update_Asteroids4:
	MOVLW       13
	SUBWF       Update_Asteroids_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Update_Asteroids5
;asteroidsDBG.c,90 :: 		draw_horizontal_line(s[i], ERASE);
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
L_Update_Asteroids7:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_Update_Asteroids7
	CLRF        FARG_draw_horizontal_line_color+0 
	CALL        _draw_horizontal_line+0, 0
;asteroidsDBG.c,92 :: 		if ((i % 2) == 1)
	MOVLW       1
	ANDWF       Update_Asteroids_i_L0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Update_Asteroids8
;asteroidsDBG.c,94 :: 		if (s[i].x <= 0)
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
	GOTO        L_Update_Asteroids9
;asteroidsDBG.c,96 :: 		s[i].x = 124;
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
;asteroidsDBG.c,97 :: 		}
L_Update_Asteroids9:
;asteroidsDBG.c,98 :: 		s[i].x--;
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
;asteroidsDBG.c,99 :: 		}
	GOTO        L_Update_Asteroids10
L_Update_Asteroids8:
;asteroidsDBG.c,102 :: 		if (s[i].x >= 124)
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
	GOTO        L_Update_Asteroids11
;asteroidsDBG.c,104 :: 		s[i].x = 0;
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
;asteroidsDBG.c,105 :: 		}
L_Update_Asteroids11:
;asteroidsDBG.c,106 :: 		s[i].x++;
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
;asteroidsDBG.c,107 :: 		}
L_Update_Asteroids10:
;asteroidsDBG.c,108 :: 		draw_horizontal_line(s[i], DRAW);
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
	MOVLW       1
	MOVWF       FARG_draw_horizontal_line_color+0 
	CALL        _draw_horizontal_line+0, 0
;asteroidsDBG.c,88 :: 		for (i = 0; i < NUM_ASTEROIDS; i++)
	INCF        Update_Asteroids_i_L0+0, 1 
;asteroidsDBG.c,109 :: 		}
	GOTO        L_Update_Asteroids4
L_Update_Asteroids5:
;asteroidsDBG.c,110 :: 		}
L_end_Update_Asteroids:
	RETURN      0
; end of _Update_Asteroids

_updateData:

;asteroidsDBG.c,113 :: 		void updateData() {
;asteroidsDBG.c,117 :: 		while (1)
L_updateData13:
;asteroidsDBG.c,120 :: 		n = Serial_available();
	CALL        _Serial_available+0, 0
;asteroidsDBG.c,121 :: 		if (n >= (2)) {
	MOVLW       128
	XORWF       R1, 0 
	MOVWF       R2 
	MOVLW       128
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__updateData57
	MOVLW       2
	SUBWF       R0, 0 
L__updateData57:
	BTFSS       STATUS+0, 0 
	GOTO        L_updateData15
;asteroidsDBG.c,122 :: 		Serial_Read(&mark, 2);
	MOVLW       updateData_mark_L0+0
	MOVWF       FARG_Serial_Read_buf+0 
	MOVLW       hi_addr(updateData_mark_L0+0)
	MOVWF       FARG_Serial_Read_buf+1 
	MOVLW       2
	MOVWF       FARG_Serial_Read_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Read_n+1 
	CALL        _Serial_Read+0, 0
;asteroidsDBG.c,124 :: 		if (mark == SendTime) {
	MOVF        updateData_mark_L0+1, 0 
	XORWF       _SendTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__updateData58
	MOVF        _SendTime+0, 0 
	XORWF       updateData_mark_L0+0, 0 
L__updateData58:
	BTFSS       STATUS+0, 2 
	GOTO        L_updateData16
;asteroidsDBG.c,125 :: 		flag = 1;
	MOVLW       1
	MOVWF       _flag+0 
;asteroidsDBG.c,126 :: 		continue;
	GOTO        L_updateData13
;asteroidsDBG.c,127 :: 		}
L_updateData16:
;asteroidsDBG.c,129 :: 		Serial_clear();
	CALL        _Serial_clear+0, 0
;asteroidsDBG.c,130 :: 		}
L_updateData15:
;asteroidsDBG.c,132 :: 		return;
;asteroidsDBG.c,135 :: 		}
L_end_updateData:
	RETURN      0
; end of _updateData

_draw_box:

;asteroidsDBG.c,137 :: 		void draw_box(Rect r, uint8_t color)
;asteroidsDBG.c,140 :: 		Glcd_Box(r.x, r.y, r.x + r.w, r.y + r.h, color);
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
;asteroidsDBG.c,141 :: 		}
L_end_draw_box:
	RETURN      0
; end of _draw_box

_main:

;asteroidsDBG.c,144 :: 		void main()
;asteroidsDBG.c,154 :: 		Serial_Init();
	CALL        asteroidsDBG_Serial_Init+0, 0
;asteroidsDBG.c,156 :: 		Serial_clear();
	CALL        _Serial_clear+0, 0
;asteroidsDBG.c,158 :: 		Asteroids_Init(asteroids);
	MOVLW       _asteroids+0
	MOVWF       FARG_Asteroids_Init_s+0 
	MOVLW       hi_addr(_asteroids+0)
	MOVWF       FARG_Asteroids_Init_s+1 
	CALL        _Asteroids_Init+0, 0
;asteroidsDBG.c,161 :: 		Glcd_Init();
	CALL        _Glcd_Init+0, 0
;asteroidsDBG.c,162 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;asteroidsDBG.c,164 :: 		while (1)
L_main17:
;asteroidsDBG.c,167 :: 		Update_Asteroids(asteroids);
	MOVLW       _asteroids+0
	MOVWF       FARG_Update_Asteroids_s+0 
	MOVLW       hi_addr(_asteroids+0)
	MOVWF       FARG_Update_Asteroids_s+1 
	CALL        _Update_Asteroids+0, 0
;asteroidsDBG.c,168 :: 		updateData();
	CALL        _updateData+0, 0
;asteroidsDBG.c,170 :: 		if (flag)
	MOVF        _flag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main19
;asteroidsDBG.c,172 :: 		timer.y++;
	MOVF        _timer+1, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _timer+1 
;asteroidsDBG.c,173 :: 		flag = 0;
	CLRF        _flag+0 
;asteroidsDBG.c,174 :: 		Serial_clear();
	CALL        _Serial_clear+0, 0
;asteroidsDBG.c,175 :: 		}
L_main19:
;asteroidsDBG.c,177 :: 		for (i = 0; i < NUM_ASTEROIDS; i++)
	CLRF        main_i_L0+0 
L_main20:
	MOVLW       13
	SUBWF       main_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main21
;asteroidsDBG.c,179 :: 		if (i == 0)
	MOVF        main_i_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main23
;asteroidsDBG.c,181 :: 		Serial_Write(&SendAsteroid, 1);
	MOVLW       _SendAsteroid+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_SendAsteroid+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       1
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;asteroidsDBG.c,182 :: 		Serial_Write(&asteroids[i].x, 1);
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _asteroids+0
	ADDWF       R0, 0 
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_asteroids+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       1
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;asteroidsDBG.c,183 :: 		}
	GOTO        L_main24
L_main23:
;asteroidsDBG.c,184 :: 		else if (i == 1)
	MOVF        main_i_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main25
;asteroidsDBG.c,186 :: 		Serial_Write(&SendAsteroid2, 1);
	MOVLW       _SendAsteroid2+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_SendAsteroid2+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       1
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;asteroidsDBG.c,187 :: 		Serial_Write(&asteroids[i].x, 1);
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _asteroids+0
	ADDWF       R0, 0 
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_asteroids+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       1
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;asteroidsDBG.c,188 :: 		}
	GOTO        L_main26
L_main25:
;asteroidsDBG.c,190 :: 		else if (i == 2)
	MOVF        main_i_L0+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_main27
;asteroidsDBG.c,192 :: 		Serial_Write(&SendAsteroid3, 1);
	MOVLW       _SendAsteroid3+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_SendAsteroid3+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       1
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;asteroidsDBG.c,193 :: 		Serial_Write(&asteroids[i].x, 1);
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _asteroids+0
	ADDWF       R0, 0 
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_asteroids+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       1
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;asteroidsDBG.c,194 :: 		}
	GOTO        L_main28
L_main27:
;asteroidsDBG.c,196 :: 		else if (i == 3)
	MOVF        main_i_L0+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_main29
;asteroidsDBG.c,198 :: 		Serial_Write(&SendAsteroid4, 1);
	MOVLW       _SendAsteroid4+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_SendAsteroid4+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       1
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;asteroidsDBG.c,199 :: 		Serial_Write(&asteroids[i].x, 1);
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _asteroids+0
	ADDWF       R0, 0 
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_asteroids+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       1
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;asteroidsDBG.c,200 :: 		}
	GOTO        L_main30
L_main29:
;asteroidsDBG.c,202 :: 		else if (i == 4)
	MOVF        main_i_L0+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_main31
;asteroidsDBG.c,204 :: 		Serial_Write(&SendAsteroid5, 1);
	MOVLW       _SendAsteroid5+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_SendAsteroid5+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       1
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;asteroidsDBG.c,205 :: 		Serial_Write(&asteroids[i].x, 1);
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _asteroids+0
	ADDWF       R0, 0 
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_asteroids+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       1
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;asteroidsDBG.c,206 :: 		}
	GOTO        L_main32
L_main31:
;asteroidsDBG.c,208 :: 		else if (i == 5)
	MOVF        main_i_L0+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_main33
;asteroidsDBG.c,210 :: 		Serial_Write(&SendAsteroid6, 1);
	MOVLW       _SendAsteroid6+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_SendAsteroid6+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       1
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;asteroidsDBG.c,211 :: 		Serial_Write(&asteroids[i].x, 1);
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _asteroids+0
	ADDWF       R0, 0 
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_asteroids+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       1
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;asteroidsDBG.c,212 :: 		}
	GOTO        L_main34
L_main33:
;asteroidsDBG.c,214 :: 		else if (i == 6)
	MOVF        main_i_L0+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_main35
;asteroidsDBG.c,216 :: 		Serial_Write(&SendAsteroid7, 1);
	MOVLW       _SendAsteroid7+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_SendAsteroid7+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       1
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;asteroidsDBG.c,217 :: 		Serial_Write(&asteroids[i].x, 1);
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _asteroids+0
	ADDWF       R0, 0 
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_asteroids+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       1
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;asteroidsDBG.c,218 :: 		}
	GOTO        L_main36
L_main35:
;asteroidsDBG.c,220 :: 		else if (i == 7)
	MOVF        main_i_L0+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_main37
;asteroidsDBG.c,222 :: 		Serial_Write(&SendAsteroid8, 1);
	MOVLW       _SendAsteroid8+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_SendAsteroid8+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       1
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;asteroidsDBG.c,223 :: 		Serial_Write(&asteroids[i].x, 1);
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _asteroids+0
	ADDWF       R0, 0 
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_asteroids+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       1
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;asteroidsDBG.c,224 :: 		}
	GOTO        L_main38
L_main37:
;asteroidsDBG.c,226 :: 		else if (i == 8)
	MOVF        main_i_L0+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_main39
;asteroidsDBG.c,228 :: 		Serial_Write(&SendAsteroid9, 1);
	MOVLW       _SendAsteroid9+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_SendAsteroid9+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       1
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;asteroidsDBG.c,229 :: 		Serial_Write(&asteroids[i].x, 1);
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _asteroids+0
	ADDWF       R0, 0 
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_asteroids+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       1
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;asteroidsDBG.c,230 :: 		}
	GOTO        L_main40
L_main39:
;asteroidsDBG.c,232 :: 		else if (i == 9)
	MOVF        main_i_L0+0, 0 
	XORLW       9
	BTFSS       STATUS+0, 2 
	GOTO        L_main41
;asteroidsDBG.c,234 :: 		Serial_Write(&SendAsteroid10, 1);
	MOVLW       _SendAsteroid10+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_SendAsteroid10+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       1
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;asteroidsDBG.c,235 :: 		Serial_Write(&asteroids[i].x, 1);
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _asteroids+0
	ADDWF       R0, 0 
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_asteroids+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       1
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;asteroidsDBG.c,236 :: 		}
	GOTO        L_main42
L_main41:
;asteroidsDBG.c,239 :: 		else if (i == 10)
	MOVF        main_i_L0+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_main43
;asteroidsDBG.c,241 :: 		Serial_Write(&SendAsteroid11, 1);
	MOVLW       _SendAsteroid11+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_SendAsteroid11+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       1
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;asteroidsDBG.c,242 :: 		Serial_Write(&asteroids[i].x, 1);
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _asteroids+0
	ADDWF       R0, 0 
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_asteroids+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       1
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;asteroidsDBG.c,243 :: 		}
	GOTO        L_main44
L_main43:
;asteroidsDBG.c,246 :: 		else if (i == 11)
	MOVF        main_i_L0+0, 0 
	XORLW       11
	BTFSS       STATUS+0, 2 
	GOTO        L_main45
;asteroidsDBG.c,248 :: 		Serial_Write(&SendAsteroid12, 1);
	MOVLW       _SendAsteroid12+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_SendAsteroid12+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       1
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;asteroidsDBG.c,249 :: 		Serial_Write(&asteroids[i].x, 1);
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _asteroids+0
	ADDWF       R0, 0 
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_asteroids+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       1
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;asteroidsDBG.c,250 :: 		}
	GOTO        L_main46
L_main45:
;asteroidsDBG.c,252 :: 		else if (i == 12)
	MOVF        main_i_L0+0, 0 
	XORLW       12
	BTFSS       STATUS+0, 2 
	GOTO        L_main47
;asteroidsDBG.c,254 :: 		Serial_Write(&SendAsteroid13, 1);
	MOVLW       _SendAsteroid13+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_SendAsteroid13+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       1
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;asteroidsDBG.c,255 :: 		Serial_Write(&asteroids[i].x, 1);
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _asteroids+0
	ADDWF       R0, 0 
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_asteroids+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       1
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;asteroidsDBG.c,256 :: 		}
L_main47:
L_main46:
L_main44:
L_main42:
L_main40:
L_main38:
L_main36:
L_main34:
L_main32:
L_main30:
L_main28:
L_main26:
L_main24:
;asteroidsDBG.c,177 :: 		for (i = 0; i < NUM_ASTEROIDS; i++)
	INCF        main_i_L0+0, 1 
;asteroidsDBG.c,257 :: 		}
	GOTO        L_main20
L_main21:
;asteroidsDBG.c,259 :: 		draw_box(timer, DRAW);
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
	MOVLW       1
	MOVWF       FARG_draw_box_color+0 
	CALL        _draw_box+0, 0
;asteroidsDBG.c,260 :: 		Delay_ms(60);
	MOVLW       156
	MOVWF       R12, 0
	MOVLW       215
	MOVWF       R13, 0
L_main49:
	DECFSZ      R13, 1, 1
	BRA         L_main49
	DECFSZ      R12, 1, 1
	BRA         L_main49
;asteroidsDBG.c,261 :: 		draw_box(timer, ERASE);
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
L_main50:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main50
	CLRF        FARG_draw_box_color+0 
	CALL        _draw_box+0, 0
;asteroidsDBG.c,263 :: 		}
	GOTO        L_main17
;asteroidsDBG.c,264 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_draw_horizontal_line:

;asteroidsDBG.c,267 :: 		void draw_horizontal_line(Rect asteroid, uint8_t color)
;asteroidsDBG.c,269 :: 		Glcd_H_Line(asteroid.x, asteroid.x + asteroid.w, asteroid.y,  color);
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
;asteroidsDBG.c,270 :: 		}
L_end_draw_horizontal_line:
	RETURN      0
; end of _draw_horizontal_line

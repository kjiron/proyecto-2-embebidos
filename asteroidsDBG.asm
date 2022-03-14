
_randint:

;asteroidsDBG.c,32 :: 		uint8_t randint(uint8_t n)
;asteroidsDBG.c,34 :: 		return (uint8_t)(rand() % (n+1));
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
;asteroidsDBG.c,35 :: 		}
L_end_randint:
	RETURN      0
; end of _randint

_main:

;asteroidsDBG.c,40 :: 		void main()
;asteroidsDBG.c,45 :: 		offset_x = 0;
	CLRF        main_offset_x_L0+0 
;asteroidsDBG.c,46 :: 		offset_y = 53;
	MOVLW       53
	MOVWF       main_offset_y_L0+0 
;asteroidsDBG.c,49 :: 		for (i = 0; i <= 12; i++)
	CLRF        main_i_L0+0 
L_main0:
	MOVF        main_i_L0+0, 0 
	SUBLW       12
	BTFSS       STATUS+0, 0 
	GOTO        L_main1
;asteroidsDBG.c,51 :: 		m[i].x = offset_x;
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
	MOVLW       main_m_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(main_m_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1L+1 
	MOVF        main_offset_x_L0+0, 0 
	MOVWF       POSTINC1+0 
;asteroidsDBG.c,52 :: 		m[i].y = offset_y;
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
	MOVLW       main_m_L0+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(main_m_L0+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1L+1 
	MOVF        main_offset_y_L0+0, 0 
	MOVWF       POSTINC1+0 
;asteroidsDBG.c,53 :: 		m[i].w = 3;
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
	MOVLW       main_m_L0+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(main_m_L0+0)
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1L+1 
	MOVLW       3
	MOVWF       POSTINC1+0 
;asteroidsDBG.c,54 :: 		m[i].h = 1;
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
	MOVLW       main_m_L0+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(main_m_L0+0)
	ADDWFC      R1, 1 
	MOVLW       3
	ADDWF       R0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1L+1 
	MOVLW       1
	MOVWF       POSTINC1+0 
;asteroidsDBG.c,56 :: 		offset_x = randint(123);
	MOVLW       123
	MOVWF       FARG_randint_n+0 
	CALL        _randint+0, 0
	MOVF        R0, 0 
	MOVWF       main_offset_x_L0+0 
;asteroidsDBG.c,57 :: 		offset_y = offset_y - 4;
	MOVLW       4
	SUBWF       main_offset_y_L0+0, 1 
;asteroidsDBG.c,49 :: 		for (i = 0; i <= 12; i++)
	INCF        main_i_L0+0, 1 
;asteroidsDBG.c,58 :: 		}
	GOTO        L_main0
L_main1:
;asteroidsDBG.c,60 :: 		Glcd_Init();
	CALL        _Glcd_Init+0, 0
;asteroidsDBG.c,61 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;asteroidsDBG.c,64 :: 		while (1)
L_main3:
;asteroidsDBG.c,67 :: 		for (i = 0; i <= 12; i++)
	CLRF        main_i_L0+0 
L_main5:
	MOVF        main_i_L0+0, 0 
	SUBLW       12
	BTFSS       STATUS+0, 0 
	GOTO        L_main6
;asteroidsDBG.c,69 :: 		draw_horizontal_line(m[i], ERASE);
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
	MOVLW       main_m_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(main_m_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0L+1 
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_draw_horizontal_line_asteroid+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_horizontal_line_asteroid+0)
	MOVWF       FSR1L+1 
L_main8:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main8
	CLRF        FARG_draw_horizontal_line_color+0 
	CALL        _draw_horizontal_line+0, 0
;asteroidsDBG.c,71 :: 		if ((i % 2) == 1)
	MOVLW       1
	ANDWF       main_i_L0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main9
;asteroidsDBG.c,73 :: 		if (m[i].x <= 0)
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
	MOVLW       main_m_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(main_m_L0+0)
	ADDWFC      R1, 0 
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
	GOTO        L_main10
;asteroidsDBG.c,75 :: 		m[i].x = 124;
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
	MOVLW       main_m_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(main_m_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1L+1 
	MOVLW       124
	MOVWF       POSTINC1+0 
;asteroidsDBG.c,76 :: 		}
L_main10:
;asteroidsDBG.c,77 :: 		m[i].x--;
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
	MOVLW       main_m_L0+0
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(main_m_L0+0)
	ADDWFC      R1, 0 
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
;asteroidsDBG.c,78 :: 		}
	GOTO        L_main11
L_main9:
;asteroidsDBG.c,81 :: 		if (m[i].x >= 124)
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
	MOVLW       main_m_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(main_m_L0+0)
	ADDWFC      R1, 0 
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
	GOTO        L_main12
;asteroidsDBG.c,83 :: 		m[i].x = 0;
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
	MOVLW       main_m_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(main_m_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1L+1 
	CLRF        POSTINC1+0 
;asteroidsDBG.c,84 :: 		}
L_main12:
;asteroidsDBG.c,85 :: 		m[i].x++;
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
	MOVLW       main_m_L0+0
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(main_m_L0+0)
	ADDWFC      R1, 0 
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
;asteroidsDBG.c,86 :: 		}
L_main11:
;asteroidsDBG.c,87 :: 		draw_horizontal_line(m[i], DRAW);
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
	MOVLW       main_m_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(main_m_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0L+1 
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_draw_horizontal_line_asteroid+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_horizontal_line_asteroid+0)
	MOVWF       FSR1L+1 
L_main13:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main13
	MOVLW       1
	MOVWF       FARG_draw_horizontal_line_color+0 
	CALL        _draw_horizontal_line+0, 0
;asteroidsDBG.c,67 :: 		for (i = 0; i <= 12; i++)
	INCF        main_i_L0+0, 1 
;asteroidsDBG.c,88 :: 		}
	GOTO        L_main5
L_main6:
;asteroidsDBG.c,90 :: 		Delay_ms(60);
	MOVLW       156
	MOVWF       R12, 0
	MOVLW       215
	MOVWF       R13, 0
L_main14:
	DECFSZ      R13, 1, 1
	BRA         L_main14
	DECFSZ      R12, 1, 1
	BRA         L_main14
;asteroidsDBG.c,92 :: 		}
	GOTO        L_main3
;asteroidsDBG.c,94 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_draw_horizontal_line:

;asteroidsDBG.c,97 :: 		void draw_horizontal_line(Rect asteroid, uint8_t color)
;asteroidsDBG.c,99 :: 		Glcd_H_Line(asteroid.x, asteroid.x + asteroid.w, asteroid.y,  color);
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
;asteroidsDBG.c,100 :: 		}
L_end_draw_horizontal_line:
	RETURN      0
; end of _draw_horizontal_line

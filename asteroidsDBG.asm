
_randint:

;asteroidsDBG.c,33 :: 		uint8_t randint(uint8_t n)
;asteroidsDBG.c,35 :: 		return (uint8_t)(rand() % (n+1));
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
;asteroidsDBG.c,36 :: 		}
L_end_randint:
	RETURN      0
; end of _randint

_initEnvironment:

;asteroidsDBG.c,38 :: 		void initEnvironment(Rect *s)
;asteroidsDBG.c,41 :: 		offset_x = 0;
	CLRF        initEnvironment_offset_x_L0+0 
;asteroidsDBG.c,42 :: 		offset_y = 53;
	MOVLW       53
	MOVWF       initEnvironment_offset_y_L0+0 
;asteroidsDBG.c,43 :: 		for (i = 0; i <= 12; i++)
	CLRF        initEnvironment_i_L0+0 
L_initEnvironment0:
	MOVF        initEnvironment_i_L0+0, 0 
	SUBLW       12
	BTFSS       STATUS+0, 0 
	GOTO        L_initEnvironment1
;asteroidsDBG.c,45 :: 		s[i].x = offset_x;
	MOVF        initEnvironment_i_L0+0, 0 
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
	ADDWF       FARG_initEnvironment_s+0, 0 
	MOVWF       FSR1L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_initEnvironment_s+1, 0 
	MOVWF       FSR1L+1 
	MOVF        initEnvironment_offset_x_L0+0, 0 
	MOVWF       POSTINC1+0 
;asteroidsDBG.c,46 :: 		s[i].y = offset_y;
	MOVF        initEnvironment_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        FARG_initEnvironment_s+0, 0 
	ADDWF       R0, 1 
	MOVF        FARG_initEnvironment_s+1, 0 
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1L+1 
	MOVF        initEnvironment_offset_y_L0+0, 0 
	MOVWF       POSTINC1+0 
;asteroidsDBG.c,47 :: 		s[i].w = 3;
	MOVF        initEnvironment_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        FARG_initEnvironment_s+0, 0 
	ADDWF       R0, 1 
	MOVF        FARG_initEnvironment_s+1, 0 
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1L+1 
	MOVLW       3
	MOVWF       POSTINC1+0 
;asteroidsDBG.c,48 :: 		s[i].h = 1;
	MOVF        initEnvironment_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        FARG_initEnvironment_s+0, 0 
	ADDWF       R0, 1 
	MOVF        FARG_initEnvironment_s+1, 0 
	ADDWFC      R1, 1 
	MOVLW       3
	ADDWF       R0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1L+1 
	MOVLW       1
	MOVWF       POSTINC1+0 
;asteroidsDBG.c,50 :: 		offset_x = randint(123);
	MOVLW       123
	MOVWF       FARG_randint_n+0 
	CALL        _randint+0, 0
	MOVF        R0, 0 
	MOVWF       initEnvironment_offset_x_L0+0 
;asteroidsDBG.c,51 :: 		offset_y = offset_y - 4;
	MOVLW       4
	SUBWF       initEnvironment_offset_y_L0+0, 1 
;asteroidsDBG.c,43 :: 		for (i = 0; i <= 12; i++)
	INCF        initEnvironment_i_L0+0, 1 
;asteroidsDBG.c,52 :: 		}
	GOTO        L_initEnvironment0
L_initEnvironment1:
;asteroidsDBG.c,53 :: 		}
L_end_initEnvironment:
	RETURN      0
; end of _initEnvironment

_environment:

;asteroidsDBG.c,56 :: 		void environment(Rect *s)
;asteroidsDBG.c,59 :: 		for (i = 0; i <= NUM_ASTEROIDS - 1; i++)
	CLRF        environment_i_L0+0 
L_environment3:
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__environment18
	MOVF        environment_i_L0+0, 0 
	SUBLW       12
L__environment18:
	BTFSS       STATUS+0, 0 
	GOTO        L_environment4
;asteroidsDBG.c,61 :: 		draw_horizontal_line(s[i], ERASE);
	MOVF        environment_i_L0+0, 0 
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
	ADDWF       FARG_environment_s+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_environment_s+1, 0 
	MOVWF       FSR0L+1 
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_draw_horizontal_line_asteroid+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_horizontal_line_asteroid+0)
	MOVWF       FSR1L+1 
L_environment6:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_environment6
	CLRF        FARG_draw_horizontal_line_color+0 
	CALL        _draw_horizontal_line+0, 0
;asteroidsDBG.c,63 :: 		if ((i % 2) == 1)
	MOVLW       1
	ANDWF       environment_i_L0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_environment7
;asteroidsDBG.c,65 :: 		if (s[i].x <= 0)
	MOVF        environment_i_L0+0, 0 
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
	ADDWF       FARG_environment_s+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_environment_s+1, 0 
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
	GOTO        L_environment8
;asteroidsDBG.c,67 :: 		s[i].x = 124;
	MOVF        environment_i_L0+0, 0 
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
	ADDWF       FARG_environment_s+0, 0 
	MOVWF       FSR1L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_environment_s+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       124
	MOVWF       POSTINC1+0 
;asteroidsDBG.c,68 :: 		}
L_environment8:
;asteroidsDBG.c,69 :: 		s[i].x--;
	MOVF        environment_i_L0+0, 0 
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
	ADDWF       FARG_environment_s+0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	ADDWFC      FARG_environment_s+1, 0 
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
;asteroidsDBG.c,70 :: 		}
	GOTO        L_environment9
L_environment7:
;asteroidsDBG.c,73 :: 		if (s[i].x >= 124)
	MOVF        environment_i_L0+0, 0 
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
	ADDWF       FARG_environment_s+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_environment_s+1, 0 
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
	GOTO        L_environment10
;asteroidsDBG.c,75 :: 		s[i].x = 0;
	MOVF        environment_i_L0+0, 0 
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
	ADDWF       FARG_environment_s+0, 0 
	MOVWF       FSR1L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_environment_s+1, 0 
	MOVWF       FSR1L+1 
	CLRF        POSTINC1+0 
;asteroidsDBG.c,76 :: 		}
L_environment10:
;asteroidsDBG.c,77 :: 		s[i].x++;
	MOVF        environment_i_L0+0, 0 
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
	ADDWF       FARG_environment_s+0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	ADDWFC      FARG_environment_s+1, 0 
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
;asteroidsDBG.c,78 :: 		}
L_environment9:
;asteroidsDBG.c,79 :: 		draw_horizontal_line(s[i], DRAW);
	MOVF        environment_i_L0+0, 0 
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
	ADDWF       FARG_environment_s+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_environment_s+1, 0 
	MOVWF       FSR0L+1 
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_draw_horizontal_line_asteroid+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_horizontal_line_asteroid+0)
	MOVWF       FSR1L+1 
L_environment11:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_environment11
	MOVLW       1
	MOVWF       FARG_draw_horizontal_line_color+0 
	CALL        _draw_horizontal_line+0, 0
;asteroidsDBG.c,59 :: 		for (i = 0; i <= NUM_ASTEROIDS - 1; i++)
	INCF        environment_i_L0+0, 1 
;asteroidsDBG.c,80 :: 		}
	GOTO        L_environment3
L_environment4:
;asteroidsDBG.c,82 :: 		}
L_end_environment:
	RETURN      0
; end of _environment

_main:

;asteroidsDBG.c,88 :: 		void main()
;asteroidsDBG.c,94 :: 		initEnvironment(m);
	MOVLW       main_m_L0+0
	MOVWF       FARG_initEnvironment_s+0 
	MOVLW       hi_addr(main_m_L0+0)
	MOVWF       FARG_initEnvironment_s+1 
	CALL        _initEnvironment+0, 0
;asteroidsDBG.c,97 :: 		Glcd_Init();
	CALL        _Glcd_Init+0, 0
;asteroidsDBG.c,98 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;asteroidsDBG.c,101 :: 		while (1)
L_main12:
;asteroidsDBG.c,104 :: 		environment(m);
	MOVLW       main_m_L0+0
	MOVWF       FARG_environment_s+0 
	MOVLW       hi_addr(main_m_L0+0)
	MOVWF       FARG_environment_s+1 
	CALL        _environment+0, 0
;asteroidsDBG.c,105 :: 		Delay_ms(60);
	MOVLW       156
	MOVWF       R12, 0
	MOVLW       215
	MOVWF       R13, 0
L_main14:
	DECFSZ      R13, 1, 1
	BRA         L_main14
	DECFSZ      R12, 1, 1
	BRA         L_main14
;asteroidsDBG.c,107 :: 		}
	GOTO        L_main12
;asteroidsDBG.c,109 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_draw_horizontal_line:

;asteroidsDBG.c,112 :: 		void draw_horizontal_line(Rect asteroid, uint8_t color)
;asteroidsDBG.c,114 :: 		Glcd_H_Line(asteroid.x, asteroid.x + asteroid.w, asteroid.y,  color);
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
;asteroidsDBG.c,115 :: 		}
L_end_draw_horizontal_line:
	RETURN      0
; end of _draw_horizontal_line

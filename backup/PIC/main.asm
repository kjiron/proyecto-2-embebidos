
main_InitTimer0:

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
; end of main_InitTimer0

main_Serial_Init:

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
L_main_Serial_Init0:
	DECFSZ      R13, 1, 1
	BRA         L_main_Serial_Init0
	DECFSZ      R12, 1, 1
	BRA         L_main_Serial_Init0
	DECFSZ      R11, 1, 1
	BRA         L_main_Serial_Init0
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
; end of main_Serial_Init

main_readKeys:

;keys.h,16 :: 		static inline Keys readKeys()
	MOVF        R0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       R3 
;keys.h,51 :: 		tmp.up    = PORTA.B2 == 1;
	CLRF        R1 
	BTFSC       PORTA+0, 2 
	INCF        R1, 1 
	MOVF        R1, 0 
	XORLW       1
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       R4 
;keys.h,52 :: 		tmp.down  = PORTA.B3 == 1;
	CLRF        R1 
	BTFSC       PORTA+0, 3 
	INCF        R1, 1 
	MOVF        R1, 0 
	XORLW       1
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       R5 
;keys.h,53 :: 		tmp.enter = PORTA.B4 == 1;
	CLRF        R1 
	BTFSC       PORTA+0, 4 
	INCF        R1, 1 
	MOVF        R1, 0 
	XORLW       1
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       R6 
;keys.h,54 :: 		return tmp;
	MOVLW       3
	MOVWF       R0 
	MOVF        R2, 0 
	MOVWF       FSR1L+0 
	MOVF        R3, 0 
	MOVWF       FSR1L+1 
	MOVLW       4
	MOVWF       FSR0L+0 
	MOVLW       0
	MOVWF       FSR0L+1 
L_main_readKeys1:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main_readKeys1
;keys.h,56 :: 		}
L_end_readKeys:
	RETURN      0
; end of main_readKeys

_draw_clear:

;drawglcd.h,33 :: 		void draw_clear()
;drawglcd.h,35 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;drawglcd.h,36 :: 		}
L_end_draw_clear:
	RETURN      0
; end of _draw_clear

_draw_InitFrame:

;drawglcd.h,39 :: 		void draw_InitFrame(){
;drawglcd.h,40 :: 		Glcd_Image(titleFrame);
	MOVLW       _titleFrame+0
	MOVWF       FARG_Glcd_Image_image+0 
	MOVLW       hi_addr(_titleFrame+0)
	MOVWF       FARG_Glcd_Image_image+1 
	MOVLW       higher_addr(_titleFrame+0)
	MOVWF       FARG_Glcd_Image_image+2 
	CALL        _Glcd_Image+0, 0
;drawglcd.h,41 :: 		Delay_ms(4000);
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_draw_InitFrame2:
	DECFSZ      R13, 1, 1
	BRA         L_draw_InitFrame2
	DECFSZ      R12, 1, 1
	BRA         L_draw_InitFrame2
	DECFSZ      R11, 1, 1
	BRA         L_draw_InitFrame2
;drawglcd.h,42 :: 		draw_clear();
	CALL        _draw_clear+0, 0
;drawglcd.h,43 :: 		}
L_end_draw_InitFrame:
	RETURN      0
; end of _draw_InitFrame

_draw_MenuFrame:

;drawglcd.h,45 :: 		void draw_MenuFrame(){
;drawglcd.h,46 :: 		Glcd_Image(menuFrame);
	MOVLW       _menuFrame+0
	MOVWF       FARG_Glcd_Image_image+0 
	MOVLW       hi_addr(_menuFrame+0)
	MOVWF       FARG_Glcd_Image_image+1 
	MOVLW       higher_addr(_menuFrame+0)
	MOVWF       FARG_Glcd_Image_image+2 
	CALL        _Glcd_Image+0, 0
;drawglcd.h,47 :: 		}
L_end_draw_MenuFrame:
	RETURN      0
; end of _draw_MenuFrame

_draw_winFrame:

;drawglcd.h,49 :: 		void draw_winFrame(){
;drawglcd.h,50 :: 		Glcd_Image(winScreen);
	MOVLW       _winScreen+0
	MOVWF       FARG_Glcd_Image_image+0 
	MOVLW       hi_addr(_winScreen+0)
	MOVWF       FARG_Glcd_Image_image+1 
	MOVLW       higher_addr(_winScreen+0)
	MOVWF       FARG_Glcd_Image_image+2 
	CALL        _Glcd_Image+0, 0
;drawglcd.h,51 :: 		Delay_ms(4000);
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_draw_winFrame3:
	DECFSZ      R13, 1, 1
	BRA         L_draw_winFrame3
	DECFSZ      R12, 1, 1
	BRA         L_draw_winFrame3
	DECFSZ      R11, 1, 1
	BRA         L_draw_winFrame3
;drawglcd.h,52 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;drawglcd.h,53 :: 		}
L_end_draw_winFrame:
	RETURN      0
; end of _draw_winFrame

_draw_loseFrame:

;drawglcd.h,55 :: 		void draw_loseFrame(){
;drawglcd.h,56 :: 		Glcd_Image(loseScreen);
	MOVLW       _loseScreen+0
	MOVWF       FARG_Glcd_Image_image+0 
	MOVLW       hi_addr(_loseScreen+0)
	MOVWF       FARG_Glcd_Image_image+1 
	MOVLW       higher_addr(_loseScreen+0)
	MOVWF       FARG_Glcd_Image_image+2 
	CALL        _Glcd_Image+0, 0
;drawglcd.h,57 :: 		Delay_ms(4000);
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_draw_loseFrame4:
	DECFSZ      R13, 1, 1
	BRA         L_draw_loseFrame4
	DECFSZ      R12, 1, 1
	BRA         L_draw_loseFrame4
	DECFSZ      R11, 1, 1
	BRA         L_draw_loseFrame4
;drawglcd.h,58 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;drawglcd.h,59 :: 		}
L_end_draw_loseFrame:
	RETURN      0
; end of _draw_loseFrame

_draw_circle:

;drawglcd.h,62 :: 		void draw_circle(Rect circle, uint8_t color)
;drawglcd.h,65 :: 		Glcd_Circle(circle.x, circle.y, circle.w, color);
	MOVF        FARG_draw_circle_circle+0, 0 
	MOVWF       FARG_Glcd_Circle_x_center+0 
	MOVLW       0
	BTFSC       FARG_draw_circle_circle+0, 7 
	MOVLW       255
	MOVWF       FARG_Glcd_Circle_x_center+1 
	MOVF        FARG_draw_circle_circle+1, 0 
	MOVWF       FARG_Glcd_Circle_y_center+0 
	MOVLW       0
	BTFSC       FARG_draw_circle_circle+1, 7 
	MOVLW       255
	MOVWF       FARG_Glcd_Circle_y_center+1 
	MOVF        FARG_draw_circle_circle+2, 0 
	MOVWF       FARG_Glcd_Circle_radius+0 
	MOVLW       0
	BTFSC       FARG_draw_circle_circle+2, 7 
	MOVLW       255
	MOVWF       FARG_Glcd_Circle_radius+1 
	MOVF        FARG_draw_circle_color+0, 0 
	MOVWF       FARG_Glcd_Circle_color+0 
	CALL        _Glcd_Circle+0, 0
;drawglcd.h,66 :: 		}
L_end_draw_circle:
	RETURN      0
; end of _draw_circle

_draw_dot:

;drawglcd.h,68 :: 		void draw_dot(Splite player, uint8_t color)
;drawglcd.h,70 :: 		Glcd_Dot(player.rect.x, player.rect.y, color);
	MOVF        FARG_draw_dot_player+0, 0 
	MOVWF       FARG_Glcd_Dot_x_pos+0 
	MOVF        FARG_draw_dot_player+1, 0 
	MOVWF       FARG_Glcd_Dot_y_pos+0 
	MOVF        FARG_draw_dot_color+0, 0 
	MOVWF       FARG_Glcd_Dot_color+0 
	CALL        _Glcd_Dot+0, 0
;drawglcd.h,71 :: 		}
L_end_draw_dot:
	RETURN      0
; end of _draw_dot

_draw_horizontal_line:

;drawglcd.h,73 :: 		void draw_horizontal_line(Rect asteroid, uint8_t color)
;drawglcd.h,75 :: 		Glcd_H_Line(asteroid.x, asteroid.x + asteroid.w, asteroid.y,  color);
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
;drawglcd.h,76 :: 		}
L_end_draw_horizontal_line:
	RETURN      0
; end of _draw_horizontal_line

_draw_box:

;drawglcd.h,78 :: 		void draw_box(Rect r, uint8_t color)
;drawglcd.h,81 :: 		Glcd_Box(r.x, r.y, r.x + r.w, r.y + r.h, color);
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
;drawglcd.h,82 :: 		}
L_end_draw_box:
	RETURN      0
; end of _draw_box

_draw_MenuGame:

;drawglcd.h,86 :: 		int draw_MenuGame(uint8_t modeGame)
;drawglcd.h,89 :: 		Rect select = {25, 34, 3, 0};
	MOVLW       25
	MOVWF       draw_MenuGame_select_L0+0 
	MOVLW       34
	MOVWF       draw_MenuGame_select_L0+1 
	MOVLW       3
	MOVWF       draw_MenuGame_select_L0+2 
	CLRF        draw_MenuGame_select_L0+3 
;drawglcd.h,90 :: 		draw_MenuFrame();
	CALL        _draw_MenuFrame+0, 0
;drawglcd.h,91 :: 		draw_circle(select, 1);
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_draw_circle_circle+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_circle_circle+0)
	MOVWF       FSR1L+1 
	MOVLW       draw_MenuGame_select_L0+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(draw_MenuGame_select_L0+0)
	MOVWF       FSR0L+1 
L_draw_MenuGame5:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame5
	MOVLW       1
	MOVWF       FARG_draw_circle_color+0 
	CALL        _draw_circle+0, 0
;drawglcd.h,93 :: 		while (1)
L_draw_MenuGame6:
;drawglcd.h,95 :: 		key = readKeys();
	MOVLW       FLOC__draw_MenuGame+0
	MOVWF       R0 
	MOVLW       hi_addr(FLOC__draw_MenuGame+0)
	MOVWF       R1 
	CALL        main_readKeys+0, 0
	MOVLW       3
	MOVWF       R0 
	MOVLW       draw_MenuGame_key_L0+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(draw_MenuGame_key_L0+0)
	MOVWF       FSR1L+1 
	MOVLW       FLOC__draw_MenuGame+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FLOC__draw_MenuGame+0)
	MOVWF       FSR0L+1 
L_draw_MenuGame8:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame8
;drawglcd.h,97 :: 		if ((key.enter) && (modeGame == 0))
	MOVF        draw_MenuGame_key_L0+2, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_draw_MenuGame11
	MOVF        FARG_draw_MenuGame_modeGame+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame11
L__draw_MenuGame164:
;drawglcd.h,99 :: 		draw_clear();
	CALL        _draw_clear+0, 0
;drawglcd.h,100 :: 		return 2;
	MOVLW       2
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_draw_MenuGame
;drawglcd.h,101 :: 		}
L_draw_MenuGame11:
;drawglcd.h,102 :: 		if ((key.up || key.down)  && (modeGame == 0))
	MOVF        draw_MenuGame_key_L0+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__draw_MenuGame163
	MOVF        draw_MenuGame_key_L0+1, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__draw_MenuGame163
	GOTO        L_draw_MenuGame16
L__draw_MenuGame163:
	MOVF        FARG_draw_MenuGame_modeGame+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame16
L__draw_MenuGame162:
;drawglcd.h,104 :: 		draw_circle(select, 0);
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_draw_circle_circle+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_circle_circle+0)
	MOVWF       FSR1L+1 
	MOVLW       draw_MenuGame_select_L0+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(draw_MenuGame_select_L0+0)
	MOVWF       FSR0L+1 
L_draw_MenuGame17:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame17
	CLRF        FARG_draw_circle_color+0 
	CALL        _draw_circle+0, 0
;drawglcd.h,105 :: 		select.y = select.y + 14;  //offset
	MOVLW       14
	ADDWF       draw_MenuGame_select_L0+1, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       draw_MenuGame_select_L0+1 
;drawglcd.h,106 :: 		draw_circle(select, 1);
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_draw_circle_circle+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_circle_circle+0)
	MOVWF       FSR1L+1 
	MOVLW       draw_MenuGame_select_L0+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(draw_MenuGame_select_L0+0)
	MOVWF       FSR0L+1 
L_draw_MenuGame18:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame18
	MOVLW       1
	MOVWF       FARG_draw_circle_color+0 
	CALL        _draw_circle+0, 0
;drawglcd.h,107 :: 		modeGame = 1;
	MOVLW       1
	MOVWF       FARG_draw_MenuGame_modeGame+0 
;drawglcd.h,108 :: 		Delay_ms(666);
	MOVLW       7
	MOVWF       R11, 0
	MOVLW       194
	MOVWF       R12, 0
	MOVLW       216
	MOVWF       R13, 0
L_draw_MenuGame19:
	DECFSZ      R13, 1, 1
	BRA         L_draw_MenuGame19
	DECFSZ      R12, 1, 1
	BRA         L_draw_MenuGame19
	DECFSZ      R11, 1, 1
	BRA         L_draw_MenuGame19
	NOP
;drawglcd.h,109 :: 		continue;
	GOTO        L_draw_MenuGame6
;drawglcd.h,110 :: 		}
L_draw_MenuGame16:
;drawglcd.h,111 :: 		if ((key.enter) && (modeGame == 1))
	MOVF        draw_MenuGame_key_L0+2, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_draw_MenuGame22
	MOVF        FARG_draw_MenuGame_modeGame+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame22
L__draw_MenuGame161:
;drawglcd.h,113 :: 		draw_clear();
	CALL        _draw_clear+0, 0
;drawglcd.h,114 :: 		return 3;
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_draw_MenuGame
;drawglcd.h,115 :: 		}
L_draw_MenuGame22:
;drawglcd.h,116 :: 		if ((key.up || key.down ) && (modeGame == 1))
	MOVF        draw_MenuGame_key_L0+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__draw_MenuGame160
	MOVF        draw_MenuGame_key_L0+1, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__draw_MenuGame160
	GOTO        L_draw_MenuGame27
L__draw_MenuGame160:
	MOVF        FARG_draw_MenuGame_modeGame+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame27
L__draw_MenuGame159:
;drawglcd.h,118 :: 		draw_circle(select, 0);
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_draw_circle_circle+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_circle_circle+0)
	MOVWF       FSR1L+1 
	MOVLW       draw_MenuGame_select_L0+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(draw_MenuGame_select_L0+0)
	MOVWF       FSR0L+1 
L_draw_MenuGame28:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame28
	CLRF        FARG_draw_circle_color+0 
	CALL        _draw_circle+0, 0
;drawglcd.h,119 :: 		select.y = select.y - 14;  //offset
	MOVLW       14
	SUBWF       draw_MenuGame_select_L0+1, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       draw_MenuGame_select_L0+1 
;drawglcd.h,120 :: 		draw_circle(select, 1);
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_draw_circle_circle+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_circle_circle+0)
	MOVWF       FSR1L+1 
	MOVLW       draw_MenuGame_select_L0+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(draw_MenuGame_select_L0+0)
	MOVWF       FSR0L+1 
L_draw_MenuGame29:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame29
	MOVLW       1
	MOVWF       FARG_draw_circle_color+0 
	CALL        _draw_circle+0, 0
;drawglcd.h,121 :: 		modeGame = 0;
	CLRF        FARG_draw_MenuGame_modeGame+0 
;drawglcd.h,122 :: 		Delay_ms(666);
	MOVLW       7
	MOVWF       R11, 0
	MOVLW       194
	MOVWF       R12, 0
	MOVLW       216
	MOVWF       R13, 0
L_draw_MenuGame30:
	DECFSZ      R13, 1, 1
	BRA         L_draw_MenuGame30
	DECFSZ      R12, 1, 1
	BRA         L_draw_MenuGame30
	DECFSZ      R11, 1, 1
	BRA         L_draw_MenuGame30
	NOP
;drawglcd.h,123 :: 		}
L_draw_MenuGame27:
;drawglcd.h,124 :: 		}
	GOTO        L_draw_MenuGame6
;drawglcd.h,125 :: 		}
L_end_draw_MenuGame:
	RETURN      0
; end of _draw_MenuGame

_draw_partial_image:

;drawglcd.h,128 :: 		void draw_partial_image(Rect player, code const unsigned short * image)
;drawglcd.h,132 :: 		Glcd_PartialImage(player.x, player.y, player.w, player.h, player.w, player.h, image);
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
;drawglcd.h,133 :: 		}
L_end_draw_partial_image:
	RETURN      0
; end of _draw_partial_image

_draw_text:

;drawglcd.h,135 :: 		void draw_text(char *text, uint8_t x)
;drawglcd.h,137 :: 		Glcd_Write_Text(text, x, 7, 1);
	MOVF        FARG_draw_text_text+0, 0 
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVF        FARG_draw_text_text+1, 0 
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVF        FARG_draw_text_x+0, 0 
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       7
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;drawglcd.h,138 :: 		}
L_end_draw_text:
	RETURN      0
; end of _draw_text

_draw_score:

;drawglcd.h,140 :: 		void draw_score(uint8_t a, uint8_t b){ //function to draw the score
;drawglcd.h,143 :: 		ShortToStr(a, score_text);
	MOVF        FARG_draw_score_a+0, 0 
	MOVWF       FARG_ShortToStr_input+0 
	MOVLW       _score_text+0
	MOVWF       FARG_ShortToStr_output+0 
	MOVLW       hi_addr(_score_text+0)
	MOVWF       FARG_ShortToStr_output+1 
	CALL        _ShortToStr+0, 0
;drawglcd.h,144 :: 		fix_text = Ltrim(score_text);
	MOVLW       _score_text+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(_score_text+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
;drawglcd.h,145 :: 		Glcd_Write_Text(fix_text, 15, 7, 1);
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
;drawglcd.h,146 :: 		ShortToStr(b, score_text);
	MOVF        FARG_draw_score_b+0, 0 
	MOVWF       FARG_ShortToStr_input+0 
	MOVLW       _score_text+0
	MOVWF       FARG_ShortToStr_output+0 
	MOVLW       hi_addr(_score_text+0)
	MOVWF       FARG_ShortToStr_output+1 
	CALL        _ShortToStr+0, 0
;drawglcd.h,147 :: 		fix_text = Ltrim(score_text);
	MOVLW       _score_text+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(_score_text+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
;drawglcd.h,148 :: 		Glcd_Write_Text(fix_text, 107, 7, 1);
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
;drawglcd.h,149 :: 		}
L_end_draw_score:
	RETURN      0
; end of _draw_score

main_check_collision00:

;hit.h,18 :: 		static inline bool check_collision00(Rect rect1, Rect rect2)
;hit.h,20 :: 		return rect1.x < rect2.x + rect2.w &&
	MOVF        FARG_main_check_collision00_rect2+2, 0 
	ADDWF       FARG_main_check_collision00_rect2+0, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       FARG_main_check_collision00_rect2+0, 7 
	MOVLW       255
	MOVWF       R2 
	MOVLW       0
	BTFSC       FARG_main_check_collision00_rect2+2, 7 
	MOVLW       255
	ADDWFC      R2, 1 
;hit.h,21 :: 		rect1.x + rect1.w > rect2.x &&
	MOVLW       128
	BTFSC       FARG_main_check_collision00_rect1+0, 7 
	MOVLW       127
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main_check_collision00182
	MOVF        R1, 0 
	SUBWF       FARG_main_check_collision00_rect1+0, 0 
L_main_check_collision00182:
	BTFSC       STATUS+0, 0 
	GOTO        L_main_check_collision0032
	MOVF        FARG_main_check_collision00_rect1+2, 0 
	ADDWF       FARG_main_check_collision00_rect1+0, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       FARG_main_check_collision00_rect1+0, 7 
	MOVLW       255
	MOVWF       R2 
	MOVLW       0
	BTFSC       FARG_main_check_collision00_rect1+2, 7 
	MOVLW       255
	ADDWFC      R2, 1 
	MOVLW       128
	BTFSC       FARG_main_check_collision00_rect2+0, 7 
	MOVLW       127
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main_check_collision00183
	MOVF        R1, 0 
	SUBWF       FARG_main_check_collision00_rect2+0, 0 
L_main_check_collision00183:
	BTFSC       STATUS+0, 0 
	GOTO        L_main_check_collision0032
;hit.h,22 :: 		rect1.y < rect2.y + rect2.h &&
	MOVF        FARG_main_check_collision00_rect2+3, 0 
	ADDWF       FARG_main_check_collision00_rect2+1, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       FARG_main_check_collision00_rect2+1, 7 
	MOVLW       255
	MOVWF       R2 
	MOVLW       0
	BTFSC       FARG_main_check_collision00_rect2+3, 7 
	MOVLW       255
	ADDWFC      R2, 1 
	MOVLW       128
	BTFSC       FARG_main_check_collision00_rect1+1, 7 
	MOVLW       127
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main_check_collision00184
	MOVF        R1, 0 
	SUBWF       FARG_main_check_collision00_rect1+1, 0 
L_main_check_collision00184:
	BTFSC       STATUS+0, 0 
	GOTO        L_main_check_collision0032
;hit.h,23 :: 		rect1.h + rect1.y > rect2.y;
	MOVF        FARG_main_check_collision00_rect1+1, 0 
	ADDWF       FARG_main_check_collision00_rect1+3, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       FARG_main_check_collision00_rect1+3, 7 
	MOVLW       255
	MOVWF       R2 
	MOVLW       0
	BTFSC       FARG_main_check_collision00_rect1+1, 7 
	MOVLW       255
	ADDWFC      R2, 1 
	MOVLW       128
	BTFSC       FARG_main_check_collision00_rect2+1, 7 
	MOVLW       127
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main_check_collision00185
	MOVF        R1, 0 
	SUBWF       FARG_main_check_collision00_rect2+1, 0 
L_main_check_collision00185:
	BTFSC       STATUS+0, 0 
	GOTO        L_main_check_collision0032
	MOVLW       1
	MOVWF       R0 
	GOTO        L_main_check_collision0031
L_main_check_collision0032:
	CLRF        R0 
L_main_check_collision0031:
;hit.h,24 :: 		}
L_end_check_collision00:
	RETURN      0
; end of main_check_collision00

_check_collision:

;hit.h,27 :: 		bool check_collision(Rect asteroid, Rect player)
;hit.h,29 :: 		return check_collision00(asteroid, player);
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_main_check_collision00_rect1+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_main_check_collision00_rect1+0)
	MOVWF       FSR1L+1 
	MOVLW       FARG_check_collision_asteroid+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FARG_check_collision_asteroid+0)
	MOVWF       FSR0L+1 
L_check_collision33:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_check_collision33
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_main_check_collision00_rect2+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_main_check_collision00_rect2+0)
	MOVWF       FSR1L+1 
	MOVLW       FARG_check_collision_player+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FARG_check_collision_player+0)
	MOVWF       FSR0L+1 
L_check_collision34:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_check_collision34
	CALL        main_check_collision00+0, 0
;hit.h,30 :: 		}
L_end_check_collision:
	RETURN      0
; end of _check_collision

_move_player:

;hit.h,34 :: 		Splite move_player(Splite player, Rect *a)
	MOVF        R0, 0 
	MOVWF       _move_player_su_addr+0 
	MOVF        R1, 0 
	MOVWF       _move_player_su_addr+1 
;hit.h,38 :: 		key = readKeys();
	MOVLW       FLOC__move_player+0
	MOVWF       R0 
	MOVLW       hi_addr(FLOC__move_player+0)
	MOVWF       R1 
	CALL        main_readKeys+0, 0
	MOVLW       3
	MOVWF       R0 
	MOVLW       move_player_key_L0+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(move_player_key_L0+0)
	MOVWF       FSR1L+1 
	MOVLW       FLOC__move_player+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FLOC__move_player+0)
	MOVWF       FSR0L+1 
L_move_player35:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_move_player35
;hit.h,40 :: 		for (i = 0; i <= NUM_ASTEROIDS - 1; i++){
	CLRF        move_player_i_L0+0 
L_move_player36:
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__move_player188
	MOVF        move_player_i_L0+0, 0 
	SUBLW       12
L__move_player188:
	BTFSS       STATUS+0, 0 
	GOTO        L_move_player37
;hit.h,41 :: 		if (check_collision(a[i], player.rect))
	MOVF        move_player_i_L0+0, 0 
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
	ADDWF       FARG_move_player_a+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_move_player_a+1, 0 
	MOVWF       FSR0L+1 
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_check_collision_asteroid+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_check_collision_asteroid+0)
	MOVWF       FSR1L+1 
L_move_player39:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_move_player39
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_check_collision_player+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_check_collision_player+0)
	MOVWF       FSR1L+1 
	MOVLW       FARG_move_player_player+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FARG_move_player_player+0)
	MOVWF       FSR0L+1 
L_move_player40:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_move_player40
	CALL        _check_collision+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_move_player41
;hit.h,43 :: 		player.rect.x = 32;
	MOVLW       32
	MOVWF       FARG_move_player_player+0 
;hit.h,44 :: 		player.rect.y = 55;
	MOVLW       55
	MOVWF       FARG_move_player_player+1 
;hit.h,45 :: 		return player;
	MOVLW       6
	MOVWF       R0 
	MOVF        _move_player_su_addr+0, 0 
	MOVWF       FSR1L+0 
	MOVF        _move_player_su_addr+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       FARG_move_player_player+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FARG_move_player_player+0)
	MOVWF       FSR0L+1 
L_move_player42:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_move_player42
	GOTO        L_end_move_player
;hit.h,46 :: 		}
L_move_player41:
;hit.h,40 :: 		for (i = 0; i <= NUM_ASTEROIDS - 1; i++){
	INCF        move_player_i_L0+0, 1 
;hit.h,48 :: 		}
	GOTO        L_move_player36
L_move_player37:
;hit.h,53 :: 		if (key.down){
	MOVF        move_player_key_L0+1, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_move_player43
;hit.h,54 :: 		player.rect.y += player.vel.dy;
	MOVF        FARG_move_player_player+5, 0 
	ADDWF       FARG_move_player_player+1, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	MOVWF       FARG_move_player_player+1 
;hit.h,56 :: 		if (player.rect.y + (player.rect.h - 1) >= 63){
	DECF        FARG_move_player_player+3, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       FARG_move_player_player+3, 7 
	MOVLW       255
	MOVWF       R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVF        R2, 0 
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       0
	BTFSC       R2, 7 
	MOVLW       255
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVLW       128
	XORWF       R3, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__move_player189
	MOVLW       63
	SUBWF       R2, 0 
L__move_player189:
	BTFSS       STATUS+0, 0 
	GOTO        L_move_player44
;hit.h,57 :: 		player.rect.y = 55;
	MOVLW       55
	MOVWF       FARG_move_player_player+1 
;hit.h,58 :: 		}
L_move_player44:
;hit.h,59 :: 		}
	GOTO        L_move_player45
L_move_player43:
;hit.h,61 :: 		else if (key.up){
	MOVF        move_player_key_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_move_player46
;hit.h,62 :: 		player.rect.y -= player.vel.dy;
	MOVF        FARG_move_player_player+5, 0 
	SUBWF       FARG_move_player_player+1, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       FARG_move_player_player+1 
;hit.h,63 :: 		if (player.rect.y <= 0){
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	XORWF       R1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_move_player47
;hit.h,64 :: 		player.rect.x = 32;
	MOVLW       32
	MOVWF       FARG_move_player_player+0 
;hit.h,65 :: 		player.rect.y = 55;
	MOVLW       55
	MOVWF       FARG_move_player_player+1 
;hit.h,66 :: 		scoreA++;
	INCF        _scoreA+0, 1 
;hit.h,67 :: 		draw_score(scoreA, scoreB);
	MOVF        _scoreA+0, 0 
	MOVWF       FARG_draw_score_a+0 
	MOVF        _scoreB+0, 0 
	MOVWF       FARG_draw_score_b+0 
	CALL        _draw_score+0, 0
;hit.h,69 :: 		return player;
	MOVLW       6
	MOVWF       R0 
	MOVF        _move_player_su_addr+0, 0 
	MOVWF       FSR1L+0 
	MOVF        _move_player_su_addr+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       FARG_move_player_player+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FARG_move_player_player+0)
	MOVWF       FSR0L+1 
L_move_player48:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_move_player48
	GOTO        L_end_move_player
;hit.h,70 :: 		}
L_move_player47:
;hit.h,71 :: 		}
	GOTO        L_move_player49
L_move_player46:
;hit.h,73 :: 		return player;
	MOVLW       6
	MOVWF       R0 
	MOVF        _move_player_su_addr+0, 0 
	MOVWF       FSR1L+0 
	MOVF        _move_player_su_addr+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       FARG_move_player_player+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FARG_move_player_player+0)
	MOVWF       FSR0L+1 
L_move_player50:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_move_player50
	GOTO        L_end_move_player
;hit.h,74 :: 		}
L_move_player49:
L_move_player45:
;hit.h,77 :: 		return player;
	MOVLW       6
	MOVWF       R0 
	MOVF        _move_player_su_addr+0, 0 
	MOVWF       FSR1L+0 
	MOVF        _move_player_su_addr+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       FARG_move_player_player+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FARG_move_player_player+0)
	MOVWF       FSR0L+1 
L_move_player51:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_move_player51
;hit.h,79 :: 		}
L_end_move_player:
	RETURN      0
; end of _move_player

_move_ai:

;hit.h,81 :: 		Splite move_ai(Splite pc, Rect *a)
	MOVF        R0, 0 
	MOVWF       _move_ai_su_addr+0 
	MOVF        R1, 0 
	MOVWF       _move_ai_su_addr+1 
;hit.h,84 :: 		luck = randint(0, 200);
	CLRF        FARG_randint_min+0 
	CLRF        FARG_randint_min+1 
	MOVLW       200
	MOVWF       FARG_randint_max+0 
	MOVLW       0
	MOVWF       FARG_randint_max+1 
	CALL        _randint+0, 0
	MOVF        R0, 0 
	MOVWF       move_ai_luck_L0+0 
;hit.h,85 :: 		for (i = 0; i < NUM_ASTEROIDS; i++)
	CLRF        move_ai_i_L0+0 
L_move_ai52:
	MOVLW       13
	SUBWF       move_ai_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_move_ai53
;hit.h,88 :: 		if (check_collision(a[i], pc.rect))
	MOVF        move_ai_i_L0+0, 0 
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
	ADDWF       FARG_move_ai_a+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_move_ai_a+1, 0 
	MOVWF       FSR0L+1 
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_check_collision_asteroid+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_check_collision_asteroid+0)
	MOVWF       FSR1L+1 
L_move_ai55:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_move_ai55
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_check_collision_player+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_check_collision_player+0)
	MOVWF       FSR1L+1 
	MOVLW       FARG_move_ai_pc+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FARG_move_ai_pc+0)
	MOVWF       FSR0L+1 
L_move_ai56:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_move_ai56
	CALL        _check_collision+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_move_ai57
;hit.h,90 :: 		pc.rect.x = 94;
	MOVLW       94
	MOVWF       FARG_move_ai_pc+0 
;hit.h,91 :: 		pc.rect.y = 55;
	MOVLW       55
	MOVWF       FARG_move_ai_pc+1 
;hit.h,92 :: 		return pc;
	MOVLW       6
	MOVWF       R0 
	MOVF        _move_ai_su_addr+0, 0 
	MOVWF       FSR1L+0 
	MOVF        _move_ai_su_addr+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       FARG_move_ai_pc+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FARG_move_ai_pc+0)
	MOVWF       FSR0L+1 
L_move_ai58:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_move_ai58
	GOTO        L_end_move_ai
;hit.h,93 :: 		}
L_move_ai57:
;hit.h,85 :: 		for (i = 0; i < NUM_ASTEROIDS; i++)
	INCF        move_ai_i_L0+0, 1 
;hit.h,94 :: 		}
	GOTO        L_move_ai52
L_move_ai53:
;hit.h,97 :: 		if (luck > 185)
	MOVF        move_ai_luck_L0+0, 0 
	SUBLW       185
	BTFSC       STATUS+0, 0 
	GOTO        L_move_ai59
;hit.h,99 :: 		pc.rect.y += pc.vel.dy;
	MOVF        FARG_move_ai_pc+5, 0 
	ADDWF       FARG_move_ai_pc+1, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       FARG_move_ai_pc+1 
;hit.h,100 :: 		return pc;
	MOVLW       6
	MOVWF       R0 
	MOVF        _move_ai_su_addr+0, 0 
	MOVWF       FSR1L+0 
	MOVF        _move_ai_su_addr+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       FARG_move_ai_pc+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FARG_move_ai_pc+0)
	MOVWF       FSR0L+1 
L_move_ai60:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_move_ai60
	GOTO        L_end_move_ai
;hit.h,101 :: 		}
L_move_ai59:
;hit.h,103 :: 		else if (luck < 15)
	MOVLW       15
	SUBWF       move_ai_luck_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_move_ai62
;hit.h,105 :: 		pc.rect.y -= pc.vel.dy;
	MOVF        FARG_move_ai_pc+5, 0 
	SUBWF       FARG_move_ai_pc+1, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       FARG_move_ai_pc+1 
;hit.h,106 :: 		return pc;
	MOVLW       6
	MOVWF       R0 
	MOVF        _move_ai_su_addr+0, 0 
	MOVWF       FSR1L+0 
	MOVF        _move_ai_su_addr+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       FARG_move_ai_pc+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FARG_move_ai_pc+0)
	MOVWF       FSR0L+1 
L_move_ai63:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_move_ai63
	GOTO        L_end_move_ai
;hit.h,107 :: 		}
L_move_ai62:
;hit.h,112 :: 		pc.rect.y -= pc.vel.dy;
	MOVF        FARG_move_ai_pc+5, 0 
	SUBWF       FARG_move_ai_pc+1, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       FARG_move_ai_pc+1 
;hit.h,114 :: 		if (pc.rect.y <= 0)
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	XORWF       R1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_move_ai64
;hit.h,116 :: 		pc.rect.x = 94;
	MOVLW       94
	MOVWF       FARG_move_ai_pc+0 
;hit.h,117 :: 		pc.rect.y = 55;
	MOVLW       55
	MOVWF       FARG_move_ai_pc+1 
;hit.h,118 :: 		scoreB++;
	INCF        _scoreB+0, 1 
;hit.h,119 :: 		draw_score(scoreA, scoreB);
	MOVF        _scoreA+0, 0 
	MOVWF       FARG_draw_score_a+0 
	MOVF        _scoreB+0, 0 
	MOVWF       FARG_draw_score_b+0 
	CALL        _draw_score+0, 0
;hit.h,120 :: 		return pc;
	MOVLW       6
	MOVWF       R0 
	MOVF        _move_ai_su_addr+0, 0 
	MOVWF       FSR1L+0 
	MOVF        _move_ai_su_addr+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       FARG_move_ai_pc+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FARG_move_ai_pc+0)
	MOVWF       FSR0L+1 
L_move_ai65:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_move_ai65
	GOTO        L_end_move_ai
;hit.h,121 :: 		}
L_move_ai64:
;hit.h,123 :: 		else if (pc.rect.y + (pc.rect.h - 1) >= 63){
	DECF        FARG_move_ai_pc+3, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       FARG_move_ai_pc+3, 7 
	MOVLW       255
	MOVWF       R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVF        FARG_move_ai_pc+1, 0 
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       0
	BTFSC       FARG_move_ai_pc+1, 7 
	MOVLW       255
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVLW       128
	XORWF       R3, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__move_ai191
	MOVLW       63
	SUBWF       R2, 0 
L__move_ai191:
	BTFSS       STATUS+0, 0 
	GOTO        L_move_ai67
;hit.h,124 :: 		pc.rect.y = 55;
	MOVLW       55
	MOVWF       FARG_move_ai_pc+1 
;hit.h,125 :: 		return pc;
	MOVLW       6
	MOVWF       R0 
	MOVF        _move_ai_su_addr+0, 0 
	MOVWF       FSR1L+0 
	MOVF        _move_ai_su_addr+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       FARG_move_ai_pc+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FARG_move_ai_pc+0)
	MOVWF       FSR0L+1 
L_move_ai68:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_move_ai68
	GOTO        L_end_move_ai
;hit.h,126 :: 		}
L_move_ai67:
;hit.h,130 :: 		return pc;
	MOVLW       6
	MOVWF       R0 
	MOVF        _move_ai_su_addr+0, 0 
	MOVWF       FSR1L+0 
	MOVF        _move_ai_su_addr+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       FARG_move_ai_pc+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FARG_move_ai_pc+0)
	MOVWF       FSR0L+1 
L_move_ai70:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_move_ai70
;hit.h,132 :: 		}
L_end_move_ai:
	RETURN      0
; end of _move_ai

_initEnvironment:

;hit.h,136 :: 		void initEnvironment(Rect *s)
;hit.h,139 :: 		offset_y = 53;
	MOVLW       53
	MOVWF       initEnvironment_offset_y_L0+0 
;hit.h,140 :: 		for (i = 0; i < NUM_ASTEROIDS; i++)
	CLRF        initEnvironment_i_L0+0 
L_initEnvironment71:
	MOVLW       13
	SUBWF       initEnvironment_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_initEnvironment72
;hit.h,142 :: 		offset_x = randint(0, 123);
	CLRF        FARG_randint_min+0 
	CLRF        FARG_randint_min+1 
	MOVLW       123
	MOVWF       FARG_randint_max+0 
	MOVLW       0
	MOVWF       FARG_randint_max+1 
	CALL        _randint+0, 0
;hit.h,143 :: 		s[i].x = offset_x;
	MOVF        initEnvironment_i_L0+0, 0 
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
	ADDWF       FARG_initEnvironment_s+0, 0 
	MOVWF       FSR1L+0 
	MOVF        R3, 0 
	ADDWFC      FARG_initEnvironment_s+1, 0 
	MOVWF       FSR1L+1 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;hit.h,144 :: 		s[i].y = offset_y;
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
;hit.h,145 :: 		s[i].w = 3;
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
;hit.h,146 :: 		s[i].h = 1;
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
;hit.h,149 :: 		offset_y = offset_y - 4;
	MOVLW       4
	SUBWF       initEnvironment_offset_y_L0+0, 1 
;hit.h,140 :: 		for (i = 0; i < NUM_ASTEROIDS; i++)
	INCF        initEnvironment_i_L0+0, 1 
;hit.h,150 :: 		}
	GOTO        L_initEnvironment71
L_initEnvironment72:
;hit.h,151 :: 		}
L_end_initEnvironment:
	RETURN      0
; end of _initEnvironment

_environment:

;hit.h,154 :: 		void environment(Rect *s)
;hit.h,157 :: 		for (i = 0; i < NUM_ASTEROIDS; i++)
	CLRF        environment_i_L0+0 
L_environment74:
	MOVLW       13
	SUBWF       environment_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_environment75
;hit.h,159 :: 		draw_horizontal_line(s[i], ERASE);
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
L_environment77:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_environment77
	CLRF        FARG_draw_horizontal_line_color+0 
	CALL        _draw_horizontal_line+0, 0
;hit.h,161 :: 		if ((i % 2) == 1)
	MOVLW       1
	ANDWF       environment_i_L0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_environment78
;hit.h,163 :: 		if (s[i].x <= 0)
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
	GOTO        L_environment79
;hit.h,165 :: 		s[i].x = 124;
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
;hit.h,166 :: 		}
L_environment79:
;hit.h,167 :: 		s[i].x--;
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
;hit.h,168 :: 		}
	GOTO        L_environment80
L_environment78:
;hit.h,171 :: 		if (s[i].x >= 124)
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
	GOTO        L_environment81
;hit.h,173 :: 		s[i].x = 0;
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
;hit.h,174 :: 		}
L_environment81:
;hit.h,175 :: 		s[i].x++;
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
;hit.h,176 :: 		}
L_environment80:
;hit.h,177 :: 		draw_horizontal_line(s[i], DRAW);
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
L_environment82:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_environment82
	MOVLW       1
	MOVWF       FARG_draw_horizontal_line_color+0 
	CALL        _draw_horizontal_line+0, 0
;hit.h,157 :: 		for (i = 0; i < NUM_ASTEROIDS; i++)
	INCF        environment_i_L0+0, 1 
;hit.h,179 :: 		}
	GOTO        L_environment74
L_environment75:
;hit.h,181 :: 		}
L_end_environment:
	RETURN      0
; end of _environment

_init_game:

;main.c,38 :: 		void init_game()
;main.c,41 :: 		scoreA = 0;
	CLRF        _scoreA+0 
;main.c,42 :: 		scoreB = 0;
	CLRF        _scoreB+0 
;main.c,43 :: 		timeFlag = 0;
	CLRF        _timeFlag+0 
;main.c,44 :: 		contador_ms = 0;
	CLRF        _contador_ms+0 
;main.c,45 :: 		modeGame = 0;
	CLRF        _modeGame+0 
;main.c,47 :: 		playerOne.rect.x = 32;
	MOVLW       32
	MOVWF       _playerOne+0 
;main.c,48 :: 		playerOne.rect.y = 55;
	MOVLW       55
	MOVWF       _playerOne+1 
;main.c,49 :: 		playerOne.rect.w = 9;
	MOVLW       9
	MOVWF       _playerOne+2 
;main.c,50 :: 		playerOne.rect.h = 9;
	MOVLW       9
	MOVWF       _playerOne+3 
;main.c,51 :: 		playerOne.vel.dx = 0;
	CLRF        _playerOne+4 
;main.c,52 :: 		playerOne.vel.dy = 1;
	MOVLW       1
	MOVWF       _playerOne+5 
;main.c,54 :: 		playerPC.rect.x = 94;
	MOVLW       94
	MOVWF       _playerPC+0 
;main.c,55 :: 		playerPC.rect.y = 55;
	MOVLW       55
	MOVWF       _playerPC+1 
;main.c,56 :: 		playerPC.rect.w = 9;
	MOVLW       9
	MOVWF       _playerPC+2 
;main.c,57 :: 		playerPC.rect.h = 9;
	MOVLW       9
	MOVWF       _playerPC+3 
;main.c,58 :: 		playerPC.vel.dx = 0;
	CLRF        _playerPC+4 
;main.c,59 :: 		playerPC.vel.dy = 1;
	MOVLW       1
	MOVWF       _playerPC+5 
;main.c,61 :: 		playerTwo = playerPC;
	MOVLW       6
	MOVWF       R0 
	MOVLW       _playerTwo+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_playerTwo+0)
	MOVWF       FSR1L+1 
	MOVLW       _playerPC+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_playerPC+0)
	MOVWF       FSR0L+1 
L_init_game83:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_init_game83
;main.c,63 :: 		timer.x = 62;
	MOVLW       62
	MOVWF       _timer+0 
;main.c,64 :: 		timer.y = 3;
	MOVLW       3
	MOVWF       _timer+1 
;main.c,65 :: 		timer.w = 1;
	MOVLW       1
	MOVWF       _timer+2 
;main.c,66 :: 		timer.h = 60;
	MOVLW       60
	MOVWF       _timer+3 
;main.c,68 :: 		initEnvironment(m);
	MOVLW       _m+0
	MOVWF       FARG_initEnvironment_s+0 
	MOVLW       hi_addr(_m+0)
	MOVWF       FARG_initEnvironment_s+1 
	CALL        _initEnvironment+0, 0
;main.c,69 :: 		}
L_end_init_game:
	RETURN      0
; end of _init_game

_updateGameTime:

;main.c,73 :: 		void updateGameTime(Rect *t)
;main.c,76 :: 		if (t->y >= 63)
	MOVLW       1
	ADDWF       FARG_updateGameTime_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_updateGameTime_t+1, 0 
	MOVWF       FSR0L+1 
	MOVLW       128
	XORWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       63
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_updateGameTime84
;main.c,78 :: 		if (scoreA > scoreB)
	MOVF        _scoreA+0, 0 
	SUBWF       _scoreB+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_updateGameTime85
;main.c,80 :: 		draw_winFrame();
	CALL        _draw_winFrame+0, 0
;main.c,81 :: 		init_game();
	CALL        _init_game+0, 0
;main.c,82 :: 		state = MENU;
	MOVLW       1
	MOVWF       _state+0 
;main.c,83 :: 		}
	GOTO        L_updateGameTime86
L_updateGameTime85:
;main.c,85 :: 		else if (scoreB > scoreA)
	MOVF        _scoreB+0, 0 
	SUBWF       _scoreA+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_updateGameTime87
;main.c,87 :: 		draw_loseFrame();
	CALL        _draw_loseFrame+0, 0
;main.c,88 :: 		init_game();
	CALL        _init_game+0, 0
;main.c,89 :: 		state = MENU;
	MOVLW       1
	MOVWF       _state+0 
;main.c,90 :: 		}
L_updateGameTime87:
L_updateGameTime86:
;main.c,94 :: 		}
L_updateGameTime84:
;main.c,97 :: 		if (timeFlag)
	MOVF        _timeFlag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_updateGameTime88
;main.c,99 :: 		t->y++;
	MOVLW       1
	ADDWF       FARG_updateGameTime_t+0, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      FARG_updateGameTime_t+1, 0 
	MOVWF       R2 
	MOVFF       R1, FSR0L+0
	MOVFF       R2, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	INCF        R0, 1 
	MOVFF       R1, FSR1L+0
	MOVFF       R2, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;main.c,100 :: 		timeFlag = 0;
	CLRF        _timeFlag+0 
;main.c,101 :: 		}
L_updateGameTime88:
;main.c,103 :: 		}
L_end_updateGameTime:
	RETURN      0
; end of _updateGameTime

_syncGame:

;main.c,109 :: 		void syncGame()
;main.c,113 :: 		while (1)
L_syncGame89:
;main.c,115 :: 		Serial_Write(&SendInit, 2);
	MOVLW       _SendInit+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_SendInit+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       2
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;main.c,117 :: 		n = Serial_available();
	CALL        _Serial_available+0, 0
;main.c,119 :: 		if (n > 2)
	MOVLW       128
	MOVWF       R2 
	MOVLW       128
	XORWF       R1, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__syncGame197
	MOVF        R0, 0 
	SUBLW       2
L__syncGame197:
	BTFSC       STATUS+0, 0 
	GOTO        L_syncGame91
;main.c,121 :: 		Serial_Read(&mark, 2);
	MOVLW       syncGame_mark_L0+0
	MOVWF       FARG_Serial_Read_buf+0 
	MOVLW       hi_addr(syncGame_mark_L0+0)
	MOVWF       FARG_Serial_Read_buf+1 
	MOVLW       2
	MOVWF       FARG_Serial_Read_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Read_n+1 
	CALL        _Serial_Read+0, 0
;main.c,123 :: 		if (mark == SendAck)
	MOVF        syncGame_mark_L0+1, 0 
	XORWF       _SendAck+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__syncGame198
	MOVF        _SendAck+0, 0 
	XORWF       syncGame_mark_L0+0, 0 
L__syncGame198:
	BTFSS       STATUS+0, 2 
	GOTO        L_syncGame92
;main.c,125 :: 		break;
	GOTO        L_syncGame90
;main.c,126 :: 		}
L_syncGame92:
;main.c,128 :: 		Serial_clear();
	CALL        _Serial_clear+0, 0
;main.c,129 :: 		}
L_syncGame91:
;main.c,131 :: 		Delay_ms(200);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_syncGame93:
	DECFSZ      R13, 1, 1
	BRA         L_syncGame93
	DECFSZ      R12, 1, 1
	BRA         L_syncGame93
	DECFSZ      R11, 1, 1
	BRA         L_syncGame93
;main.c,134 :: 		}
	GOTO        L_syncGame89
L_syncGame90:
;main.c,136 :: 		}
L_end_syncGame:
	RETURN      0
; end of _syncGame

_moveAndCheckAsteroids:

;main.c,143 :: 		void moveAndCheckAsteroids(Rect *s)
;main.c,146 :: 		for (i = 0; i < NUM_ASTEROIDS; i++)
	CLRF        moveAndCheckAsteroids_i_L0+0 
L_moveAndCheckAsteroids94:
	MOVLW       13
	SUBWF       moveAndCheckAsteroids_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_moveAndCheckAsteroids95
;main.c,148 :: 		if (check_collision(s[i], playerOne.rect))
	MOVF        moveAndCheckAsteroids_i_L0+0, 0 
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
	ADDWF       FARG_moveAndCheckAsteroids_s+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_moveAndCheckAsteroids_s+1, 0 
	MOVWF       FSR0L+1 
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_check_collision_asteroid+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_check_collision_asteroid+0)
	MOVWF       FSR1L+1 
L_moveAndCheckAsteroids97:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_moveAndCheckAsteroids97
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_check_collision_player+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_check_collision_player+0)
	MOVWF       FSR1L+1 
	MOVLW       _playerOne+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_playerOne+0)
	MOVWF       FSR0L+1 
L_moveAndCheckAsteroids98:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_moveAndCheckAsteroids98
	CALL        _check_collision+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_moveAndCheckAsteroids99
;main.c,150 :: 		playerOne.rect.y = 55;
	MOVLW       55
	MOVWF       _playerOne+1 
;main.c,151 :: 		Serial_Write(&SendPlayer, 2);
	MOVLW       _SendPlayer+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_SendPlayer+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       2
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;main.c,152 :: 		Serial_Write(&playerOne.rect, sizeof(Rect));
	MOVLW       _playerOne+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_playerOne+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       4
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;main.c,153 :: 		}
L_moveAndCheckAsteroids99:
;main.c,155 :: 		draw_horizontal_line(s[i], ERASE);
	MOVF        moveAndCheckAsteroids_i_L0+0, 0 
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
	ADDWF       FARG_moveAndCheckAsteroids_s+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_moveAndCheckAsteroids_s+1, 0 
	MOVWF       FSR0L+1 
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_draw_horizontal_line_asteroid+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_horizontal_line_asteroid+0)
	MOVWF       FSR1L+1 
L_moveAndCheckAsteroids100:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_moveAndCheckAsteroids100
	CLRF        FARG_draw_horizontal_line_color+0 
	CALL        _draw_horizontal_line+0, 0
;main.c,157 :: 		if ((i % 2) == 1)
	MOVLW       1
	ANDWF       moveAndCheckAsteroids_i_L0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_moveAndCheckAsteroids101
;main.c,159 :: 		if (s[i].x <= 0)
	MOVF        moveAndCheckAsteroids_i_L0+0, 0 
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
	ADDWF       FARG_moveAndCheckAsteroids_s+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_moveAndCheckAsteroids_s+1, 0 
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
	GOTO        L_moveAndCheckAsteroids102
;main.c,161 :: 		s[i].x = 124;
	MOVF        moveAndCheckAsteroids_i_L0+0, 0 
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
	ADDWF       FARG_moveAndCheckAsteroids_s+0, 0 
	MOVWF       FSR1L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_moveAndCheckAsteroids_s+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       124
	MOVWF       POSTINC1+0 
;main.c,162 :: 		}
L_moveAndCheckAsteroids102:
;main.c,163 :: 		s[i].x--;
	MOVF        moveAndCheckAsteroids_i_L0+0, 0 
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
	ADDWF       FARG_moveAndCheckAsteroids_s+0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	ADDWFC      FARG_moveAndCheckAsteroids_s+1, 0 
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
;main.c,164 :: 		}
	GOTO        L_moveAndCheckAsteroids103
L_moveAndCheckAsteroids101:
;main.c,167 :: 		if (s[i].x >= 124)
	MOVF        moveAndCheckAsteroids_i_L0+0, 0 
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
	ADDWF       FARG_moveAndCheckAsteroids_s+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_moveAndCheckAsteroids_s+1, 0 
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
	GOTO        L_moveAndCheckAsteroids104
;main.c,169 :: 		s[i].x = 0;
	MOVF        moveAndCheckAsteroids_i_L0+0, 0 
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
	ADDWF       FARG_moveAndCheckAsteroids_s+0, 0 
	MOVWF       FSR1L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_moveAndCheckAsteroids_s+1, 0 
	MOVWF       FSR1L+1 
	CLRF        POSTINC1+0 
;main.c,170 :: 		}
L_moveAndCheckAsteroids104:
;main.c,171 :: 		s[i].x++;
	MOVF        moveAndCheckAsteroids_i_L0+0, 0 
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
	ADDWF       FARG_moveAndCheckAsteroids_s+0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	ADDWFC      FARG_moveAndCheckAsteroids_s+1, 0 
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
;main.c,172 :: 		}
L_moveAndCheckAsteroids103:
;main.c,173 :: 		draw_horizontal_line(s[i], DRAW);
	MOVF        moveAndCheckAsteroids_i_L0+0, 0 
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
	ADDWF       FARG_moveAndCheckAsteroids_s+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_moveAndCheckAsteroids_s+1, 0 
	MOVWF       FSR0L+1 
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_draw_horizontal_line_asteroid+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_horizontal_line_asteroid+0)
	MOVWF       FSR1L+1 
L_moveAndCheckAsteroids105:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_moveAndCheckAsteroids105
	MOVLW       1
	MOVWF       FARG_draw_horizontal_line_color+0 
	CALL        _draw_horizontal_line+0, 0
;main.c,146 :: 		for (i = 0; i < NUM_ASTEROIDS; i++)
	INCF        moveAndCheckAsteroids_i_L0+0, 1 
;main.c,174 :: 		}
	GOTO        L_moveAndCheckAsteroids94
L_moveAndCheckAsteroids95:
;main.c,176 :: 		Serial_Write(&SendUpdateAst, 2);
	MOVLW       _SendUpdateAst+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_SendUpdateAst+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       2
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;main.c,177 :: 		}
L_end_moveAndCheckAsteroids:
	RETURN      0
; end of _moveAndCheckAsteroids

_updateData:

;main.c,185 :: 		void updateData() {
;main.c,189 :: 		while (1)
L_updateData106:
;main.c,192 :: 		n = Serial_available();
	CALL        _Serial_available+0, 0
;main.c,193 :: 		if (n >= (2)) {
	MOVLW       128
	XORWF       R1, 0 
	MOVWF       R2 
	MOVLW       128
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__updateData201
	MOVLW       2
	SUBWF       R0, 0 
L__updateData201:
	BTFSS       STATUS+0, 0 
	GOTO        L_updateData108
;main.c,194 :: 		Serial_Read(&mark, 2);
	MOVLW       updateData_mark_L0+0
	MOVWF       FARG_Serial_Read_buf+0 
	MOVLW       hi_addr(updateData_mark_L0+0)
	MOVWF       FARG_Serial_Read_buf+1 
	MOVLW       2
	MOVWF       FARG_Serial_Read_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Read_n+1 
	CALL        _Serial_Read+0, 0
;main.c,196 :: 		if (mark == SendTime) {
	MOVF        updateData_mark_L0+1, 0 
	XORWF       _SendTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__updateData202
	MOVF        _SendTime+0, 0 
	XORWF       updateData_mark_L0+0, 0 
L__updateData202:
	BTFSS       STATUS+0, 2 
	GOTO        L_updateData109
;main.c,197 :: 		flag = 1;
	MOVLW       1
	MOVWF       _flag+0 
;main.c,198 :: 		continue;
	GOTO        L_updateData106
;main.c,199 :: 		}
L_updateData109:
;main.c,201 :: 		if (mark == SendPlayer)
	MOVF        updateData_mark_L0+1, 0 
	XORWF       _SendPlayer+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__updateData203
	MOVF        _SendPlayer+0, 0 
	XORWF       updateData_mark_L0+0, 0 
L__updateData203:
	BTFSS       STATUS+0, 2 
	GOTO        L_updateData110
;main.c,203 :: 		Serial_Read(&playerTwo.rect, sizeof(Rect));
	MOVLW       _playerTwo+0
	MOVWF       FARG_Serial_Read_buf+0 
	MOVLW       hi_addr(_playerTwo+0)
	MOVWF       FARG_Serial_Read_buf+1 
	MOVLW       4
	MOVWF       FARG_Serial_Read_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Read_n+1 
	CALL        _Serial_Read+0, 0
;main.c,204 :: 		continue;
	GOTO        L_updateData106
;main.c,205 :: 		}
L_updateData110:
;main.c,207 :: 		if (mark == SendPlayerX)
	MOVF        updateData_mark_L0+1, 0 
	XORWF       _SendPlayerX+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__updateData204
	MOVF        _SendPlayerX+0, 0 
	XORWF       updateData_mark_L0+0, 0 
L__updateData204:
	BTFSS       STATUS+0, 2 
	GOTO        L_updateData111
;main.c,209 :: 		Serial_Read(&playerTwo.rect, sizeof(Rect));
	MOVLW       _playerTwo+0
	MOVWF       FARG_Serial_Read_buf+0 
	MOVLW       hi_addr(_playerTwo+0)
	MOVWF       FARG_Serial_Read_buf+1 
	MOVLW       4
	MOVWF       FARG_Serial_Read_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Read_n+1 
	CALL        _Serial_Read+0, 0
;main.c,210 :: 		continue;
	GOTO        L_updateData106
;main.c,211 :: 		}
L_updateData111:
;main.c,213 :: 		if (mark == SendScore)
	MOVF        updateData_mark_L0+1, 0 
	XORWF       _SendScore+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__updateData205
	MOVF        _SendScore+0, 0 
	XORWF       updateData_mark_L0+0, 0 
L__updateData205:
	BTFSS       STATUS+0, 2 
	GOTO        L_updateData112
;main.c,215 :: 		flagScore = 1;
	MOVLW       1
	MOVWF       _flagScore+0 
;main.c,216 :: 		continue;
	GOTO        L_updateData106
;main.c,217 :: 		}
L_updateData112:
;main.c,219 :: 		if (mark == SendTimeOut)
	MOVF        updateData_mark_L0+1, 0 
	XORWF       _SendTimeOut+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__updateData206
	MOVF        _SendTimeOut+0, 0 
	XORWF       updateData_mark_L0+0, 0 
L__updateData206:
	BTFSS       STATUS+0, 2 
	GOTO        L_updateData113
;main.c,221 :: 		flagTimeOut = 1;
	MOVLW       1
	MOVWF       _flagTimeOut+0 
;main.c,222 :: 		continue;
	GOTO        L_updateData106
;main.c,223 :: 		}
L_updateData113:
;main.c,225 :: 		Serial_clear();
	CALL        _Serial_clear+0, 0
;main.c,226 :: 		}
L_updateData108:
;main.c,228 :: 		return;
;main.c,231 :: 		}
L_end_updateData:
	RETURN      0
; end of _updateData

_main:

;main.c,234 :: 		void main() {
;main.c,236 :: 		state = 0;
	CLRF        _state+0 
;main.c,238 :: 		ADCON1 = 0x0F;
	MOVLW       15
	MOVWF       ADCON1+0 
;main.c,239 :: 		Serial_Init();
	CALL        main_Serial_Init+0, 0
;main.c,240 :: 		Serial_clear();
	CALL        _Serial_clear+0, 0
;main.c,241 :: 		randomSeed(33);
	MOVLW       33
	MOVWF       FARG_randomSeed_seed+0 
	MOVLW       0
	MOVWF       FARG_randomSeed_seed+1 
	MOVWF       FARG_randomSeed_seed+2 
	MOVWF       FARG_randomSeed_seed+3 
	CALL        _randomSeed+0, 0
;main.c,242 :: 		init_game();
	CALL        _init_game+0, 0
;main.c,243 :: 		Glcd_Init();
	CALL        _Glcd_Init+0, 0
;main.c,244 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;main.c,245 :: 		InitTimer0();
	CALL        main_InitTimer0+0, 0
;main.c,247 :: 		while (1)
L_main114:
;main.c,249 :: 		switch (state)
	GOTO        L_main116
;main.c,251 :: 		case TITLE:
L_main118:
;main.c,252 :: 		draw_InitFrame();
	CALL        _draw_InitFrame+0, 0
;main.c,253 :: 		state = MENU;
	MOVLW       1
	MOVWF       _state+0 
;main.c,254 :: 		break;
	GOTO        L_main117
;main.c,256 :: 		case MENU:
L_main119:
;main.c,257 :: 		state = draw_MenuGame(modeGame);
	MOVF        _modeGame+0, 0 
	MOVWF       FARG_draw_MenuGame_modeGame+0 
	CALL        _draw_MenuGame+0, 0
	MOVF        R0, 0 
	MOVWF       _state+0 
;main.c,258 :: 		break;
	GOTO        L_main117
;main.c,260 :: 		case ONEPLAYER:
L_main120:
;main.c,261 :: 		init_game();
	CALL        _init_game+0, 0
;main.c,262 :: 		draw_clear();
	CALL        _draw_clear+0, 0
;main.c,263 :: 		draw_score(scoreA, scoreB);
	MOVF        _scoreA+0, 0 
	MOVWF       FARG_draw_score_a+0 
	MOVF        _scoreB+0, 0 
	MOVWF       FARG_draw_score_b+0 
	CALL        _draw_score+0, 0
;main.c,264 :: 		TMR0IE_bit    = 1; //lo vuelvo a habilitar ya que si salto de dos jugadores a uno, esta apagado
	BSF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;main.c,265 :: 		while (1)
L_main121:
;main.c,268 :: 		updateGameTime(&timer);
	MOVLW       _timer+0
	MOVWF       FARG_updateGameTime_t+0 
	MOVLW       hi_addr(_timer+0)
	MOVWF       FARG_updateGameTime_t+1 
	CALL        _updateGameTime+0, 0
;main.c,269 :: 		if (state == MENU)
	MOVF        _state+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main123
;main.c,271 :: 		draw_clear();
	CALL        _draw_clear+0, 0
;main.c,272 :: 		break;
	GOTO        L_main122
;main.c,273 :: 		}
L_main123:
;main.c,275 :: 		playerOne = move_player(playerOne, m);
	MOVLW       6
	MOVWF       R0 
	MOVLW       FARG_move_player_player+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_move_player_player+0)
	MOVWF       FSR1L+1 
	MOVLW       _playerOne+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_playerOne+0)
	MOVWF       FSR0L+1 
L_main124:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main124
	MOVLW       _m+0
	MOVWF       FARG_move_player_a+0 
	MOVLW       hi_addr(_m+0)
	MOVWF       FARG_move_player_a+1 
	MOVLW       FLOC__main+0
	MOVWF       R0 
	MOVLW       hi_addr(FLOC__main+0)
	MOVWF       R1 
	CALL        _move_player+0, 0
	MOVLW       6
	MOVWF       R0 
	MOVLW       _playerOne+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_playerOne+0)
	MOVWF       FSR1L+1 
	MOVLW       FLOC__main+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FLOC__main+0)
	MOVWF       FSR0L+1 
L_main125:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main125
;main.c,276 :: 		environment(m);
	MOVLW       _m+0
	MOVWF       FARG_environment_s+0 
	MOVLW       hi_addr(_m+0)
	MOVWF       FARG_environment_s+1 
	CALL        _environment+0, 0
;main.c,277 :: 		playerPC = move_ai(playerPC, m);
	MOVLW       6
	MOVWF       R0 
	MOVLW       FARG_move_ai_pc+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_move_ai_pc+0)
	MOVWF       FSR1L+1 
	MOVLW       _playerPC+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_playerPC+0)
	MOVWF       FSR0L+1 
L_main126:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main126
	MOVLW       _m+0
	MOVWF       FARG_move_ai_a+0 
	MOVLW       hi_addr(_m+0)
	MOVWF       FARG_move_ai_a+1 
	MOVLW       FLOC__main+0
	MOVWF       R0 
	MOVLW       hi_addr(FLOC__main+0)
	MOVWF       R1 
	CALL        _move_ai+0, 0
	MOVLW       6
	MOVWF       R0 
	MOVLW       _playerPC+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_playerPC+0)
	MOVWF       FSR1L+1 
	MOVLW       FLOC__main+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FLOC__main+0)
	MOVWF       FSR0L+1 
L_main127:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main127
;main.c,282 :: 		draw_box(timer, DRAW);
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
L_main128:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main128
	MOVLW       1
	MOVWF       FARG_draw_box_color+0 
	CALL        _draw_box+0, 0
;main.c,283 :: 		draw_partial_image(playerPC.rect, ship);
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_draw_partial_image_player+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_partial_image_player+0)
	MOVWF       FSR1L+1 
	MOVLW       _playerPC+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_playerPC+0)
	MOVWF       FSR0L+1 
L_main129:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main129
	MOVLW       _ship+0
	MOVWF       FARG_draw_partial_image_image+0 
	MOVLW       hi_addr(_ship+0)
	MOVWF       FARG_draw_partial_image_image+1 
	MOVLW       higher_addr(_ship+0)
	MOVWF       FARG_draw_partial_image_image+2 
	CALL        _draw_partial_image+0, 0
;main.c,284 :: 		draw_partial_image(playerOne.rect, ship);
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
L_main130:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main130
	MOVLW       _ship+0
	MOVWF       FARG_draw_partial_image_image+0 
	MOVLW       hi_addr(_ship+0)
	MOVWF       FARG_draw_partial_image_image+1 
	MOVLW       higher_addr(_ship+0)
	MOVWF       FARG_draw_partial_image_image+2 
	CALL        _draw_partial_image+0, 0
;main.c,285 :: 		Delay_ms(60);
	MOVLW       156
	MOVWF       R12, 0
	MOVLW       215
	MOVWF       R13, 0
L_main131:
	DECFSZ      R13, 1, 1
	BRA         L_main131
	DECFSZ      R12, 1, 1
	BRA         L_main131
;main.c,286 :: 		draw_box(timer, ERASE);
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
L_main132:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main132
	CLRF        FARG_draw_box_color+0 
	CALL        _draw_box+0, 0
;main.c,287 :: 		draw_partial_image(playerOne.rect, parche);
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
L_main133:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main133
	MOVLW       _parche+0
	MOVWF       FARG_draw_partial_image_image+0 
	MOVLW       hi_addr(_parche+0)
	MOVWF       FARG_draw_partial_image_image+1 
	MOVLW       higher_addr(_parche+0)
	MOVWF       FARG_draw_partial_image_image+2 
	CALL        _draw_partial_image+0, 0
;main.c,288 :: 		draw_partial_image(playerPC.rect, parche);
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_draw_partial_image_player+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_partial_image_player+0)
	MOVWF       FSR1L+1 
	MOVLW       _playerPC+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_playerPC+0)
	MOVWF       FSR0L+1 
L_main134:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main134
	MOVLW       _parche+0
	MOVWF       FARG_draw_partial_image_image+0 
	MOVLW       hi_addr(_parche+0)
	MOVWF       FARG_draw_partial_image_image+1 
	MOVLW       higher_addr(_parche+0)
	MOVWF       FARG_draw_partial_image_image+2 
	CALL        _draw_partial_image+0, 0
;main.c,293 :: 		}
	GOTO        L_main121
L_main122:
;main.c,295 :: 		break;
	GOTO        L_main117
;main.c,297 :: 		case MULTIPLAYER:
L_main135:
;main.c,298 :: 		randomSeed(33);
	MOVLW       33
	MOVWF       FARG_randomSeed_seed+0 
	MOVLW       0
	MOVWF       FARG_randomSeed_seed+1 
	MOVWF       FARG_randomSeed_seed+2 
	MOVWF       FARG_randomSeed_seed+3 
	CALL        _randomSeed+0, 0
;main.c,299 :: 		init_game();
	CALL        _init_game+0, 0
;main.c,300 :: 		TMR0IE_bit    = 0;     //deshabilito la interrupcion por timer0, ya que me hace freezeado el micro
	BCF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;main.c,301 :: 		syncGame();
	CALL        _syncGame+0, 0
;main.c,302 :: 		draw_score(scoreA, scoreB);
	MOVF        _scoreA+0, 0 
	MOVWF       FARG_draw_score_a+0 
	MOVF        _scoreB+0, 0 
	MOVWF       FARG_draw_score_b+0 
	CALL        _draw_score+0, 0
;main.c,303 :: 		while (1)
L_main136:
;main.c,305 :: 		moveAndCheckAsteroids(m);
	MOVLW       _m+0
	MOVWF       FARG_moveAndCheckAsteroids_s+0 
	MOVLW       hi_addr(_m+0)
	MOVWF       FARG_moveAndCheckAsteroids_s+1 
	CALL        _moveAndCheckAsteroids+0, 0
;main.c,306 :: 		updateData();
	CALL        _updateData+0, 0
;main.c,308 :: 		if (flag)
	MOVF        _flag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main138
;main.c,310 :: 		timer.y++;
	MOVF        _timer+1, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _timer+1 
;main.c,311 :: 		flag = 0;
	CLRF        _flag+0 
;main.c,312 :: 		}
L_main138:
;main.c,314 :: 		if (flagScore)
	MOVF        _flagScore+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main139
;main.c,316 :: 		flagScore = 0;
	CLRF        _flagScore+0 
;main.c,317 :: 		scoreB++;
	INCF        _scoreB+0, 1 
;main.c,318 :: 		draw_score(scoreA, scoreB);
	MOVF        _scoreA+0, 0 
	MOVWF       FARG_draw_score_a+0 
	MOVF        _scoreB+0, 0 
	MOVWF       FARG_draw_score_b+0 
	CALL        _draw_score+0, 0
;main.c,319 :: 		}
L_main139:
;main.c,321 :: 		key = readKeys();
	MOVLW       FLOC__main+0
	MOVWF       R0 
	MOVLW       hi_addr(FLOC__main+0)
	MOVWF       R1 
	CALL        main_readKeys+0, 0
	MOVLW       3
	MOVWF       R0 
	MOVLW       _key+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_key+0)
	MOVWF       FSR1L+1 
	MOVLW       FLOC__main+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FLOC__main+0)
	MOVWF       FSR0L+1 
L_main140:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main140
;main.c,323 :: 		if (key.up)
	MOVF        _key+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main141
;main.c,326 :: 		playerOne.rect.y--;
	DECF        _playerOne+1, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _playerOne+1 
;main.c,327 :: 		if (playerOne.rect.y <= 0){
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	XORWF       _playerOne+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main142
;main.c,328 :: 		playerOne.rect.x = 32;
	MOVLW       32
	MOVWF       _playerOne+0 
;main.c,329 :: 		playerOne.rect.y = 55;
	MOVLW       55
	MOVWF       _playerOne+1 
;main.c,330 :: 		scoreA++;
	INCF        _scoreA+0, 1 
;main.c,331 :: 		Serial_Write(&SendScore, 2);
	MOVLW       _SendScore+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_SendScore+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       2
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;main.c,332 :: 		draw_score(scoreA, scoreB);
	MOVF        _scoreA+0, 0 
	MOVWF       FARG_draw_score_a+0 
	MOVF        _scoreB+0, 0 
	MOVWF       FARG_draw_score_b+0 
	CALL        _draw_score+0, 0
;main.c,333 :: 		}
L_main142:
;main.c,334 :: 		Serial_Write(&SendPlayer, 2);
	MOVLW       _SendPlayer+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_SendPlayer+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       2
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;main.c,335 :: 		Serial_Write(&playerOne.rect, sizeof(Rect));
	MOVLW       _playerOne+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_playerOne+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       4
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;main.c,336 :: 		}
L_main141:
;main.c,338 :: 		if (key.down)
	MOVF        _key+1, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main143
;main.c,340 :: 		playerOne.rect.y++;
	MOVF        _playerOne+1, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _playerOne+1 
;main.c,341 :: 		if (playerOne.rect.y + (playerOne.rect.h - 1) >= 63){
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
	GOTO        L__main208
	MOVLW       63
	SUBWF       R2, 0 
L__main208:
	BTFSS       STATUS+0, 0 
	GOTO        L_main144
;main.c,342 :: 		playerOne.rect.y = 55;
	MOVLW       55
	MOVWF       _playerOne+1 
;main.c,343 :: 		}
L_main144:
;main.c,344 :: 		Serial_Write(&SendPlayer, 2);
	MOVLW       _SendPlayer+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_SendPlayer+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       2
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;main.c,345 :: 		Serial_Write(&playerOne.rect, sizeof(Rect));
	MOVLW       _playerOne+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_playerOne+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       4
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;main.c,346 :: 		}
L_main143:
;main.c,348 :: 		if (flagTimeOut)
	MOVF        _flagTimeOut+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main145
;main.c,350 :: 		flagTimeOut = 0;
	CLRF        _flagTimeOut+0 
;main.c,351 :: 		if (scoreA > scoreB)
	MOVF        _scoreA+0, 0 
	SUBWF       _scoreB+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main146
;main.c,353 :: 		draw_winFrame();
	CALL        _draw_winFrame+0, 0
;main.c,354 :: 		}
	GOTO        L_main147
L_main146:
;main.c,356 :: 		else if (scoreB > scoreA)
	MOVF        _scoreB+0, 0 
	SUBWF       _scoreA+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main148
;main.c,358 :: 		draw_loseFrame();
	CALL        _draw_loseFrame+0, 0
;main.c,359 :: 		}
	GOTO        L_main149
L_main148:
;main.c,363 :: 		draw_loseFrame();
	CALL        _draw_loseFrame+0, 0
;main.c,364 :: 		}
L_main149:
L_main147:
;main.c,366 :: 		init_game();
	CALL        _init_game+0, 0
;main.c,367 :: 		state = MENU;
	MOVLW       1
	MOVWF       _state+0 
;main.c,368 :: 		}
L_main145:
;main.c,369 :: 		if (state == MENU)
	MOVF        _state+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main150
;main.c,371 :: 		draw_clear();
	CALL        _draw_clear+0, 0
;main.c,372 :: 		break;
	GOTO        L_main137
;main.c,373 :: 		}
L_main150:
;main.c,376 :: 		draw_box(timer, DRAW);
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
L_main151:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main151
	MOVLW       1
	MOVWF       FARG_draw_box_color+0 
	CALL        _draw_box+0, 0
;main.c,377 :: 		draw_partial_image(playerOne.rect, ship);
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
L_main152:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main152
	MOVLW       _ship+0
	MOVWF       FARG_draw_partial_image_image+0 
	MOVLW       hi_addr(_ship+0)
	MOVWF       FARG_draw_partial_image_image+1 
	MOVLW       higher_addr(_ship+0)
	MOVWF       FARG_draw_partial_image_image+2 
	CALL        _draw_partial_image+0, 0
;main.c,378 :: 		draw_partial_image(playerTwo.rect, ship);
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
L_main153:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main153
	MOVLW       _ship+0
	MOVWF       FARG_draw_partial_image_image+0 
	MOVLW       hi_addr(_ship+0)
	MOVWF       FARG_draw_partial_image_image+1 
	MOVLW       higher_addr(_ship+0)
	MOVWF       FARG_draw_partial_image_image+2 
	CALL        _draw_partial_image+0, 0
;main.c,379 :: 		Delay_ms(60);
	MOVLW       156
	MOVWF       R12, 0
	MOVLW       215
	MOVWF       R13, 0
L_main154:
	DECFSZ      R13, 1, 1
	BRA         L_main154
	DECFSZ      R12, 1, 1
	BRA         L_main154
;main.c,380 :: 		draw_box(timer, ERASE);
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
L_main155:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main155
	CLRF        FARG_draw_box_color+0 
	CALL        _draw_box+0, 0
;main.c,381 :: 		draw_partial_image(playerOne.rect, parche);
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
L_main156:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main156
	MOVLW       _parche+0
	MOVWF       FARG_draw_partial_image_image+0 
	MOVLW       hi_addr(_parche+0)
	MOVWF       FARG_draw_partial_image_image+1 
	MOVLW       higher_addr(_parche+0)
	MOVWF       FARG_draw_partial_image_image+2 
	CALL        _draw_partial_image+0, 0
;main.c,382 :: 		draw_partial_image(playerTwo.rect, parche);
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
L_main157:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main157
	MOVLW       _parche+0
	MOVWF       FARG_draw_partial_image_image+0 
	MOVLW       hi_addr(_parche+0)
	MOVWF       FARG_draw_partial_image_image+1 
	MOVLW       higher_addr(_parche+0)
	MOVWF       FARG_draw_partial_image_image+2 
	CALL        _draw_partial_image+0, 0
;main.c,384 :: 		}
	GOTO        L_main136
L_main137:
;main.c,386 :: 		break;
	GOTO        L_main117
;main.c,388 :: 		default:
L_main158:
;main.c,389 :: 		break;
	GOTO        L_main117
;main.c,390 :: 		}
L_main116:
	MOVF        _state+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main118
	MOVF        _state+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main119
	MOVF        _state+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_main120
	MOVF        _state+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_main135
	GOTO        L_main158
L_main117:
;main.c,391 :: 		}
	GOTO        L_main114
;main.c,395 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

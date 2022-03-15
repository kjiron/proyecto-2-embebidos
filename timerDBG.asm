
_InitTimer0:

;timerDBG.c,40 :: 		void InitTimer0(){
;timerDBG.c,41 :: 		T0CON	 = 0x83;
	MOVLW       131
	MOVWF       T0CON+0 
;timerDBG.c,42 :: 		TMR0H	 = 0x0B;
	MOVLW       11
	MOVWF       TMR0H+0 
;timerDBG.c,43 :: 		TMR0L	 = 0xDC;
	MOVLW       220
	MOVWF       TMR0L+0 
;timerDBG.c,44 :: 		GIE_bit	 = 1;
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;timerDBG.c,45 :: 		TMR0IE_bit	 = 1;
	BSF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;timerDBG.c,46 :: 		}
L_end_InitTimer0:
	RETURN      0
; end of _InitTimer0

_Interrupt:

;timerDBG.c,48 :: 		void Interrupt(){
;timerDBG.c,49 :: 		if (TMR0IF_bit){
	BTFSS       TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
	GOTO        L_Interrupt0
;timerDBG.c,50 :: 		TMR0IF_bit = 0;
	BCF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
;timerDBG.c,51 :: 		TMR0H	 = 0x0B;
	MOVLW       11
	MOVWF       TMR0H+0 
;timerDBG.c,52 :: 		TMR0L	 = 0xDC;
	MOVLW       220
	MOVWF       TMR0L+0 
;timerDBG.c,54 :: 		contador_ms++;
	INCF        _contador_ms+0, 1 
;timerDBG.c,55 :: 		if (contador_ms >= 2)
	MOVLW       2
	SUBWF       _contador_ms+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_Interrupt1
;timerDBG.c,57 :: 		TIME_FLAG = 1;
	MOVLW       1
	MOVWF       _TIME_FLAG+0 
;timerDBG.c,58 :: 		contador_ms = 0;
	CLRF        _contador_ms+0 
;timerDBG.c,59 :: 		}
L_Interrupt1:
;timerDBG.c,61 :: 		}
L_Interrupt0:
;timerDBG.c,62 :: 		}
L_end_Interrupt:
L__Interrupt12:
	RETFIE      1
; end of _Interrupt

_main:

;timerDBG.c,67 :: 		void main()
;timerDBG.c,71 :: 		timer.x = 62;
	MOVLW       62
	MOVWF       main_timer_L0+0 
;timerDBG.c,72 :: 		timer.y = 3;
	MOVLW       3
	MOVWF       main_timer_L0+1 
;timerDBG.c,73 :: 		timer.w = 1;
	MOVLW       1
	MOVWF       main_timer_L0+2 
;timerDBG.c,74 :: 		timer.h = 60;
	MOVLW       60
	MOVWF       main_timer_L0+3 
;timerDBG.c,76 :: 		Glcd_Init();
	CALL        _Glcd_Init+0, 0
;timerDBG.c,77 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;timerDBG.c,79 :: 		draw_box(timer, DRAW);
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_draw_box_asteroid+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_box_asteroid+0)
	MOVWF       FSR1L+1 
	MOVLW       main_timer_L0+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(main_timer_L0+0)
	MOVWF       FSR0L+1 
L_main2:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main2
	MOVLW       1
	MOVWF       FARG_draw_box_color+0 
	CALL        _draw_box+0, 0
;timerDBG.c,80 :: 		InitTimer0();
	CALL        _InitTimer0+0, 0
;timerDBG.c,82 :: 		while (1)
L_main3:
;timerDBG.c,85 :: 		draw_box(timer, ERASE);
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_draw_box_asteroid+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_box_asteroid+0)
	MOVWF       FSR1L+1 
	MOVLW       main_timer_L0+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(main_timer_L0+0)
	MOVWF       FSR0L+1 
L_main5:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main5
	CLRF        FARG_draw_box_color+0 
	CALL        _draw_box+0, 0
;timerDBG.c,87 :: 		if (timer.y >= 63)
	MOVLW       128
	XORWF       main_timer_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       63
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main6
;timerDBG.c,89 :: 		timer.y = 23;
	MOVLW       23
	MOVWF       main_timer_L0+1 
;timerDBG.c,90 :: 		}
L_main6:
;timerDBG.c,93 :: 		if (TIME_FLAG)
	MOVF        _TIME_FLAG+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main7
;timerDBG.c,95 :: 		timer.y++;
	MOVF        main_timer_L0+1, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       main_timer_L0+1 
;timerDBG.c,96 :: 		TIME_FLAG = 0;
	CLRF        _TIME_FLAG+0 
;timerDBG.c,97 :: 		}
L_main7:
;timerDBG.c,101 :: 		draw_box(timer, DRAW);
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_draw_box_asteroid+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_box_asteroid+0)
	MOVWF       FSR1L+1 
	MOVLW       main_timer_L0+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(main_timer_L0+0)
	MOVWF       FSR0L+1 
L_main8:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main8
	MOVLW       1
	MOVWF       FARG_draw_box_color+0 
	CALL        _draw_box+0, 0
;timerDBG.c,106 :: 		Delay_ms(60);
	MOVLW       156
	MOVWF       R12, 0
	MOVLW       215
	MOVWF       R13, 0
L_main9:
	DECFSZ      R13, 1, 1
	BRA         L_main9
	DECFSZ      R12, 1, 1
	BRA         L_main9
;timerDBG.c,108 :: 		}
	GOTO        L_main3
;timerDBG.c,110 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_draw_box:

;timerDBG.c,112 :: 		void draw_box(Rect r, uint8_t color)
;timerDBG.c,115 :: 		Glcd_Box(r.x, r.y, r.x + r.w, r.y + r.h, color);
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
;timerDBG.c,116 :: 		}
L_end_draw_box:
	RETURN      0
; end of _draw_box

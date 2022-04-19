
_draw_score:

;random_asteroids.c,31 :: 		void draw_score(uint8_t a, uint8_t b){
;random_asteroids.c,35 :: 		ShortToStr(a, score_text);
	MOVF        FARG_draw_score_a+0, 0 
	MOVWF       FARG_ShortToStr_input+0 
	MOVLW       _score_text+0
	MOVWF       FARG_ShortToStr_output+0 
	MOVLW       hi_addr(_score_text+0)
	MOVWF       FARG_ShortToStr_output+1 
	CALL        _ShortToStr+0, 0
;random_asteroids.c,36 :: 		fix_text = Ltrim(score_text);
	MOVLW       _score_text+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(_score_text+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
;random_asteroids.c,37 :: 		Glcd_Write_Text(fix_text, 15, 7, 1);
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
;random_asteroids.c,38 :: 		ShortToStr(b, score_text);
	MOVF        FARG_draw_score_b+0, 0 
	MOVWF       FARG_ShortToStr_input+0 
	MOVLW       _score_text+0
	MOVWF       FARG_ShortToStr_output+0 
	MOVLW       hi_addr(_score_text+0)
	MOVWF       FARG_ShortToStr_output+1 
	CALL        _ShortToStr+0, 0
;random_asteroids.c,39 :: 		fix_text = Ltrim(score_text);
	MOVLW       _score_text+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(_score_text+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
;random_asteroids.c,40 :: 		Glcd_Write_Text(fix_text, 107, 7, 1);
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
;random_asteroids.c,41 :: 		}
L_end_draw_score:
	RETURN      0
; end of _draw_score

_draw_horizontal_line:

;random_asteroids.c,43 :: 		void draw_horizontal_line(Rect asteroid, uint8_t color)
;random_asteroids.c,45 :: 		Glcd_H_Line(asteroid.x, asteroid.x + asteroid.w, asteroid.y,  color);
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
;random_asteroids.c,46 :: 		}
L_end_draw_horizontal_line:
	RETURN      0
; end of _draw_horizontal_line

_main:

;random_asteroids.c,49 :: 		void main() {
;random_asteroids.c,51 :: 		i = 0;
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
	CLRF        main_i_L0+2 
	CLRF        main_i_L0+3 
;random_asteroids.c,52 :: 		e = 0;
	CLRF        main_e_L0+0 
	CLRF        main_e_L0+1 
	CLRF        main_e_L0+2 
	CLRF        main_e_L0+3 
;random_asteroids.c,53 :: 		Glcd_Init();
	CALL        _Glcd_Init+0, 0
;random_asteroids.c,54 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;random_asteroids.c,56 :: 		randomSeed(33);
	MOVLW       33
	MOVWF       FARG_randomSeed_seed+0 
	MOVLW       0
	MOVWF       FARG_randomSeed_seed+1 
	MOVWF       FARG_randomSeed_seed+2 
	MOVWF       FARG_randomSeed_seed+3 
	CALL        _randomSeed+0, 0
;random_asteroids.c,58 :: 		while (1)
L_main0:
;random_asteroids.c,60 :: 		draw_score(i, e);
	MOVF        main_i_L0+0, 0 
	MOVWF       FARG_draw_score_a+0 
	MOVF        main_e_L0+0, 0 
	MOVWF       FARG_draw_score_b+0 
	CALL        _draw_score+0, 0
;random_asteroids.c,61 :: 		i = randint(0, 123);
	CLRF        FARG_randint_min+0 
	CLRF        FARG_randint_min+1 
	MOVLW       123
	MOVWF       FARG_randint_max+0 
	MOVLW       0
	MOVWF       FARG_randint_max+1 
	CALL        _randint+0, 0
	MOVF        R0, 0 
	MOVWF       main_i_L0+0 
	MOVF        R1, 0 
	MOVWF       main_i_L0+1 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	MOVWF       main_i_L0+2 
	MOVWF       main_i_L0+3 
;random_asteroids.c,62 :: 		Delay_ms(2000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	DECFSZ      R11, 1, 1
	BRA         L_main2
	NOP
;random_asteroids.c,63 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;random_asteroids.c,65 :: 		}
	GOTO        L_main0
;random_asteroids.c,67 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

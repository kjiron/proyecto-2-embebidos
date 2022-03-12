
main_readKeys:

;proyecto-2-embebido,16 :: 		
	MOVF        R0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       R3 
;proyecto-2-embebido,51 :: 		
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
;proyecto-2-embebido,52 :: 		
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
;proyecto-2-embebido,53 :: 		
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
;proyecto-2-embebido,54 :: 		
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
L_main_readKeys0:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main_readKeys0
;proyecto-2-embebido,56 :: 		
L_end_readKeys:
	RETURN      0
; end of main_readKeys

_draw_clear:

;proyecto-2-embebido,16 :: 		
;proyecto-2-embebido,18 :: 		
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;proyecto-2-embebido,19 :: 		
L_end_draw_clear:
	RETURN      0
; end of _draw_clear

_draw_InitFrame:

;proyecto-2-embebido,22 :: 		
;proyecto-2-embebido,23 :: 		
	MOVLW       _titleFrame+0
	MOVWF       FARG_Glcd_Image_image+0 
	MOVLW       hi_addr(_titleFrame+0)
	MOVWF       FARG_Glcd_Image_image+1 
	MOVLW       higher_addr(_titleFrame+0)
	MOVWF       FARG_Glcd_Image_image+2 
	CALL        _Glcd_Image+0, 0
;proyecto-2-embebido,24 :: 		
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_draw_InitFrame1:
	DECFSZ      R13, 1, 1
	BRA         L_draw_InitFrame1
	DECFSZ      R12, 1, 1
	BRA         L_draw_InitFrame1
	DECFSZ      R11, 1, 1
	BRA         L_draw_InitFrame1
;proyecto-2-embebido,25 :: 		
	CALL        _draw_clear+0, 0
;proyecto-2-embebido,26 :: 		
L_end_draw_InitFrame:
	RETURN      0
; end of _draw_InitFrame

_draw_MenuFrame:

;proyecto-2-embebido,28 :: 		
;proyecto-2-embebido,29 :: 		
	MOVLW       _menuFrame+0
	MOVWF       FARG_Glcd_Image_image+0 
	MOVLW       hi_addr(_menuFrame+0)
	MOVWF       FARG_Glcd_Image_image+1 
	MOVLW       higher_addr(_menuFrame+0)
	MOVWF       FARG_Glcd_Image_image+2 
	CALL        _Glcd_Image+0, 0
;proyecto-2-embebido,30 :: 		
L_end_draw_MenuFrame:
	RETURN      0
; end of _draw_MenuFrame

_draw_circle:

;proyecto-2-embebido,33 :: 		
;proyecto-2-embebido,36 :: 		
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
;proyecto-2-embebido,37 :: 		
L_end_draw_circle:
	RETURN      0
; end of _draw_circle

_draw_MenuGame:

;proyecto-2-embebido,42 :: 		
;proyecto-2-embebido,45 :: 		
	MOVLW       25
	MOVWF       draw_MenuGame_select_L0+0 
	MOVLW       34
	MOVWF       draw_MenuGame_select_L0+1 
	MOVLW       3
	MOVWF       draw_MenuGame_select_L0+2 
	CLRF        draw_MenuGame_select_L0+3 
;proyecto-2-embebido,46 :: 		
	CALL        _draw_MenuFrame+0, 0
;proyecto-2-embebido,47 :: 		
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
L_draw_MenuGame2:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame2
	MOVLW       1
	MOVWF       FARG_draw_circle_color+0 
	CALL        _draw_circle+0, 0
;proyecto-2-embebido,49 :: 		
L_draw_MenuGame3:
;proyecto-2-embebido,51 :: 		
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
L_draw_MenuGame5:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame5
;proyecto-2-embebido,53 :: 		
	MOVF        draw_MenuGame_key_L0+2, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_draw_MenuGame8
	MOVF        FARG_draw_MenuGame_modeGame+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame8
L__draw_MenuGame40:
;proyecto-2-embebido,55 :: 		
	CALL        _draw_clear+0, 0
;proyecto-2-embebido,56 :: 		
	MOVLW       2
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_draw_MenuGame
;proyecto-2-embebido,57 :: 		
L_draw_MenuGame8:
;proyecto-2-embebido,58 :: 		
	MOVF        draw_MenuGame_key_L0+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__draw_MenuGame39
	MOVF        draw_MenuGame_key_L0+1, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__draw_MenuGame39
	GOTO        L_draw_MenuGame13
L__draw_MenuGame39:
	MOVF        FARG_draw_MenuGame_modeGame+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame13
L__draw_MenuGame38:
;proyecto-2-embebido,63 :: 		
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
L_draw_MenuGame14:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame14
	CLRF        FARG_draw_circle_color+0 
	CALL        _draw_circle+0, 0
;proyecto-2-embebido,64 :: 		
	MOVLW       14
	ADDWF       draw_MenuGame_select_L0+1, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       draw_MenuGame_select_L0+1 
;proyecto-2-embebido,65 :: 		
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
L_draw_MenuGame15:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame15
	MOVLW       1
	MOVWF       FARG_draw_circle_color+0 
	CALL        _draw_circle+0, 0
;proyecto-2-embebido,66 :: 		
	MOVLW       1
	MOVWF       FARG_draw_MenuGame_modeGame+0 
;proyecto-2-embebido,67 :: 		
	MOVLW       7
	MOVWF       R11, 0
	MOVLW       194
	MOVWF       R12, 0
	MOVLW       216
	MOVWF       R13, 0
L_draw_MenuGame16:
	DECFSZ      R13, 1, 1
	BRA         L_draw_MenuGame16
	DECFSZ      R12, 1, 1
	BRA         L_draw_MenuGame16
	DECFSZ      R11, 1, 1
	BRA         L_draw_MenuGame16
	NOP
;proyecto-2-embebido,68 :: 		
	GOTO        L_draw_MenuGame3
;proyecto-2-embebido,69 :: 		
L_draw_MenuGame13:
;proyecto-2-embebido,70 :: 		
	MOVF        draw_MenuGame_key_L0+2, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_draw_MenuGame19
	MOVF        FARG_draw_MenuGame_modeGame+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame19
L__draw_MenuGame37:
;proyecto-2-embebido,72 :: 		
	CALL        _draw_clear+0, 0
;proyecto-2-embebido,73 :: 		
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_draw_MenuGame
;proyecto-2-embebido,74 :: 		
L_draw_MenuGame19:
;proyecto-2-embebido,75 :: 		
	MOVF        draw_MenuGame_key_L0+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__draw_MenuGame36
	MOVF        draw_MenuGame_key_L0+1, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__draw_MenuGame36
	GOTO        L_draw_MenuGame24
L__draw_MenuGame36:
	MOVF        FARG_draw_MenuGame_modeGame+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame24
L__draw_MenuGame35:
;proyecto-2-embebido,80 :: 		
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
L_draw_MenuGame25:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame25
	CLRF        FARG_draw_circle_color+0 
	CALL        _draw_circle+0, 0
;proyecto-2-embebido,81 :: 		
	MOVLW       14
	SUBWF       draw_MenuGame_select_L0+1, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       draw_MenuGame_select_L0+1 
;proyecto-2-embebido,82 :: 		
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
L_draw_MenuGame26:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame26
	MOVLW       1
	MOVWF       FARG_draw_circle_color+0 
	CALL        _draw_circle+0, 0
;proyecto-2-embebido,83 :: 		
	CLRF        FARG_draw_MenuGame_modeGame+0 
;proyecto-2-embebido,84 :: 		
	MOVLW       7
	MOVWF       R11, 0
	MOVLW       194
	MOVWF       R12, 0
	MOVLW       216
	MOVWF       R13, 0
L_draw_MenuGame27:
	DECFSZ      R13, 1, 1
	BRA         L_draw_MenuGame27
	DECFSZ      R12, 1, 1
	BRA         L_draw_MenuGame27
	DECFSZ      R11, 1, 1
	BRA         L_draw_MenuGame27
	NOP
;proyecto-2-embebido,85 :: 		
L_draw_MenuGame24:
;proyecto-2-embebido,86 :: 		
	GOTO        L_draw_MenuGame3
;proyecto-2-embebido,87 :: 		
L_end_draw_MenuGame:
	RETURN      0
; end of _draw_MenuGame

_main:

;main.c,11 :: 		void main() {
;main.c,12 :: 		uint8_t state = 0;
	CLRF        main_state_L0+0 
	CLRF        main_modeGame_L0+0 
;main.c,15 :: 		ADCON1 = 0x0F;
	MOVLW       15
	MOVWF       ADCON1+0 
;main.c,16 :: 		Glcd_Init();
	CALL        _Glcd_Init+0, 0
;main.c,19 :: 		while (1)
L_main28:
;main.c,21 :: 		switch (state)
	GOTO        L_main30
;main.c,23 :: 		case TITLE:
L_main32:
;main.c,24 :: 		draw_InitFrame();
	CALL        _draw_InitFrame+0, 0
;main.c,25 :: 		state = MENU;
	MOVLW       1
	MOVWF       main_state_L0+0 
;main.c,26 :: 		break;
	GOTO        L_main31
;main.c,28 :: 		case MENU:
L_main33:
;main.c,30 :: 		state = draw_MenuGame(modeGame);
	MOVF        main_modeGame_L0+0, 0 
	MOVWF       FARG_draw_MenuGame_modeGame+0 
	CALL        _draw_MenuGame+0, 0
	MOVF        R0, 0 
	MOVWF       main_state_L0+0 
;main.c,31 :: 		break;
	GOTO        L_main31
;main.c,33 :: 		default:
L_main34:
;main.c,34 :: 		break;
	GOTO        L_main31
;main.c,35 :: 		}
L_main30:
	MOVF        main_state_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main32
	MOVF        main_state_L0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main33
	GOTO        L_main34
L_main31:
;main.c,36 :: 		}
	GOTO        L_main28
;main.c,40 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

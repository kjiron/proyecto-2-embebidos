
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

;proyecto-2-embebido,29 :: 		
;proyecto-2-embebido,31 :: 		
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;proyecto-2-embebido,32 :: 		
L_end_draw_clear:
	RETURN      0
; end of _draw_clear

_draw_InitFrame:

;proyecto-2-embebido,35 :: 		
;proyecto-2-embebido,36 :: 		
	MOVLW       _titleFrame+0
	MOVWF       FARG_Glcd_Image_image+0 
	MOVLW       hi_addr(_titleFrame+0)
	MOVWF       FARG_Glcd_Image_image+1 
	MOVLW       higher_addr(_titleFrame+0)
	MOVWF       FARG_Glcd_Image_image+2 
	CALL        _Glcd_Image+0, 0
;proyecto-2-embebido,37 :: 		
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
;proyecto-2-embebido,38 :: 		
	CALL        _draw_clear+0, 0
;proyecto-2-embebido,39 :: 		
L_end_draw_InitFrame:
	RETURN      0
; end of _draw_InitFrame

_draw_MenuFrame:

;proyecto-2-embebido,41 :: 		
;proyecto-2-embebido,42 :: 		
	MOVLW       _menuFrame+0
	MOVWF       FARG_Glcd_Image_image+0 
	MOVLW       hi_addr(_menuFrame+0)
	MOVWF       FARG_Glcd_Image_image+1 
	MOVLW       higher_addr(_menuFrame+0)
	MOVWF       FARG_Glcd_Image_image+2 
	CALL        _Glcd_Image+0, 0
;proyecto-2-embebido,43 :: 		
L_end_draw_MenuFrame:
	RETURN      0
; end of _draw_MenuFrame

_draw_circle:

;proyecto-2-embebido,46 :: 		
;proyecto-2-embebido,49 :: 		
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
;proyecto-2-embebido,50 :: 		
L_end_draw_circle:
	RETURN      0
; end of _draw_circle

_draw_dot:

;proyecto-2-embebido,52 :: 		
;proyecto-2-embebido,54 :: 		
	MOVF        FARG_draw_dot_player+0, 0 
	MOVWF       FARG_Glcd_Dot_x_pos+0 
	MOVF        FARG_draw_dot_player+1, 0 
	MOVWF       FARG_Glcd_Dot_y_pos+0 
	MOVF        FARG_draw_dot_color+0, 0 
	MOVWF       FARG_Glcd_Dot_color+0 
	CALL        _Glcd_Dot+0, 0
;proyecto-2-embebido,55 :: 		
L_end_draw_dot:
	RETURN      0
; end of _draw_dot

_draw_horizontal_line:

;proyecto-2-embebido,57 :: 		
;proyecto-2-embebido,59 :: 		
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
;proyecto-2-embebido,60 :: 		
L_end_draw_horizontal_line:
	RETURN      0
; end of _draw_horizontal_line

_draw_MenuGame:

;proyecto-2-embebido,63 :: 		
;proyecto-2-embebido,66 :: 		
	MOVLW       25
	MOVWF       draw_MenuGame_select_L0+0 
	MOVLW       34
	MOVWF       draw_MenuGame_select_L0+1 
	MOVLW       3
	MOVWF       draw_MenuGame_select_L0+2 
	CLRF        draw_MenuGame_select_L0+3 
;proyecto-2-embebido,67 :: 		
	CALL        _draw_MenuFrame+0, 0
;proyecto-2-embebido,68 :: 		
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
;proyecto-2-embebido,70 :: 		
L_draw_MenuGame3:
;proyecto-2-embebido,72 :: 		
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
;proyecto-2-embebido,74 :: 		
	MOVF        draw_MenuGame_key_L0+2, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_draw_MenuGame8
	MOVF        FARG_draw_MenuGame_modeGame+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame8
L__draw_MenuGame77:
;proyecto-2-embebido,76 :: 		
	CALL        _draw_clear+0, 0
;proyecto-2-embebido,77 :: 		
	MOVLW       2
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_draw_MenuGame
;proyecto-2-embebido,78 :: 		
L_draw_MenuGame8:
;proyecto-2-embebido,79 :: 		
	MOVF        draw_MenuGame_key_L0+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__draw_MenuGame76
	MOVF        draw_MenuGame_key_L0+1, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__draw_MenuGame76
	GOTO        L_draw_MenuGame13
L__draw_MenuGame76:
	MOVF        FARG_draw_MenuGame_modeGame+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame13
L__draw_MenuGame75:
;proyecto-2-embebido,81 :: 		
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
;proyecto-2-embebido,82 :: 		
	MOVLW       14
	ADDWF       draw_MenuGame_select_L0+1, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       draw_MenuGame_select_L0+1 
;proyecto-2-embebido,83 :: 		
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
;proyecto-2-embebido,84 :: 		
	MOVLW       1
	MOVWF       FARG_draw_MenuGame_modeGame+0 
;proyecto-2-embebido,85 :: 		
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
;proyecto-2-embebido,86 :: 		
	GOTO        L_draw_MenuGame3
;proyecto-2-embebido,87 :: 		
L_draw_MenuGame13:
;proyecto-2-embebido,88 :: 		
	MOVF        draw_MenuGame_key_L0+2, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_draw_MenuGame19
	MOVF        FARG_draw_MenuGame_modeGame+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame19
L__draw_MenuGame74:
;proyecto-2-embebido,90 :: 		
	CALL        _draw_clear+0, 0
;proyecto-2-embebido,91 :: 		
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_draw_MenuGame
;proyecto-2-embebido,92 :: 		
L_draw_MenuGame19:
;proyecto-2-embebido,93 :: 		
	MOVF        draw_MenuGame_key_L0+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__draw_MenuGame73
	MOVF        draw_MenuGame_key_L0+1, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__draw_MenuGame73
	GOTO        L_draw_MenuGame24
L__draw_MenuGame73:
	MOVF        FARG_draw_MenuGame_modeGame+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame24
L__draw_MenuGame72:
;proyecto-2-embebido,95 :: 		
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
;proyecto-2-embebido,96 :: 		
	MOVLW       14
	SUBWF       draw_MenuGame_select_L0+1, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       draw_MenuGame_select_L0+1 
;proyecto-2-embebido,97 :: 		
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
;proyecto-2-embebido,98 :: 		
	CLRF        FARG_draw_MenuGame_modeGame+0 
;proyecto-2-embebido,99 :: 		
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
;proyecto-2-embebido,100 :: 		
L_draw_MenuGame24:
;proyecto-2-embebido,101 :: 		
	GOTO        L_draw_MenuGame3
;proyecto-2-embebido,102 :: 		
L_end_draw_MenuGame:
	RETURN      0
; end of _draw_MenuGame

_move_player:

;proyecto-2-embebido,11 :: 		
	MOVF        R0, 0 
	MOVWF       _move_player_su_addr+0 
	MOVF        R1, 0 
	MOVWF       _move_player_su_addr+1 
;proyecto-2-embebido,14 :: 		
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
L_move_player28:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_move_player28
;proyecto-2-embebido,16 :: 		
	MOVF        move_player_key_L0+1, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_move_player29
;proyecto-2-embebido,17 :: 		
	MOVF        FARG_move_player_player+5, 0 
	ADDWF       FARG_move_player_player+1, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       FARG_move_player_player+1 
;proyecto-2-embebido,18 :: 		
	MOVLW       128
	XORWF       R1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       63
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_move_player30
;proyecto-2-embebido,19 :: 		
	MOVLW       63
	MOVWF       FARG_move_player_player+1 
;proyecto-2-embebido,20 :: 		
L_move_player30:
;proyecto-2-embebido,21 :: 		
	GOTO        L_move_player31
L_move_player29:
;proyecto-2-embebido,23 :: 		
	MOVF        move_player_key_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_move_player32
;proyecto-2-embebido,24 :: 		
	MOVF        FARG_move_player_player+5, 0 
	SUBWF       FARG_move_player_player+1, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       FARG_move_player_player+1 
;proyecto-2-embebido,25 :: 		
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	XORWF       R1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_move_player33
;proyecto-2-embebido,26 :: 		
	CLRF        FARG_move_player_player+1 
;proyecto-2-embebido,27 :: 		
L_move_player33:
;proyecto-2-embebido,28 :: 		
	GOTO        L_move_player34
L_move_player32:
;proyecto-2-embebido,31 :: 		
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
L_move_player35:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_move_player35
	GOTO        L_end_move_player
;proyecto-2-embebido,32 :: 		
L_move_player34:
L_move_player31:
;proyecto-2-embebido,34 :: 		
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
L_move_player36:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_move_player36
;proyecto-2-embebido,36 :: 		
L_end_move_player:
	RETURN      0
; end of _move_player

_environment:

;proyecto-2-embebido,40 :: 		
;proyecto-2-embebido,43 :: 		
	MOVF        _x+0, 0 
	MOVWF       FARG_Glcd_H_Line_x_start+0 
	MOVLW       3
	ADDWF       _x+0, 0 
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVLW       60
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	CLRF        FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;proyecto-2-embebido,44 :: 		
	MOVLW       124
	SUBWF       _x+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_environment37
;proyecto-2-embebido,46 :: 		
	CLRF        _x+0 
;proyecto-2-embebido,47 :: 		
L_environment37:
;proyecto-2-embebido,48 :: 		
	INCF        _x+0, 1 
;proyecto-2-embebido,49 :: 		
	MOVF        _x+0, 0 
	MOVWF       FARG_Glcd_H_Line_x_start+0 
	MOVLW       3
	ADDWF       _x+0, 0 
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVLW       60
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;proyecto-2-embebido,65 :: 		
L_end_environment:
	RETURN      0
; end of _environment

_initAsteroids:

;main.c,12 :: 		void initAsteroids(Rect *tmp)
;main.c,15 :: 		offset_x = 20;
	MOVLW       20
	MOVWF       R6 
;main.c,16 :: 		offset_y = 15;
	MOVLW       15
	MOVWF       R7 
;main.c,19 :: 		for (i = 0; i <= 3; i++)
	CLRF        R5 
L_initAsteroids38:
	MOVF        R5, 0 
	SUBLW       3
	BTFSS       STATUS+0, 0 
	GOTO        L_initAsteroids39
;main.c,21 :: 		if ((i % 2) == 0)
	MOVLW       1
	ANDWF       R5, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_initAsteroids41
;main.c,23 :: 		tmp[i].w = 3;
	MOVF        R5, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        FARG_initAsteroids_tmp+0, 0 
	ADDWF       R0, 1 
	MOVF        FARG_initAsteroids_tmp+1, 0 
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1L+1 
	MOVLW       3
	MOVWF       POSTINC1+0 
;main.c,24 :: 		tmp[i].h = 1;
	MOVF        R5, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        FARG_initAsteroids_tmp+0, 0 
	ADDWF       R0, 1 
	MOVF        FARG_initAsteroids_tmp+1, 0 
	ADDWFC      R1, 1 
	MOVLW       3
	ADDWF       R0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1L+1 
	MOVLW       1
	MOVWF       POSTINC1+0 
;main.c,26 :: 		if (i == 0)
	MOVF        R5, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_initAsteroids42
;main.c,28 :: 		tmp[i].x = 0;
	MOVF        R5, 0 
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
	ADDWF       FARG_initAsteroids_tmp+0, 0 
	MOVWF       FSR1L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_initAsteroids_tmp+1, 0 
	MOVWF       FSR1L+1 
	CLRF        POSTINC1+0 
;main.c,29 :: 		tmp[i].y = 60;
	MOVF        R5, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        FARG_initAsteroids_tmp+0, 0 
	ADDWF       R0, 1 
	MOVF        FARG_initAsteroids_tmp+1, 0 
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1L+1 
	MOVLW       60
	MOVWF       POSTINC1+0 
;main.c,30 :: 		}
	GOTO        L_initAsteroids43
L_initAsteroids42:
;main.c,34 :: 		tmp[i].x = tmp[i - 1].x + offset_x;
	MOVF        R5, 0 
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
	ADDWF       FARG_initAsteroids_tmp+0, 0 
	MOVWF       FSR1L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_initAsteroids_tmp+1, 0 
	MOVWF       FSR1L+1 
	DECF        R5, 0 
	MOVWF       R3 
	CLRF        R4 
	MOVLW       0
	SUBWFB      R4, 1 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       FARG_initAsteroids_tmp+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_initAsteroids_tmp+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	ADDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;main.c,35 :: 		tmp[i].y = tmp[i - 1].y - offset_y;
	MOVF        R5, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        FARG_initAsteroids_tmp+0, 0 
	ADDWF       R0, 1 
	MOVF        FARG_initAsteroids_tmp+1, 0 
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1L+1 
	DECF        R5, 0 
	MOVWF       R3 
	CLRF        R4 
	MOVLW       0
	SUBWFB      R4, 1 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        FARG_initAsteroids_tmp+0, 0 
	ADDWF       R0, 1 
	MOVF        FARG_initAsteroids_tmp+1, 0 
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0L+1 
	MOVF        R7, 0 
	SUBWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;main.c,36 :: 		}
L_initAsteroids43:
;main.c,38 :: 		}
	GOTO        L_initAsteroids44
L_initAsteroids41:
;main.c,42 :: 		tmp[i].x = 124;
	MOVF        R5, 0 
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
	ADDWF       FARG_initAsteroids_tmp+0, 0 
	MOVWF       FSR1L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_initAsteroids_tmp+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       124
	MOVWF       POSTINC1+0 
;main.c,43 :: 		tmp[i].y = 55;
	MOVF        R5, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        FARG_initAsteroids_tmp+0, 0 
	ADDWF       R0, 1 
	MOVF        FARG_initAsteroids_tmp+1, 0 
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1L+1 
	MOVLW       55
	MOVWF       POSTINC1+0 
;main.c,44 :: 		tmp[i].w = 3;
	MOVF        R5, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        FARG_initAsteroids_tmp+0, 0 
	ADDWF       R0, 1 
	MOVF        FARG_initAsteroids_tmp+1, 0 
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1L+1 
	MOVLW       3
	MOVWF       POSTINC1+0 
;main.c,45 :: 		tmp[i].h = 1;
	MOVF        R5, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        FARG_initAsteroids_tmp+0, 0 
	ADDWF       R0, 1 
	MOVF        FARG_initAsteroids_tmp+1, 0 
	ADDWFC      R1, 1 
	MOVLW       3
	ADDWF       R0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1L+1 
	MOVLW       1
	MOVWF       POSTINC1+0 
;main.c,46 :: 		}
L_initAsteroids44:
;main.c,19 :: 		for (i = 0; i <= 3; i++)
	INCF        R5, 1 
;main.c,49 :: 		}
	GOTO        L_initAsteroids38
L_initAsteroids39:
;main.c,51 :: 		}
L_end_initAsteroids:
	RETURN      0
; end of _initAsteroids

_move_asteroids:

;main.c,54 :: 		void move_asteroids(Rect *tmp)
;main.c,58 :: 		for (i = 0; i <= 3; i++)
	CLRF        move_asteroids_i_L0+0 
L_move_asteroids45:
	MOVF        move_asteroids_i_L0+0, 0 
	SUBLW       3
	BTFSS       STATUS+0, 0 
	GOTO        L_move_asteroids46
;main.c,62 :: 		if ((i % 2) == 0)
	MOVLW       1
	ANDWF       move_asteroids_i_L0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_move_asteroids48
;main.c,64 :: 		draw_horizontal_line(tmp[i], 0);
	MOVF        move_asteroids_i_L0+0, 0 
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
	ADDWF       FARG_move_asteroids_tmp+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_move_asteroids_tmp+1, 0 
	MOVWF       FSR0L+1 
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_draw_horizontal_line_asteroid+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_horizontal_line_asteroid+0)
	MOVWF       FSR1L+1 
L_move_asteroids49:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_move_asteroids49
	CLRF        FARG_draw_horizontal_line_color+0 
	CALL        _draw_horizontal_line+0, 0
;main.c,65 :: 		if (tmp[i].x >= 124)
	MOVF        move_asteroids_i_L0+0, 0 
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
	ADDWF       FARG_move_asteroids_tmp+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_move_asteroids_tmp+1, 0 
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
	GOTO        L_move_asteroids50
;main.c,67 :: 		tmp[i].x = 0;
	MOVF        move_asteroids_i_L0+0, 0 
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
	ADDWF       FARG_move_asteroids_tmp+0, 0 
	MOVWF       FSR1L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_move_asteroids_tmp+1, 0 
	MOVWF       FSR1L+1 
	CLRF        POSTINC1+0 
;main.c,68 :: 		}
L_move_asteroids50:
;main.c,70 :: 		tmp[i].x++;
	MOVF        move_asteroids_i_L0+0, 0 
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
	ADDWF       FARG_move_asteroids_tmp+0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	ADDWFC      FARG_move_asteroids_tmp+1, 0 
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
;main.c,71 :: 		draw_horizontal_line(tmp[i], 1);
	MOVF        move_asteroids_i_L0+0, 0 
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
	ADDWF       FARG_move_asteroids_tmp+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_move_asteroids_tmp+1, 0 
	MOVWF       FSR0L+1 
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_draw_horizontal_line_asteroid+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_horizontal_line_asteroid+0)
	MOVWF       FSR1L+1 
L_move_asteroids51:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_move_asteroids51
	MOVLW       1
	MOVWF       FARG_draw_horizontal_line_color+0 
	CALL        _draw_horizontal_line+0, 0
;main.c,72 :: 		}
	GOTO        L_move_asteroids52
L_move_asteroids48:
;main.c,76 :: 		draw_horizontal_line(tmp[i], 0);
	MOVF        move_asteroids_i_L0+0, 0 
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
	ADDWF       FARG_move_asteroids_tmp+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_move_asteroids_tmp+1, 0 
	MOVWF       FSR0L+1 
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_draw_horizontal_line_asteroid+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_horizontal_line_asteroid+0)
	MOVWF       FSR1L+1 
L_move_asteroids53:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_move_asteroids53
	CLRF        FARG_draw_horizontal_line_color+0 
	CALL        _draw_horizontal_line+0, 0
;main.c,77 :: 		if (tmp[i].x <= 0)
	MOVF        move_asteroids_i_L0+0, 0 
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
	ADDWF       FARG_move_asteroids_tmp+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_move_asteroids_tmp+1, 0 
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
	GOTO        L_move_asteroids54
;main.c,79 :: 		tmp[i].x = 124;
	MOVF        move_asteroids_i_L0+0, 0 
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
	ADDWF       FARG_move_asteroids_tmp+0, 0 
	MOVWF       FSR1L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_move_asteroids_tmp+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       124
	MOVWF       POSTINC1+0 
;main.c,80 :: 		}
L_move_asteroids54:
;main.c,82 :: 		tmp[i].x--;
	MOVF        move_asteroids_i_L0+0, 0 
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
	ADDWF       FARG_move_asteroids_tmp+0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	ADDWFC      FARG_move_asteroids_tmp+1, 0 
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
;main.c,83 :: 		draw_horizontal_line(tmp[i], 1);
	MOVF        move_asteroids_i_L0+0, 0 
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
	ADDWF       FARG_move_asteroids_tmp+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_move_asteroids_tmp+1, 0 
	MOVWF       FSR0L+1 
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_draw_horizontal_line_asteroid+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_horizontal_line_asteroid+0)
	MOVWF       FSR1L+1 
L_move_asteroids55:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_move_asteroids55
	MOVLW       1
	MOVWF       FARG_draw_horizontal_line_color+0 
	CALL        _draw_horizontal_line+0, 0
;main.c,85 :: 		}
L_move_asteroids52:
;main.c,58 :: 		for (i = 0; i <= 3; i++)
	INCF        move_asteroids_i_L0+0, 1 
;main.c,87 :: 		}
	GOTO        L_move_asteroids45
L_move_asteroids46:
;main.c,89 :: 		}
L_end_move_asteroids:
	RETURN      0
; end of _move_asteroids

_main:

;main.c,93 :: 		void main() {
;main.c,94 :: 		uint8_t state = 2;
	MOVLW       2
	MOVWF       main_state_L0+0 
	CLRF        main_modeGame_L0+0 
;main.c,100 :: 		playerOne.rect.x = 64;
	MOVLW       64
	MOVWF       main_playerOne_L0+0 
;main.c,101 :: 		playerOne.rect.y = 32;
	MOVLW       32
	MOVWF       main_playerOne_L0+1 
;main.c,102 :: 		playerOne.rect.w = 1;
	MOVLW       1
	MOVWF       main_playerOne_L0+2 
;main.c,103 :: 		playerOne.rect.h = 1;
	MOVLW       1
	MOVWF       main_playerOne_L0+3 
;main.c,104 :: 		playerOne.vel.dx = 0;
	CLRF        main_playerOne_L0+4 
;main.c,105 :: 		playerOne.vel.dy = 1;
	MOVLW       1
	MOVWF       main_playerOne_L0+5 
;main.c,108 :: 		initAsteroids(asteroids);
	MOVLW       main_asteroids_L0+0
	MOVWF       FARG_initAsteroids_tmp+0 
	MOVLW       hi_addr(main_asteroids_L0+0)
	MOVWF       FARG_initAsteroids_tmp+1 
	CALL        _initAsteroids+0, 0
;main.c,112 :: 		ADCON1 = 0x0F;
	MOVLW       15
	MOVWF       ADCON1+0 
;main.c,113 :: 		Glcd_Init();
	CALL        _Glcd_Init+0, 0
;main.c,116 :: 		while (1)
L_main56:
;main.c,118 :: 		switch (state)
	GOTO        L_main58
;main.c,120 :: 		case TITLE:
L_main60:
;main.c,121 :: 		draw_InitFrame();
	CALL        _draw_InitFrame+0, 0
;main.c,122 :: 		state = MENU;
	MOVLW       1
	MOVWF       main_state_L0+0 
;main.c,123 :: 		break;
	GOTO        L_main59
;main.c,125 :: 		case MENU:
L_main61:
;main.c,126 :: 		state = draw_MenuGame(modeGame);
	MOVF        main_modeGame_L0+0, 0 
	MOVWF       FARG_draw_MenuGame_modeGame+0 
	CALL        _draw_MenuGame+0, 0
	MOVF        R0, 0 
	MOVWF       main_state_L0+0 
;main.c,127 :: 		break;
	GOTO        L_main59
;main.c,129 :: 		case ONEPLAYER:
L_main62:
;main.c,130 :: 		draw_clear();
	CALL        _draw_clear+0, 0
;main.c,131 :: 		draw_dot(playerOne, 1);
	MOVLW       6
	MOVWF       R0 
	MOVLW       FARG_draw_dot_player+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_dot_player+0)
	MOVWF       FSR1L+1 
	MOVLW       main_playerOne_L0+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(main_playerOne_L0+0)
	MOVWF       FSR0L+1 
L_main63:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main63
	MOVLW       1
	MOVWF       FARG_draw_dot_color+0 
	CALL        _draw_dot+0, 0
;main.c,132 :: 		while (1)
L_main64:
;main.c,134 :: 		draw_dot(playerOne, 0);
	MOVLW       6
	MOVWF       R0 
	MOVLW       FARG_draw_dot_player+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_dot_player+0)
	MOVWF       FSR1L+1 
	MOVLW       main_playerOne_L0+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(main_playerOne_L0+0)
	MOVWF       FSR0L+1 
L_main66:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main66
	CLRF        FARG_draw_dot_color+0 
	CALL        _draw_dot+0, 0
;main.c,136 :: 		playerOne = move_player(playerOne);
	MOVLW       6
	MOVWF       R0 
	MOVLW       FARG_move_player_player+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_move_player_player+0)
	MOVWF       FSR1L+1 
	MOVLW       main_playerOne_L0+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(main_playerOne_L0+0)
	MOVWF       FSR0L+1 
L_main67:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main67
	MOVLW       FLOC__main+0
	MOVWF       R0 
	MOVLW       hi_addr(FLOC__main+0)
	MOVWF       R1 
	CALL        _move_player+0, 0
	MOVLW       6
	MOVWF       R0 
	MOVLW       main_playerOne_L0+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(main_playerOne_L0+0)
	MOVWF       FSR1L+1 
	MOVLW       FLOC__main+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FLOC__main+0)
	MOVWF       FSR0L+1 
L_main68:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main68
;main.c,139 :: 		move_asteroids(asteroids);
	MOVLW       main_asteroids_L0+0
	MOVWF       FARG_move_asteroids_tmp+0 
	MOVLW       hi_addr(main_asteroids_L0+0)
	MOVWF       FARG_move_asteroids_tmp+1 
	CALL        _move_asteroids+0, 0
;main.c,141 :: 		draw_dot(playerOne, 1);
	MOVLW       6
	MOVWF       R0 
	MOVLW       FARG_draw_dot_player+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_dot_player+0)
	MOVWF       FSR1L+1 
	MOVLW       main_playerOne_L0+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(main_playerOne_L0+0)
	MOVWF       FSR0L+1 
L_main69:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main69
	MOVLW       1
	MOVWF       FARG_draw_dot_color+0 
	CALL        _draw_dot+0, 0
;main.c,142 :: 		Delay_ms(60);
	MOVLW       156
	MOVWF       R12, 0
	MOVLW       215
	MOVWF       R13, 0
L_main70:
	DECFSZ      R13, 1, 1
	BRA         L_main70
	DECFSZ      R12, 1, 1
	BRA         L_main70
;main.c,145 :: 		}
	GOTO        L_main64
;main.c,150 :: 		default:
L_main71:
;main.c,151 :: 		break;
	GOTO        L_main59
;main.c,152 :: 		}
L_main58:
	MOVF        main_state_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main60
	MOVF        main_state_L0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main61
	MOVF        main_state_L0+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_main62
	GOTO        L_main71
L_main59:
;main.c,153 :: 		}
	GOTO        L_main56
;main.c,157 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

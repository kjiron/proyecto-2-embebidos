
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

;proyecto-2-embebido,30 :: 		
;proyecto-2-embebido,32 :: 		
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;proyecto-2-embebido,33 :: 		
L_end_draw_clear:
	RETURN      0
; end of _draw_clear

_draw_InitFrame:

;proyecto-2-embebido,36 :: 		
;proyecto-2-embebido,37 :: 		
	MOVLW       _titleFrame+0
	MOVWF       FARG_Glcd_Image_image+0 
	MOVLW       hi_addr(_titleFrame+0)
	MOVWF       FARG_Glcd_Image_image+1 
	MOVLW       higher_addr(_titleFrame+0)
	MOVWF       FARG_Glcd_Image_image+2 
	CALL        _Glcd_Image+0, 0
;proyecto-2-embebido,38 :: 		
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
;proyecto-2-embebido,39 :: 		
	CALL        _draw_clear+0, 0
;proyecto-2-embebido,40 :: 		
L_end_draw_InitFrame:
	RETURN      0
; end of _draw_InitFrame

_draw_MenuFrame:

;proyecto-2-embebido,42 :: 		
;proyecto-2-embebido,43 :: 		
	MOVLW       _menuFrame+0
	MOVWF       FARG_Glcd_Image_image+0 
	MOVLW       hi_addr(_menuFrame+0)
	MOVWF       FARG_Glcd_Image_image+1 
	MOVLW       higher_addr(_menuFrame+0)
	MOVWF       FARG_Glcd_Image_image+2 
	CALL        _Glcd_Image+0, 0
;proyecto-2-embebido,44 :: 		
L_end_draw_MenuFrame:
	RETURN      0
; end of _draw_MenuFrame

_draw_circle:

;proyecto-2-embebido,47 :: 		
;proyecto-2-embebido,50 :: 		
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
;proyecto-2-embebido,51 :: 		
L_end_draw_circle:
	RETURN      0
; end of _draw_circle

_draw_dot:

;proyecto-2-embebido,53 :: 		
;proyecto-2-embebido,55 :: 		
	MOVF        FARG_draw_dot_player+0, 0 
	MOVWF       FARG_Glcd_Dot_x_pos+0 
	MOVF        FARG_draw_dot_player+1, 0 
	MOVWF       FARG_Glcd_Dot_y_pos+0 
	MOVF        FARG_draw_dot_color+0, 0 
	MOVWF       FARG_Glcd_Dot_color+0 
	CALL        _Glcd_Dot+0, 0
;proyecto-2-embebido,56 :: 		
L_end_draw_dot:
	RETURN      0
; end of _draw_dot

_draw_horizontal_line:

;proyecto-2-embebido,58 :: 		
;proyecto-2-embebido,60 :: 		
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
;proyecto-2-embebido,61 :: 		
L_end_draw_horizontal_line:
	RETURN      0
; end of _draw_horizontal_line

_draw_box:

;proyecto-2-embebido,63 :: 		
;proyecto-2-embebido,66 :: 		
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
;proyecto-2-embebido,67 :: 		
L_end_draw_box:
	RETURN      0
; end of _draw_box

_draw_MenuGame:

;proyecto-2-embebido,71 :: 		
;proyecto-2-embebido,74 :: 		
	MOVLW       25
	MOVWF       draw_MenuGame_select_L0+0 
	MOVLW       34
	MOVWF       draw_MenuGame_select_L0+1 
	MOVLW       3
	MOVWF       draw_MenuGame_select_L0+2 
	CLRF        draw_MenuGame_select_L0+3 
;proyecto-2-embebido,75 :: 		
	CALL        _draw_MenuFrame+0, 0
;proyecto-2-embebido,76 :: 		
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
;proyecto-2-embebido,78 :: 		
L_draw_MenuGame3:
;proyecto-2-embebido,80 :: 		
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
;proyecto-2-embebido,82 :: 		
	MOVF        draw_MenuGame_key_L0+2, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_draw_MenuGame8
	MOVF        FARG_draw_MenuGame_modeGame+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame8
L__draw_MenuGame94:
;proyecto-2-embebido,84 :: 		
	CALL        _draw_clear+0, 0
;proyecto-2-embebido,85 :: 		
	MOVLW       2
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_draw_MenuGame
;proyecto-2-embebido,86 :: 		
L_draw_MenuGame8:
;proyecto-2-embebido,87 :: 		
	MOVF        draw_MenuGame_key_L0+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__draw_MenuGame93
	MOVF        draw_MenuGame_key_L0+1, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__draw_MenuGame93
	GOTO        L_draw_MenuGame13
L__draw_MenuGame93:
	MOVF        FARG_draw_MenuGame_modeGame+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame13
L__draw_MenuGame92:
;proyecto-2-embebido,89 :: 		
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
;proyecto-2-embebido,90 :: 		
	MOVLW       14
	ADDWF       draw_MenuGame_select_L0+1, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       draw_MenuGame_select_L0+1 
;proyecto-2-embebido,91 :: 		
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
;proyecto-2-embebido,92 :: 		
	MOVLW       1
	MOVWF       FARG_draw_MenuGame_modeGame+0 
;proyecto-2-embebido,93 :: 		
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
;proyecto-2-embebido,94 :: 		
	GOTO        L_draw_MenuGame3
;proyecto-2-embebido,95 :: 		
L_draw_MenuGame13:
;proyecto-2-embebido,96 :: 		
	MOVF        draw_MenuGame_key_L0+2, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_draw_MenuGame19
	MOVF        FARG_draw_MenuGame_modeGame+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame19
L__draw_MenuGame91:
;proyecto-2-embebido,98 :: 		
	CALL        _draw_clear+0, 0
;proyecto-2-embebido,99 :: 		
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_draw_MenuGame
;proyecto-2-embebido,100 :: 		
L_draw_MenuGame19:
;proyecto-2-embebido,101 :: 		
	MOVF        draw_MenuGame_key_L0+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__draw_MenuGame90
	MOVF        draw_MenuGame_key_L0+1, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__draw_MenuGame90
	GOTO        L_draw_MenuGame24
L__draw_MenuGame90:
	MOVF        FARG_draw_MenuGame_modeGame+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame24
L__draw_MenuGame89:
;proyecto-2-embebido,103 :: 		
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
;proyecto-2-embebido,104 :: 		
	MOVLW       14
	SUBWF       draw_MenuGame_select_L0+1, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       draw_MenuGame_select_L0+1 
;proyecto-2-embebido,105 :: 		
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
;proyecto-2-embebido,106 :: 		
	CLRF        FARG_draw_MenuGame_modeGame+0 
;proyecto-2-embebido,107 :: 		
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
;proyecto-2-embebido,108 :: 		
L_draw_MenuGame24:
;proyecto-2-embebido,109 :: 		
	GOTO        L_draw_MenuGame3
;proyecto-2-embebido,110 :: 		
L_end_draw_MenuGame:
	RETURN      0
; end of _draw_MenuGame

_draw_partial_image:

;proyecto-2-embebido,113 :: 		
;proyecto-2-embebido,117 :: 		
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
;proyecto-2-embebido,123 :: 		
L_end_draw_partial_image:
	RETURN      0
; end of _draw_partial_image

main_check_collision00:

;proyecto-2-embebido,15 :: 		
;proyecto-2-embebido,17 :: 		
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
;proyecto-2-embebido,18 :: 		
	MOVLW       128
	BTFSC       FARG_main_check_collision00_rect1+0, 7 
	MOVLW       127
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main_check_collision00106
	MOVF        R1, 0 
	SUBWF       FARG_main_check_collision00_rect1+0, 0 
L_main_check_collision00106:
	BTFSC       STATUS+0, 0 
	GOTO        L_main_check_collision0029
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
	GOTO        L_main_check_collision00107
	MOVF        R1, 0 
	SUBWF       FARG_main_check_collision00_rect2+0, 0 
L_main_check_collision00107:
	BTFSC       STATUS+0, 0 
	GOTO        L_main_check_collision0029
;proyecto-2-embebido,19 :: 		
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
	GOTO        L_main_check_collision00108
	MOVF        R1, 0 
	SUBWF       FARG_main_check_collision00_rect1+1, 0 
L_main_check_collision00108:
	BTFSC       STATUS+0, 0 
	GOTO        L_main_check_collision0029
;proyecto-2-embebido,20 :: 		
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
	GOTO        L_main_check_collision00109
	MOVF        R1, 0 
	SUBWF       FARG_main_check_collision00_rect2+1, 0 
L_main_check_collision00109:
	BTFSC       STATUS+0, 0 
	GOTO        L_main_check_collision0029
	MOVLW       1
	MOVWF       R0 
	GOTO        L_main_check_collision0028
L_main_check_collision0029:
	CLRF        R0 
L_main_check_collision0028:
;proyecto-2-embebido,21 :: 		
L_end_check_collision00:
	RETURN      0
; end of main_check_collision00

_check_collision:

;proyecto-2-embebido,24 :: 		
;proyecto-2-embebido,26 :: 		
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
L_check_collision30:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_check_collision30
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
L_check_collision31:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_check_collision31
	CALL        main_check_collision00+0, 0
;proyecto-2-embebido,27 :: 		
L_end_check_collision:
	RETURN      0
; end of _check_collision

_randint:

;proyecto-2-embebido,30 :: 		
;proyecto-2-embebido,32 :: 		
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
;proyecto-2-embebido,33 :: 		
L_end_randint:
	RETURN      0
; end of _randint

_move_player:

;proyecto-2-embebido,36 :: 		
	MOVF        R0, 0 
	MOVWF       _move_player_su_addr+0 
	MOVF        R1, 0 
	MOVWF       _move_player_su_addr+1 
;proyecto-2-embebido,40 :: 		
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
L_move_player32:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_move_player32
;proyecto-2-embebido,42 :: 		
	CLRF        move_player_i_L0+0 
L_move_player33:
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__move_player113
	MOVF        move_player_i_L0+0, 0 
	SUBLW       12
L__move_player113:
	BTFSS       STATUS+0, 0 
	GOTO        L_move_player34
;proyecto-2-embebido,43 :: 		
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
L_move_player36:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_move_player36
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
L_move_player37:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_move_player37
	CALL        _check_collision+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_move_player38
;proyecto-2-embebido,45 :: 		
	MOVLW       32
	MOVWF       FARG_move_player_player+0 
;proyecto-2-embebido,46 :: 		
	MOVLW       55
	MOVWF       FARG_move_player_player+1 
;proyecto-2-embebido,47 :: 		
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
L_move_player39:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_move_player39
	GOTO        L_end_move_player
;proyecto-2-embebido,48 :: 		
L_move_player38:
;proyecto-2-embebido,42 :: 		
	INCF        move_player_i_L0+0, 1 
;proyecto-2-embebido,50 :: 		
	GOTO        L_move_player33
L_move_player34:
;proyecto-2-embebido,53 :: 		
	MOVF        move_player_key_L0+1, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_move_player40
;proyecto-2-embebido,54 :: 		
	MOVF        FARG_move_player_player+5, 0 
	ADDWF       FARG_move_player_player+1, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	MOVWF       FARG_move_player_player+1 
;proyecto-2-embebido,56 :: 		
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
	GOTO        L__move_player114
	MOVLW       63
	SUBWF       R2, 0 
L__move_player114:
	BTFSS       STATUS+0, 0 
	GOTO        L_move_player41
;proyecto-2-embebido,57 :: 		
	MOVLW       55
	MOVWF       FARG_move_player_player+1 
;proyecto-2-embebido,58 :: 		
L_move_player41:
;proyecto-2-embebido,59 :: 		
	GOTO        L_move_player42
L_move_player40:
;proyecto-2-embebido,61 :: 		
	MOVF        move_player_key_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_move_player43
;proyecto-2-embebido,62 :: 		
	MOVF        FARG_move_player_player+5, 0 
	SUBWF       FARG_move_player_player+1, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       FARG_move_player_player+1 
;proyecto-2-embebido,63 :: 		
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	XORWF       R1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_move_player44
;proyecto-2-embebido,64 :: 		
	CLRF        FARG_move_player_player+1 
;proyecto-2-embebido,65 :: 		
L_move_player44:
;proyecto-2-embebido,66 :: 		
	GOTO        L_move_player45
L_move_player43:
;proyecto-2-embebido,72 :: 		
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
L_move_player46:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_move_player46
	GOTO        L_end_move_player
;proyecto-2-embebido,73 :: 		
L_move_player45:
L_move_player42:
;proyecto-2-embebido,75 :: 		
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
L_move_player47:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_move_player47
;proyecto-2-embebido,77 :: 		
L_end_move_player:
	RETURN      0
; end of _move_player

_initEnvironment:

;proyecto-2-embebido,81 :: 		
;proyecto-2-embebido,84 :: 		
	CLRF        initEnvironment_offset_x_L0+0 
;proyecto-2-embebido,85 :: 		
	MOVLW       53
	MOVWF       initEnvironment_offset_y_L0+0 
;proyecto-2-embebido,86 :: 		
	CLRF        initEnvironment_i_L0+0 
L_initEnvironment48:
	MOVF        initEnvironment_i_L0+0, 0 
	SUBLW       12
	BTFSS       STATUS+0, 0 
	GOTO        L_initEnvironment49
;proyecto-2-embebido,88 :: 		
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
;proyecto-2-embebido,89 :: 		
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
;proyecto-2-embebido,90 :: 		
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
;proyecto-2-embebido,91 :: 		
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
;proyecto-2-embebido,93 :: 		
	MOVLW       123
	MOVWF       FARG_randint_n+0 
	CALL        _randint+0, 0
	MOVF        R0, 0 
	MOVWF       initEnvironment_offset_x_L0+0 
;proyecto-2-embebido,94 :: 		
	MOVLW       4
	SUBWF       initEnvironment_offset_y_L0+0, 1 
;proyecto-2-embebido,86 :: 		
	INCF        initEnvironment_i_L0+0, 1 
;proyecto-2-embebido,95 :: 		
	GOTO        L_initEnvironment48
L_initEnvironment49:
;proyecto-2-embebido,96 :: 		
L_end_initEnvironment:
	RETURN      0
; end of _initEnvironment

_environment:

;proyecto-2-embebido,99 :: 		
;proyecto-2-embebido,102 :: 		
	CLRF        R4 
L_environment51:
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__environment117
	MOVF        R4, 0 
	SUBLW       12
L__environment117:
	BTFSS       STATUS+0, 0 
	GOTO        L_environment52
;proyecto-2-embebido,104 :: 		
	MOVLW       1
	ANDWF       R4, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_environment54
;proyecto-2-embebido,106 :: 		
	MOVF        R4, 0 
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
	GOTO        L_environment55
;proyecto-2-embebido,108 :: 		
	MOVF        R4, 0 
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
;proyecto-2-embebido,109 :: 		
L_environment55:
;proyecto-2-embebido,110 :: 		
	MOVF        R4, 0 
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
;proyecto-2-embebido,111 :: 		
	GOTO        L_environment56
L_environment54:
;proyecto-2-embebido,114 :: 		
	MOVF        R4, 0 
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
	GOTO        L_environment57
;proyecto-2-embebido,116 :: 		
	MOVF        R4, 0 
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
;proyecto-2-embebido,117 :: 		
L_environment57:
;proyecto-2-embebido,118 :: 		
	MOVF        R4, 0 
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
;proyecto-2-embebido,119 :: 		
L_environment56:
;proyecto-2-embebido,102 :: 		
	INCF        R4, 1 
;proyecto-2-embebido,120 :: 		
	GOTO        L_environment51
L_environment52:
;proyecto-2-embebido,122 :: 		
L_end_environment:
	RETURN      0
; end of _environment

_InitTimer0:

;main.c,15 :: 		void InitTimer0(){
;main.c,16 :: 		T0CON         = 0x83;
	MOVLW       131
	MOVWF       T0CON+0 
;main.c,17 :: 		TMR0H         = 0x0B;
	MOVLW       11
	MOVWF       TMR0H+0 
;main.c,18 :: 		TMR0L         = 0xDC;
	MOVLW       220
	MOVWF       TMR0L+0 
;main.c,19 :: 		GIE_bit       = 1;
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;main.c,20 :: 		TMR0IE_bit    = 1;
	BSF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;main.c,21 :: 		}
L_end_InitTimer0:
	RETURN      0
; end of _InitTimer0

_Interrupt:

;main.c,23 :: 		void Interrupt(){
;main.c,24 :: 		if (TMR0IF_bit){
	BTFSS       TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
	GOTO        L_Interrupt58
;main.c,25 :: 		TMR0IF_bit = 0;
	BCF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
;main.c,26 :: 		TMR0H         = 0x0B;
	MOVLW       11
	MOVWF       TMR0H+0 
;main.c,27 :: 		TMR0L         = 0xDC;
	MOVLW       220
	MOVWF       TMR0L+0 
;main.c,29 :: 		contador_ms++;
	INCF        _contador_ms+0, 1 
;main.c,30 :: 		if (contador_ms >= 2)
	MOVLW       2
	SUBWF       _contador_ms+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_Interrupt59
;main.c,32 :: 		timeFlag = 1;
	MOVLW       1
	MOVWF       _timeFlag+0 
;main.c,33 :: 		contador_ms = 0;
	CLRF        _contador_ms+0 
;main.c,34 :: 		}
L_Interrupt59:
;main.c,35 :: 		}
L_Interrupt58:
;main.c,36 :: 		}
L_end_Interrupt:
L__Interrupt120:
	RETFIE      1
; end of _Interrupt

_main:

;main.c,41 :: 		void main() {
;main.c,43 :: 		uint8_t state = 2;
	MOVLW       2
	MOVWF       main_state_L0+0 
	CLRF        main_modeGame_L0+0 
;main.c,51 :: 		playerOne.rect.x = 32;
	MOVLW       32
	MOVWF       main_playerOne_L0+0 
;main.c,52 :: 		playerOne.rect.y = 55;
	MOVLW       55
	MOVWF       main_playerOne_L0+1 
;main.c,53 :: 		playerOne.rect.w = 9;
	MOVLW       9
	MOVWF       main_playerOne_L0+2 
;main.c,54 :: 		playerOne.rect.h = 9;
	MOVLW       9
	MOVWF       main_playerOne_L0+3 
;main.c,55 :: 		playerOne.vel.dx = 0;
	CLRF        main_playerOne_L0+4 
;main.c,56 :: 		playerOne.vel.dy = 1;
	MOVLW       1
	MOVWF       main_playerOne_L0+5 
;main.c,61 :: 		timer.x = 62;
	MOVLW       62
	MOVWF       main_timer_L0+0 
;main.c,62 :: 		timer.y = 3;
	MOVLW       3
	MOVWF       main_timer_L0+1 
;main.c,63 :: 		timer.w = 1;
	MOVLW       1
	MOVWF       main_timer_L0+2 
;main.c,64 :: 		timer.h = 60;
	MOVLW       60
	MOVWF       main_timer_L0+3 
;main.c,67 :: 		initEnvironment(m);
	MOVLW       main_m_L0+0
	MOVWF       FARG_initEnvironment_s+0 
	MOVLW       hi_addr(main_m_L0+0)
	MOVWF       FARG_initEnvironment_s+1 
	CALL        _initEnvironment+0, 0
;main.c,70 :: 		ADCON1 = 0x0F;
	MOVLW       15
	MOVWF       ADCON1+0 
;main.c,71 :: 		Glcd_Init();
	CALL        _Glcd_Init+0, 0
;main.c,72 :: 		InitTimer0();
	CALL        _InitTimer0+0, 0
;main.c,76 :: 		while (1)
L_main60:
;main.c,78 :: 		switch (state)
	GOTO        L_main62
;main.c,80 :: 		case TITLE:
L_main64:
;main.c,81 :: 		draw_InitFrame();
	CALL        _draw_InitFrame+0, 0
;main.c,82 :: 		state = MENU;
	MOVLW       1
	MOVWF       main_state_L0+0 
;main.c,83 :: 		break;
	GOTO        L_main63
;main.c,85 :: 		case MENU:
L_main65:
;main.c,86 :: 		state = draw_MenuGame(modeGame);
	MOVF        main_modeGame_L0+0, 0 
	MOVWF       FARG_draw_MenuGame_modeGame+0 
	CALL        _draw_MenuGame+0, 0
	MOVF        R0, 0 
	MOVWF       main_state_L0+0 
;main.c,87 :: 		break;
	GOTO        L_main63
;main.c,89 :: 		case ONEPLAYER:
L_main66:
;main.c,90 :: 		draw_clear();
	CALL        _draw_clear+0, 0
;main.c,91 :: 		draw_partial_image(playerOne.rect, ship);
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_draw_partial_image_player+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_partial_image_player+0)
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
	MOVLW       _ship+0
	MOVWF       FARG_draw_partial_image_image+0 
	MOVLW       hi_addr(_ship+0)
	MOVWF       FARG_draw_partial_image_image+1 
	MOVLW       higher_addr(_ship+0)
	MOVWF       FARG_draw_partial_image_image+2 
	CALL        _draw_partial_image+0, 0
;main.c,93 :: 		draw_box(timer, DRAW);
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_draw_box_r+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_box_r+0)
	MOVWF       FSR1L+1 
	MOVLW       main_timer_L0+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(main_timer_L0+0)
	MOVWF       FSR0L+1 
L_main68:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main68
	MOVLW       1
	MOVWF       FARG_draw_box_color+0 
	CALL        _draw_box+0, 0
;main.c,95 :: 		while (1)
L_main69:
;main.c,97 :: 		if (timer.y >= 63)
	MOVLW       128
	XORWF       main_timer_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       63
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main71
;main.c,99 :: 		timer.y = 3;
	MOVLW       3
	MOVWF       main_timer_L0+1 
;main.c,100 :: 		}
L_main71:
;main.c,102 :: 		if (timeFlag)
	MOVF        _timeFlag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main72
;main.c,104 :: 		timer.y++;
	MOVF        main_timer_L0+1, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       main_timer_L0+1 
;main.c,105 :: 		timeFlag = 0;
	CLRF        _timeFlag+0 
;main.c,106 :: 		}
L_main72:
;main.c,108 :: 		playerOne = move_player(playerOne, m);
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
L_main73:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main73
	MOVLW       main_m_L0+0
	MOVWF       FARG_move_player_a+0 
	MOVLW       hi_addr(main_m_L0+0)
	MOVWF       FARG_move_player_a+1 
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
L_main74:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main74
;main.c,110 :: 		environment(m);
	MOVLW       main_m_L0+0
	MOVWF       FARG_environment_s+0 
	MOVLW       hi_addr(main_m_L0+0)
	MOVWF       FARG_environment_s+1 
	CALL        _environment+0, 0
;main.c,111 :: 		draw_box(timer, DRAW);
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_draw_box_r+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_box_r+0)
	MOVWF       FSR1L+1 
	MOVLW       main_timer_L0+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(main_timer_L0+0)
	MOVWF       FSR0L+1 
L_main75:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main75
	MOVLW       1
	MOVWF       FARG_draw_box_color+0 
	CALL        _draw_box+0, 0
;main.c,112 :: 		draw_partial_image(playerOne.rect, ship);
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_draw_partial_image_player+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_partial_image_player+0)
	MOVWF       FSR1L+1 
	MOVLW       main_playerOne_L0+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(main_playerOne_L0+0)
	MOVWF       FSR0L+1 
L_main76:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main76
	MOVLW       _ship+0
	MOVWF       FARG_draw_partial_image_image+0 
	MOVLW       hi_addr(_ship+0)
	MOVWF       FARG_draw_partial_image_image+1 
	MOVLW       higher_addr(_ship+0)
	MOVWF       FARG_draw_partial_image_image+2 
	CALL        _draw_partial_image+0, 0
;main.c,113 :: 		for (i = 0; i <= NUM_ASTEROIDS - 1; i++){
	CLRF        main_i_L0+0 
L_main77:
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main122
	MOVF        main_i_L0+0, 0 
	SUBLW       12
L__main122:
	BTFSS       STATUS+0, 0 
	GOTO        L_main78
;main.c,114 :: 		draw_horizontal_line(m[i], DRAW);
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
L_main80:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main80
	MOVLW       1
	MOVWF       FARG_draw_horizontal_line_color+0 
	CALL        _draw_horizontal_line+0, 0
;main.c,113 :: 		for (i = 0; i <= NUM_ASTEROIDS - 1; i++){
	INCF        main_i_L0+0, 1 
;main.c,115 :: 		}
	GOTO        L_main77
L_main78:
;main.c,116 :: 		Delay_ms(60);
	MOVLW       156
	MOVWF       R12, 0
	MOVLW       215
	MOVWF       R13, 0
L_main81:
	DECFSZ      R13, 1, 1
	BRA         L_main81
	DECFSZ      R12, 1, 1
	BRA         L_main81
;main.c,117 :: 		for (i = 0; i <= NUM_ASTEROIDS - 1; i++){
	CLRF        main_i_L0+0 
L_main82:
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main123
	MOVF        main_i_L0+0, 0 
	SUBLW       12
L__main123:
	BTFSS       STATUS+0, 0 
	GOTO        L_main83
;main.c,118 :: 		draw_horizontal_line(m[i], ERASE);
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
L_main85:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main85
	CLRF        FARG_draw_horizontal_line_color+0 
	CALL        _draw_horizontal_line+0, 0
;main.c,117 :: 		for (i = 0; i <= NUM_ASTEROIDS - 1; i++){
	INCF        main_i_L0+0, 1 
;main.c,119 :: 		}
	GOTO        L_main82
L_main83:
;main.c,120 :: 		draw_box(timer, ERASE);
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_draw_box_r+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_box_r+0)
	MOVWF       FSR1L+1 
	MOVLW       main_timer_L0+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(main_timer_L0+0)
	MOVWF       FSR0L+1 
L_main86:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main86
	CLRF        FARG_draw_box_color+0 
	CALL        _draw_box+0, 0
;main.c,121 :: 		draw_partial_image(playerOne.rect, parche);
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_draw_partial_image_player+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_partial_image_player+0)
	MOVWF       FSR1L+1 
	MOVLW       main_playerOne_L0+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(main_playerOne_L0+0)
	MOVWF       FSR0L+1 
L_main87:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main87
	MOVLW       _parche+0
	MOVWF       FARG_draw_partial_image_image+0 
	MOVLW       hi_addr(_parche+0)
	MOVWF       FARG_draw_partial_image_image+1 
	MOVLW       higher_addr(_parche+0)
	MOVWF       FARG_draw_partial_image_image+2 
	CALL        _draw_partial_image+0, 0
;main.c,122 :: 		}
	GOTO        L_main69
;main.c,127 :: 		default:
L_main88:
;main.c,128 :: 		break;
	GOTO        L_main63
;main.c,129 :: 		}
L_main62:
	MOVF        main_state_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main64
	MOVF        main_state_L0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main65
	MOVF        main_state_L0+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_main66
	GOTO        L_main88
L_main63:
;main.c,130 :: 		}
	GOTO        L_main60
;main.c,134 :: 		}
L_end_main:
	GOTO        $+0
; end of _main


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

;proyecto-2-embebido,33 :: 		
;proyecto-2-embebido,35 :: 		
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;proyecto-2-embebido,36 :: 		
L_end_draw_clear:
	RETURN      0
; end of _draw_clear

_draw_InitFrame:

;proyecto-2-embebido,39 :: 		
;proyecto-2-embebido,40 :: 		
	MOVLW       _titleFrame+0
	MOVWF       FARG_Glcd_Image_image+0 
	MOVLW       hi_addr(_titleFrame+0)
	MOVWF       FARG_Glcd_Image_image+1 
	MOVLW       higher_addr(_titleFrame+0)
	MOVWF       FARG_Glcd_Image_image+2 
	CALL        _Glcd_Image+0, 0
;proyecto-2-embebido,41 :: 		
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
;proyecto-2-embebido,42 :: 		
	CALL        _draw_clear+0, 0
;proyecto-2-embebido,43 :: 		
L_end_draw_InitFrame:
	RETURN      0
; end of _draw_InitFrame

_draw_MenuFrame:

;proyecto-2-embebido,45 :: 		
;proyecto-2-embebido,46 :: 		
	MOVLW       _menuFrame+0
	MOVWF       FARG_Glcd_Image_image+0 
	MOVLW       hi_addr(_menuFrame+0)
	MOVWF       FARG_Glcd_Image_image+1 
	MOVLW       higher_addr(_menuFrame+0)
	MOVWF       FARG_Glcd_Image_image+2 
	CALL        _Glcd_Image+0, 0
;proyecto-2-embebido,47 :: 		
L_end_draw_MenuFrame:
	RETURN      0
; end of _draw_MenuFrame

_draw_winFrame:

;proyecto-2-embebido,49 :: 		
;proyecto-2-embebido,50 :: 		
	MOVLW       _winScreen+0
	MOVWF       FARG_Glcd_Image_image+0 
	MOVLW       hi_addr(_winScreen+0)
	MOVWF       FARG_Glcd_Image_image+1 
	MOVLW       higher_addr(_winScreen+0)
	MOVWF       FARG_Glcd_Image_image+2 
	CALL        _Glcd_Image+0, 0
;proyecto-2-embebido,51 :: 		
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_draw_winFrame2:
	DECFSZ      R13, 1, 1
	BRA         L_draw_winFrame2
	DECFSZ      R12, 1, 1
	BRA         L_draw_winFrame2
	DECFSZ      R11, 1, 1
	BRA         L_draw_winFrame2
;proyecto-2-embebido,52 :: 		
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;proyecto-2-embebido,54 :: 		
L_end_draw_winFrame:
	RETURN      0
; end of _draw_winFrame

_draw_circle:

;proyecto-2-embebido,57 :: 		
;proyecto-2-embebido,60 :: 		
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
;proyecto-2-embebido,61 :: 		
L_end_draw_circle:
	RETURN      0
; end of _draw_circle

_draw_dot:

;proyecto-2-embebido,63 :: 		
;proyecto-2-embebido,65 :: 		
	MOVF        FARG_draw_dot_player+0, 0 
	MOVWF       FARG_Glcd_Dot_x_pos+0 
	MOVF        FARG_draw_dot_player+1, 0 
	MOVWF       FARG_Glcd_Dot_y_pos+0 
	MOVF        FARG_draw_dot_color+0, 0 
	MOVWF       FARG_Glcd_Dot_color+0 
	CALL        _Glcd_Dot+0, 0
;proyecto-2-embebido,66 :: 		
L_end_draw_dot:
	RETURN      0
; end of _draw_dot

_draw_horizontal_line:

;proyecto-2-embebido,68 :: 		
;proyecto-2-embebido,70 :: 		
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
;proyecto-2-embebido,71 :: 		
L_end_draw_horizontal_line:
	RETURN      0
; end of _draw_horizontal_line

_draw_box:

;proyecto-2-embebido,73 :: 		
;proyecto-2-embebido,76 :: 		
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
;proyecto-2-embebido,77 :: 		
L_end_draw_box:
	RETURN      0
; end of _draw_box

_draw_MenuGame:

;proyecto-2-embebido,81 :: 		
;proyecto-2-embebido,84 :: 		
	MOVLW       25
	MOVWF       draw_MenuGame_select_L0+0 
	MOVLW       34
	MOVWF       draw_MenuGame_select_L0+1 
	MOVLW       3
	MOVWF       draw_MenuGame_select_L0+2 
	CLRF        draw_MenuGame_select_L0+3 
;proyecto-2-embebido,85 :: 		
	CALL        _draw_MenuFrame+0, 0
;proyecto-2-embebido,86 :: 		
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
L_draw_MenuGame3:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame3
	MOVLW       1
	MOVWF       FARG_draw_circle_color+0 
	CALL        _draw_circle+0, 0
;proyecto-2-embebido,88 :: 		
L_draw_MenuGame4:
;proyecto-2-embebido,90 :: 		
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
L_draw_MenuGame6:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame6
;proyecto-2-embebido,92 :: 		
	MOVF        draw_MenuGame_key_L0+2, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_draw_MenuGame9
	MOVF        FARG_draw_MenuGame_modeGame+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame9
L__draw_MenuGame96:
;proyecto-2-embebido,94 :: 		
	CALL        _draw_clear+0, 0
;proyecto-2-embebido,95 :: 		
	MOVLW       2
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_draw_MenuGame
;proyecto-2-embebido,96 :: 		
L_draw_MenuGame9:
;proyecto-2-embebido,97 :: 		
	MOVF        draw_MenuGame_key_L0+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__draw_MenuGame95
	MOVF        draw_MenuGame_key_L0+1, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__draw_MenuGame95
	GOTO        L_draw_MenuGame14
L__draw_MenuGame95:
	MOVF        FARG_draw_MenuGame_modeGame+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame14
L__draw_MenuGame94:
;proyecto-2-embebido,99 :: 		
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
	CLRF        FARG_draw_circle_color+0 
	CALL        _draw_circle+0, 0
;proyecto-2-embebido,100 :: 		
	MOVLW       14
	ADDWF       draw_MenuGame_select_L0+1, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       draw_MenuGame_select_L0+1 
;proyecto-2-embebido,101 :: 		
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
L_draw_MenuGame16:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame16
	MOVLW       1
	MOVWF       FARG_draw_circle_color+0 
	CALL        _draw_circle+0, 0
;proyecto-2-embebido,102 :: 		
	MOVLW       1
	MOVWF       FARG_draw_MenuGame_modeGame+0 
;proyecto-2-embebido,103 :: 		
	MOVLW       7
	MOVWF       R11, 0
	MOVLW       194
	MOVWF       R12, 0
	MOVLW       216
	MOVWF       R13, 0
L_draw_MenuGame17:
	DECFSZ      R13, 1, 1
	BRA         L_draw_MenuGame17
	DECFSZ      R12, 1, 1
	BRA         L_draw_MenuGame17
	DECFSZ      R11, 1, 1
	BRA         L_draw_MenuGame17
	NOP
;proyecto-2-embebido,104 :: 		
	GOTO        L_draw_MenuGame4
;proyecto-2-embebido,105 :: 		
L_draw_MenuGame14:
;proyecto-2-embebido,106 :: 		
	MOVF        draw_MenuGame_key_L0+2, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_draw_MenuGame20
	MOVF        FARG_draw_MenuGame_modeGame+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame20
L__draw_MenuGame93:
;proyecto-2-embebido,108 :: 		
	CALL        _draw_clear+0, 0
;proyecto-2-embebido,109 :: 		
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_draw_MenuGame
;proyecto-2-embebido,110 :: 		
L_draw_MenuGame20:
;proyecto-2-embebido,111 :: 		
	MOVF        draw_MenuGame_key_L0+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__draw_MenuGame92
	MOVF        draw_MenuGame_key_L0+1, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__draw_MenuGame92
	GOTO        L_draw_MenuGame25
L__draw_MenuGame92:
	MOVF        FARG_draw_MenuGame_modeGame+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame25
L__draw_MenuGame91:
;proyecto-2-embebido,113 :: 		
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
	CLRF        FARG_draw_circle_color+0 
	CALL        _draw_circle+0, 0
;proyecto-2-embebido,114 :: 		
	MOVLW       14
	SUBWF       draw_MenuGame_select_L0+1, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       draw_MenuGame_select_L0+1 
;proyecto-2-embebido,115 :: 		
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
L_draw_MenuGame27:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame27
	MOVLW       1
	MOVWF       FARG_draw_circle_color+0 
	CALL        _draw_circle+0, 0
;proyecto-2-embebido,116 :: 		
	CLRF        FARG_draw_MenuGame_modeGame+0 
;proyecto-2-embebido,117 :: 		
	MOVLW       7
	MOVWF       R11, 0
	MOVLW       194
	MOVWF       R12, 0
	MOVLW       216
	MOVWF       R13, 0
L_draw_MenuGame28:
	DECFSZ      R13, 1, 1
	BRA         L_draw_MenuGame28
	DECFSZ      R12, 1, 1
	BRA         L_draw_MenuGame28
	DECFSZ      R11, 1, 1
	BRA         L_draw_MenuGame28
	NOP
;proyecto-2-embebido,118 :: 		
L_draw_MenuGame25:
;proyecto-2-embebido,119 :: 		
	GOTO        L_draw_MenuGame4
;proyecto-2-embebido,120 :: 		
L_end_draw_MenuGame:
	RETURN      0
; end of _draw_MenuGame

_draw_partial_image:

;proyecto-2-embebido,123 :: 		
;proyecto-2-embebido,127 :: 		
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
;proyecto-2-embebido,128 :: 		
L_end_draw_partial_image:
	RETURN      0
; end of _draw_partial_image

_draw_text:

;proyecto-2-embebido,130 :: 		
;proyecto-2-embebido,132 :: 		
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
;proyecto-2-embebido,133 :: 		
L_end_draw_text:
	RETURN      0
; end of _draw_text

_draw_score:

;proyecto-2-embebido,135 :: 		
;proyecto-2-embebido,138 :: 		
	MOVF        FARG_draw_score_a+0, 0 
	MOVWF       FARG_ShortToStr_input+0 
	MOVLW       _score_text+0
	MOVWF       FARG_ShortToStr_output+0 
	MOVLW       hi_addr(_score_text+0)
	MOVWF       FARG_ShortToStr_output+1 
	CALL        _ShortToStr+0, 0
;proyecto-2-embebido,139 :: 		
	MOVLW       _score_text+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(_score_text+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
;proyecto-2-embebido,140 :: 		
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
;proyecto-2-embebido,141 :: 		
	MOVF        FARG_draw_score_b+0, 0 
	MOVWF       FARG_ShortToStr_input+0 
	MOVLW       _score_text+0
	MOVWF       FARG_ShortToStr_output+0 
	MOVLW       hi_addr(_score_text+0)
	MOVWF       FARG_ShortToStr_output+1 
	CALL        _ShortToStr+0, 0
;proyecto-2-embebido,142 :: 		
	MOVLW       _score_text+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(_score_text+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
;proyecto-2-embebido,143 :: 		
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
;proyecto-2-embebido,144 :: 		
L_end_draw_score:
	RETURN      0
; end of _draw_score

main_check_collision00:

;proyecto-2-embebido,17 :: 		
;proyecto-2-embebido,19 :: 		
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
;proyecto-2-embebido,20 :: 		
	MOVLW       128
	BTFSC       FARG_main_check_collision00_rect1+0, 7 
	MOVLW       127
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main_check_collision00111
	MOVF        R1, 0 
	SUBWF       FARG_main_check_collision00_rect1+0, 0 
L_main_check_collision00111:
	BTFSC       STATUS+0, 0 
	GOTO        L_main_check_collision0030
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
	GOTO        L_main_check_collision00112
	MOVF        R1, 0 
	SUBWF       FARG_main_check_collision00_rect2+0, 0 
L_main_check_collision00112:
	BTFSC       STATUS+0, 0 
	GOTO        L_main_check_collision0030
;proyecto-2-embebido,21 :: 		
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
	GOTO        L_main_check_collision00113
	MOVF        R1, 0 
	SUBWF       FARG_main_check_collision00_rect1+1, 0 
L_main_check_collision00113:
	BTFSC       STATUS+0, 0 
	GOTO        L_main_check_collision0030
;proyecto-2-embebido,22 :: 		
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
	GOTO        L_main_check_collision00114
	MOVF        R1, 0 
	SUBWF       FARG_main_check_collision00_rect2+1, 0 
L_main_check_collision00114:
	BTFSC       STATUS+0, 0 
	GOTO        L_main_check_collision0030
	MOVLW       1
	MOVWF       R0 
	GOTO        L_main_check_collision0029
L_main_check_collision0030:
	CLRF        R0 
L_main_check_collision0029:
;proyecto-2-embebido,23 :: 		
L_end_check_collision00:
	RETURN      0
; end of main_check_collision00

_check_collision:

;proyecto-2-embebido,26 :: 		
;proyecto-2-embebido,28 :: 		
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
L_check_collision31:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_check_collision31
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
L_check_collision32:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_check_collision32
	CALL        main_check_collision00+0, 0
;proyecto-2-embebido,29 :: 		
L_end_check_collision:
	RETURN      0
; end of _check_collision

_randint:

;proyecto-2-embebido,32 :: 		
;proyecto-2-embebido,34 :: 		
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
;proyecto-2-embebido,35 :: 		
L_end_randint:
	RETURN      0
; end of _randint

_move_player:

;proyecto-2-embebido,38 :: 		
	MOVF        R0, 0 
	MOVWF       _move_player_su_addr+0 
	MOVF        R1, 0 
	MOVWF       _move_player_su_addr+1 
;proyecto-2-embebido,42 :: 		
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
L_move_player33:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_move_player33
;proyecto-2-embebido,44 :: 		
	CLRF        move_player_i_L0+0 
L_move_player34:
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__move_player118
	MOVF        move_player_i_L0+0, 0 
	SUBLW       12
L__move_player118:
	BTFSS       STATUS+0, 0 
	GOTO        L_move_player35
;proyecto-2-embebido,45 :: 		
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
L_move_player37:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_move_player37
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
L_move_player38:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_move_player38
	CALL        _check_collision+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_move_player39
;proyecto-2-embebido,47 :: 		
	MOVLW       32
	MOVWF       FARG_move_player_player+0 
;proyecto-2-embebido,48 :: 		
	MOVLW       55
	MOVWF       FARG_move_player_player+1 
;proyecto-2-embebido,49 :: 		
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
L_move_player40:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_move_player40
	GOTO        L_end_move_player
;proyecto-2-embebido,50 :: 		
L_move_player39:
;proyecto-2-embebido,44 :: 		
	INCF        move_player_i_L0+0, 1 
;proyecto-2-embebido,52 :: 		
	GOTO        L_move_player34
L_move_player35:
;proyecto-2-embebido,57 :: 		
	MOVF        move_player_key_L0+1, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_move_player41
;proyecto-2-embebido,58 :: 		
	MOVF        FARG_move_player_player+5, 0 
	ADDWF       FARG_move_player_player+1, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	MOVWF       FARG_move_player_player+1 
;proyecto-2-embebido,60 :: 		
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
	GOTO        L__move_player119
	MOVLW       63
	SUBWF       R2, 0 
L__move_player119:
	BTFSS       STATUS+0, 0 
	GOTO        L_move_player42
;proyecto-2-embebido,61 :: 		
	MOVLW       55
	MOVWF       FARG_move_player_player+1 
;proyecto-2-embebido,62 :: 		
L_move_player42:
;proyecto-2-embebido,63 :: 		
	GOTO        L_move_player43
L_move_player41:
;proyecto-2-embebido,65 :: 		
	MOVF        move_player_key_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_move_player44
;proyecto-2-embebido,66 :: 		
	MOVF        FARG_move_player_player+5, 0 
	SUBWF       FARG_move_player_player+1, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       FARG_move_player_player+1 
;proyecto-2-embebido,67 :: 		
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	XORWF       R1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_move_player45
;proyecto-2-embebido,68 :: 		
	MOVLW       32
	MOVWF       FARG_move_player_player+0 
;proyecto-2-embebido,69 :: 		
	MOVLW       55
	MOVWF       FARG_move_player_player+1 
;proyecto-2-embebido,70 :: 		
	INCF        _scoreA+0, 1 
;proyecto-2-embebido,71 :: 		
	MOVF        _scoreA+0, 0 
	MOVWF       FARG_draw_score_a+0 
	MOVF        _scoreB+0, 0 
	MOVWF       FARG_draw_score_b+0 
	CALL        _draw_score+0, 0
;proyecto-2-embebido,73 :: 		
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
;proyecto-2-embebido,74 :: 		
L_move_player45:
;proyecto-2-embebido,75 :: 		
	GOTO        L_move_player47
L_move_player44:
;proyecto-2-embebido,77 :: 		
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
;proyecto-2-embebido,78 :: 		
L_move_player47:
L_move_player43:
;proyecto-2-embebido,81 :: 		
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
L_move_player49:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_move_player49
;proyecto-2-embebido,83 :: 		
L_end_move_player:
	RETURN      0
; end of _move_player

_initEnvironment:

;proyecto-2-embebido,87 :: 		
;proyecto-2-embebido,90 :: 		
	CLRF        initEnvironment_offset_x_L0+0 
;proyecto-2-embebido,91 :: 		
	MOVLW       53
	MOVWF       initEnvironment_offset_y_L0+0 
;proyecto-2-embebido,92 :: 		
	CLRF        initEnvironment_i_L0+0 
L_initEnvironment50:
	MOVF        initEnvironment_i_L0+0, 0 
	SUBLW       12
	BTFSS       STATUS+0, 0 
	GOTO        L_initEnvironment51
;proyecto-2-embebido,94 :: 		
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
;proyecto-2-embebido,95 :: 		
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
;proyecto-2-embebido,96 :: 		
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
;proyecto-2-embebido,97 :: 		
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
;proyecto-2-embebido,99 :: 		
	MOVLW       123
	MOVWF       FARG_randint_n+0 
	CALL        _randint+0, 0
	MOVF        R0, 0 
	MOVWF       initEnvironment_offset_x_L0+0 
;proyecto-2-embebido,100 :: 		
	MOVLW       4
	SUBWF       initEnvironment_offset_y_L0+0, 1 
;proyecto-2-embebido,92 :: 		
	INCF        initEnvironment_i_L0+0, 1 
;proyecto-2-embebido,101 :: 		
	GOTO        L_initEnvironment50
L_initEnvironment51:
;proyecto-2-embebido,102 :: 		
L_end_initEnvironment:
	RETURN      0
; end of _initEnvironment

_environment:

;proyecto-2-embebido,105 :: 		
;proyecto-2-embebido,108 :: 		
	CLRF        R4 
L_environment53:
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__environment122
	MOVF        R4, 0 
	SUBLW       12
L__environment122:
	BTFSS       STATUS+0, 0 
	GOTO        L_environment54
;proyecto-2-embebido,110 :: 		
	MOVLW       1
	ANDWF       R4, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_environment56
;proyecto-2-embebido,112 :: 		
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
	GOTO        L_environment57
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
	MOVWF       FSR1L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_environment_s+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       124
	MOVWF       POSTINC1+0 
;proyecto-2-embebido,115 :: 		
L_environment57:
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
;proyecto-2-embebido,117 :: 		
	GOTO        L_environment58
L_environment56:
;proyecto-2-embebido,120 :: 		
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
	GOTO        L_environment59
;proyecto-2-embebido,122 :: 		
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
;proyecto-2-embebido,123 :: 		
L_environment59:
;proyecto-2-embebido,124 :: 		
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
;proyecto-2-embebido,125 :: 		
L_environment58:
;proyecto-2-embebido,108 :: 		
	INCF        R4, 1 
;proyecto-2-embebido,126 :: 		
	GOTO        L_environment53
L_environment54:
;proyecto-2-embebido,128 :: 		
L_end_environment:
	RETURN      0
; end of _environment

_InitTimer0:

;main.c,18 :: 		void InitTimer0(){
;main.c,19 :: 		T0CON         = 0x83;
	MOVLW       131
	MOVWF       T0CON+0 
;main.c,20 :: 		TMR0H         = 0x0B;
	MOVLW       11
	MOVWF       TMR0H+0 
;main.c,21 :: 		TMR0L         = 0xDC;
	MOVLW       220
	MOVWF       TMR0L+0 
;main.c,22 :: 		GIE_bit       = 1;
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;main.c,23 :: 		TMR0IE_bit    = 1;
	BSF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;main.c,24 :: 		}
L_end_InitTimer0:
	RETURN      0
; end of _InitTimer0

_Interrupt:

;main.c,26 :: 		void Interrupt(){
;main.c,27 :: 		if (TMR0IF_bit){
	BTFSS       TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
	GOTO        L_Interrupt60
;main.c,28 :: 		TMR0IF_bit = 0;
	BCF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
;main.c,29 :: 		TMR0H         = 0x0B;
	MOVLW       11
	MOVWF       TMR0H+0 
;main.c,30 :: 		TMR0L         = 0xDC;
	MOVLW       220
	MOVWF       TMR0L+0 
;main.c,32 :: 		contador_ms++;
	INCF        _contador_ms+0, 1 
;main.c,33 :: 		if (contador_ms >= 2)
	MOVLW       2
	SUBWF       _contador_ms+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_Interrupt61
;main.c,35 :: 		timeFlag = 1;
	MOVLW       1
	MOVWF       _timeFlag+0 
;main.c,36 :: 		contador_ms = 0;
	CLRF        _contador_ms+0 
;main.c,37 :: 		}
L_Interrupt61:
;main.c,38 :: 		}
L_Interrupt60:
;main.c,39 :: 		}
L_end_Interrupt:
L__Interrupt125:
	RETFIE      1
; end of _Interrupt

_init_game:

;main.c,41 :: 		void init_game()
;main.c,44 :: 		scoreA = 0;
	CLRF        _scoreA+0 
;main.c,45 :: 		scoreB = 0;
	CLRF        _scoreB+0 
;main.c,46 :: 		timeFlag = 0;
	CLRF        _timeFlag+0 
;main.c,47 :: 		contador_ms = 0;
	CLRF        _contador_ms+0 
;main.c,48 :: 		modeGame = 0;
	CLRF        _modeGame+0 
;main.c,50 :: 		playerOne.rect.x = 32;
	MOVLW       32
	MOVWF       _playerOne+0 
;main.c,51 :: 		playerOne.rect.y = 55;
	MOVLW       55
	MOVWF       _playerOne+1 
;main.c,52 :: 		playerOne.rect.w = 9;
	MOVLW       9
	MOVWF       _playerOne+2 
;main.c,53 :: 		playerOne.rect.h = 9;
	MOVLW       9
	MOVWF       _playerOne+3 
;main.c,54 :: 		playerOne.vel.dx = 0;
	CLRF        _playerOne+4 
;main.c,55 :: 		playerOne.vel.dy = 1;
	MOVLW       1
	MOVWF       _playerOne+5 
;main.c,57 :: 		timer.x = 62;
	MOVLW       62
	MOVWF       _timer+0 
;main.c,58 :: 		timer.y = 3;
	MOVLW       3
	MOVWF       _timer+1 
;main.c,59 :: 		timer.w = 1;
	MOVLW       1
	MOVWF       _timer+2 
;main.c,60 :: 		timer.h = 60;
	MOVLW       60
	MOVWF       _timer+3 
;main.c,62 :: 		initEnvironment(m);
	MOVLW       _m+0
	MOVWF       FARG_initEnvironment_s+0 
	MOVLW       hi_addr(_m+0)
	MOVWF       FARG_initEnvironment_s+1 
	CALL        _initEnvironment+0, 0
;main.c,63 :: 		}
L_end_init_game:
	RETURN      0
; end of _init_game

_updateGameTime:

;main.c,67 :: 		void updateGameTime(Rect *t)
;main.c,70 :: 		if (t->y >= 63)
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
	GOTO        L_updateGameTime62
;main.c,73 :: 		if (scoreA > scoreB)
	MOVF        _scoreA+0, 0 
	SUBWF       _scoreB+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_updateGameTime63
;main.c,75 :: 		draw_winFrame();
	CALL        _draw_winFrame+0, 0
;main.c,76 :: 		init_game();
	CALL        _init_game+0, 0
;main.c,77 :: 		state = 1;
	MOVLW       1
	MOVWF       _state+0 
;main.c,78 :: 		}
L_updateGameTime63:
;main.c,79 :: 		}
L_updateGameTime62:
;main.c,82 :: 		if (timeFlag)
	MOVF        _timeFlag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_updateGameTime64
;main.c,84 :: 		t->y++;
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
;main.c,85 :: 		timeFlag = 0;
	CLRF        _timeFlag+0 
;main.c,86 :: 		}
L_updateGameTime64:
;main.c,88 :: 		}
L_end_updateGameTime:
	RETURN      0
; end of _updateGameTime

_main:

;main.c,93 :: 		void main() {
;main.c,95 :: 		state = 0;
	CLRF        _state+0 
;main.c,100 :: 		init_game();
	CALL        _init_game+0, 0
;main.c,103 :: 		ADCON1 = 0x0F;
	MOVLW       15
	MOVWF       ADCON1+0 
;main.c,104 :: 		Glcd_Init();
	CALL        _Glcd_Init+0, 0
;main.c,105 :: 		InitTimer0();
	CALL        _InitTimer0+0, 0
;main.c,110 :: 		while (1)
L_main65:
;main.c,112 :: 		switch (state)
	GOTO        L_main67
;main.c,114 :: 		case TITLE:
L_main69:
;main.c,115 :: 		draw_InitFrame();
	CALL        _draw_InitFrame+0, 0
;main.c,116 :: 		state = MENU;
	MOVLW       1
	MOVWF       _state+0 
;main.c,117 :: 		break;
	GOTO        L_main68
;main.c,119 :: 		case MENU:
L_main70:
;main.c,120 :: 		state = draw_MenuGame(modeGame);
	MOVF        _modeGame+0, 0 
	MOVWF       FARG_draw_MenuGame_modeGame+0 
	CALL        _draw_MenuGame+0, 0
	MOVF        R0, 0 
	MOVWF       _state+0 
;main.c,121 :: 		break;
	GOTO        L_main68
;main.c,123 :: 		case ONEPLAYER:
L_main71:
;main.c,124 :: 		draw_clear();
	CALL        _draw_clear+0, 0
;main.c,125 :: 		draw_score(scoreA, scoreB);
	MOVF        _scoreA+0, 0 
	MOVWF       FARG_draw_score_a+0 
	MOVF        _scoreB+0, 0 
	MOVWF       FARG_draw_score_b+0 
	CALL        _draw_score+0, 0
;main.c,126 :: 		while (1)
L_main72:
;main.c,129 :: 		updateGameTime(&timer);
	MOVLW       _timer+0
	MOVWF       FARG_updateGameTime_t+0 
	MOVLW       hi_addr(_timer+0)
	MOVWF       FARG_updateGameTime_t+1 
	CALL        _updateGameTime+0, 0
;main.c,131 :: 		playerOne = move_player(playerOne, m);
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
L_main74:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main74
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
L_main75:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main75
;main.c,132 :: 		environment(m);
	MOVLW       _m+0
	MOVWF       FARG_environment_s+0 
	MOVLW       hi_addr(_m+0)
	MOVWF       FARG_environment_s+1 
	CALL        _environment+0, 0
;main.c,136 :: 		draw_box(timer, DRAW);
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
L_main76:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main76
	MOVLW       1
	MOVWF       FARG_draw_box_color+0 
	CALL        _draw_box+0, 0
;main.c,137 :: 		draw_partial_image(playerOne.rect, ship);
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
L_main77:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main77
	MOVLW       _ship+0
	MOVWF       FARG_draw_partial_image_image+0 
	MOVLW       hi_addr(_ship+0)
	MOVWF       FARG_draw_partial_image_image+1 
	MOVLW       higher_addr(_ship+0)
	MOVWF       FARG_draw_partial_image_image+2 
	CALL        _draw_partial_image+0, 0
;main.c,138 :: 		for (i = 0; i <= NUM_ASTEROIDS - 1; i++){
	CLRF        _i+0 
L_main78:
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main129
	MOVF        _i+0, 0 
	SUBLW       12
L__main129:
	BTFSS       STATUS+0, 0 
	GOTO        L_main79
;main.c,139 :: 		draw_horizontal_line(m[i], DRAW);
	MOVF        _i+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _m+0
	ADDWF       R0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_m+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0L+1 
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_draw_horizontal_line_asteroid+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_horizontal_line_asteroid+0)
	MOVWF       FSR1L+1 
L_main81:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main81
	MOVLW       1
	MOVWF       FARG_draw_horizontal_line_color+0 
	CALL        _draw_horizontal_line+0, 0
;main.c,138 :: 		for (i = 0; i <= NUM_ASTEROIDS - 1; i++){
	INCF        _i+0, 1 
;main.c,140 :: 		}
	GOTO        L_main78
L_main79:
;main.c,141 :: 		Delay_ms(60);
	MOVLW       156
	MOVWF       R12, 0
	MOVLW       215
	MOVWF       R13, 0
L_main82:
	DECFSZ      R13, 1, 1
	BRA         L_main82
	DECFSZ      R12, 1, 1
	BRA         L_main82
;main.c,142 :: 		for (i = 0; i <= NUM_ASTEROIDS - 1; i++){
	CLRF        _i+0 
L_main83:
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main130
	MOVF        _i+0, 0 
	SUBLW       12
L__main130:
	BTFSS       STATUS+0, 0 
	GOTO        L_main84
;main.c,143 :: 		draw_horizontal_line(m[i], ERASE);
	MOVF        _i+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _m+0
	ADDWF       R0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_m+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0L+1 
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_draw_horizontal_line_asteroid+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_draw_horizontal_line_asteroid+0)
	MOVWF       FSR1L+1 
L_main86:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main86
	CLRF        FARG_draw_horizontal_line_color+0 
	CALL        _draw_horizontal_line+0, 0
;main.c,142 :: 		for (i = 0; i <= NUM_ASTEROIDS - 1; i++){
	INCF        _i+0, 1 
;main.c,144 :: 		}
	GOTO        L_main83
L_main84:
;main.c,145 :: 		draw_box(timer, ERASE);
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
L_main87:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main87
	CLRF        FARG_draw_box_color+0 
	CALL        _draw_box+0, 0
;main.c,146 :: 		draw_partial_image(playerOne.rect, parche);
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
L_main88:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main88
	MOVLW       _parche+0
	MOVWF       FARG_draw_partial_image_image+0 
	MOVLW       hi_addr(_parche+0)
	MOVWF       FARG_draw_partial_image_image+1 
	MOVLW       higher_addr(_parche+0)
	MOVWF       FARG_draw_partial_image_image+2 
	CALL        _draw_partial_image+0, 0
;main.c,148 :: 		if (state == 1)
	MOVF        _state+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main89
;main.c,150 :: 		draw_clear();
	CALL        _draw_clear+0, 0
;main.c,151 :: 		break;
	GOTO        L_main73
;main.c,152 :: 		}
L_main89:
;main.c,154 :: 		}
	GOTO        L_main72
L_main73:
;main.c,156 :: 		break;
	GOTO        L_main68
;main.c,159 :: 		default:
L_main90:
;main.c,160 :: 		break;
	GOTO        L_main68
;main.c,161 :: 		}
L_main67:
	MOVF        _state+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main69
	MOVF        _state+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main70
	MOVF        _state+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_main71
	GOTO        L_main90
L_main68:
;main.c,162 :: 		}
	GOTO        L_main65
;main.c,166 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

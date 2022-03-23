
main_InitTimer0:

;proyecto-2-embebido,18 :: 		
;proyecto-2-embebido,20 :: 		
	MOVLW       131
	MOVWF       T0CON+0 
;proyecto-2-embebido,21 :: 		
	MOVLW       11
	MOVWF       TMR0H+0 
;proyecto-2-embebido,22 :: 		
	MOVLW       220
	MOVWF       TMR0L+0 
;proyecto-2-embebido,23 :: 		
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;proyecto-2-embebido,24 :: 		
	BSF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;proyecto-2-embebido,25 :: 		
L_end_InitTimer0:
	RETURN      0
; end of main_InitTimer0

main_Serial_Init:

;proyecto-2-embebido,29 :: 		
;proyecto-2-embebido,39 :: 		
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       207
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;proyecto-2-embebido,40 :: 		
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
;proyecto-2-embebido,42 :: 		
	BSF         PIE1+0, 5 
;proyecto-2-embebido,43 :: 		
	BSF         INTCON+0, 6 
;proyecto-2-embebido,44 :: 		
	BSF         INTCON+0, 7 
;proyecto-2-embebido,45 :: 		
L_end_Serial_Init:
	RETURN      0
; end of main_Serial_Init

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
L_main_readKeys1:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main_readKeys1
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
L_draw_InitFrame2:
	DECFSZ      R13, 1, 1
	BRA         L_draw_InitFrame2
	DECFSZ      R12, 1, 1
	BRA         L_draw_InitFrame2
	DECFSZ      R11, 1, 1
	BRA         L_draw_InitFrame2
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
L_draw_winFrame3:
	DECFSZ      R13, 1, 1
	BRA         L_draw_winFrame3
	DECFSZ      R12, 1, 1
	BRA         L_draw_winFrame3
	DECFSZ      R11, 1, 1
	BRA         L_draw_winFrame3
;proyecto-2-embebido,52 :: 		
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;proyecto-2-embebido,53 :: 		
L_end_draw_winFrame:
	RETURN      0
; end of _draw_winFrame

_draw_loseFrame:

;proyecto-2-embebido,55 :: 		
;proyecto-2-embebido,56 :: 		
	MOVLW       _loseScreen+0
	MOVWF       FARG_Glcd_Image_image+0 
	MOVLW       hi_addr(_loseScreen+0)
	MOVWF       FARG_Glcd_Image_image+1 
	MOVLW       higher_addr(_loseScreen+0)
	MOVWF       FARG_Glcd_Image_image+2 
	CALL        _Glcd_Image+0, 0
;proyecto-2-embebido,57 :: 		
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
;proyecto-2-embebido,58 :: 		
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;proyecto-2-embebido,59 :: 		
L_end_draw_loseFrame:
	RETURN      0
; end of _draw_loseFrame

_draw_circle:

;proyecto-2-embebido,62 :: 		
;proyecto-2-embebido,65 :: 		
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
;proyecto-2-embebido,66 :: 		
L_end_draw_circle:
	RETURN      0
; end of _draw_circle

_draw_dot:

;proyecto-2-embebido,68 :: 		
;proyecto-2-embebido,70 :: 		
	MOVF        FARG_draw_dot_player+0, 0 
	MOVWF       FARG_Glcd_Dot_x_pos+0 
	MOVF        FARG_draw_dot_player+1, 0 
	MOVWF       FARG_Glcd_Dot_y_pos+0 
	MOVF        FARG_draw_dot_color+0, 0 
	MOVWF       FARG_Glcd_Dot_color+0 
	CALL        _Glcd_Dot+0, 0
;proyecto-2-embebido,71 :: 		
L_end_draw_dot:
	RETURN      0
; end of _draw_dot

_draw_horizontal_line:

;proyecto-2-embebido,73 :: 		
;proyecto-2-embebido,75 :: 		
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
;proyecto-2-embebido,76 :: 		
L_end_draw_horizontal_line:
	RETURN      0
; end of _draw_horizontal_line

_draw_box:

;proyecto-2-embebido,78 :: 		
;proyecto-2-embebido,81 :: 		
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
;proyecto-2-embebido,82 :: 		
L_end_draw_box:
	RETURN      0
; end of _draw_box

_draw_MenuGame:

;proyecto-2-embebido,86 :: 		
;proyecto-2-embebido,89 :: 		
	MOVLW       25
	MOVWF       draw_MenuGame_select_L0+0 
	MOVLW       34
	MOVWF       draw_MenuGame_select_L0+1 
	MOVLW       3
	MOVWF       draw_MenuGame_select_L0+2 
	CLRF        draw_MenuGame_select_L0+3 
;proyecto-2-embebido,90 :: 		
	CALL        _draw_MenuFrame+0, 0
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
L_draw_MenuGame5:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame5
	MOVLW       1
	MOVWF       FARG_draw_circle_color+0 
	CALL        _draw_circle+0, 0
;proyecto-2-embebido,93 :: 		
L_draw_MenuGame6:
;proyecto-2-embebido,95 :: 		
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
;proyecto-2-embebido,97 :: 		
	MOVF        draw_MenuGame_key_L0+2, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_draw_MenuGame11
	MOVF        FARG_draw_MenuGame_modeGame+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame11
L__draw_MenuGame140:
;proyecto-2-embebido,99 :: 		
	CALL        _draw_clear+0, 0
;proyecto-2-embebido,100 :: 		
	MOVLW       2
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_draw_MenuGame
;proyecto-2-embebido,101 :: 		
L_draw_MenuGame11:
;proyecto-2-embebido,102 :: 		
	MOVF        draw_MenuGame_key_L0+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__draw_MenuGame139
	MOVF        draw_MenuGame_key_L0+1, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__draw_MenuGame139
	GOTO        L_draw_MenuGame16
L__draw_MenuGame139:
	MOVF        FARG_draw_MenuGame_modeGame+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame16
L__draw_MenuGame138:
;proyecto-2-embebido,104 :: 		
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
;proyecto-2-embebido,105 :: 		
	MOVLW       14
	ADDWF       draw_MenuGame_select_L0+1, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       draw_MenuGame_select_L0+1 
;proyecto-2-embebido,106 :: 		
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
;proyecto-2-embebido,107 :: 		
	MOVLW       1
	MOVWF       FARG_draw_MenuGame_modeGame+0 
;proyecto-2-embebido,108 :: 		
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
;proyecto-2-embebido,109 :: 		
	GOTO        L_draw_MenuGame6
;proyecto-2-embebido,110 :: 		
L_draw_MenuGame16:
;proyecto-2-embebido,111 :: 		
	MOVF        draw_MenuGame_key_L0+2, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_draw_MenuGame22
	MOVF        FARG_draw_MenuGame_modeGame+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame22
L__draw_MenuGame137:
;proyecto-2-embebido,113 :: 		
	CALL        _draw_clear+0, 0
;proyecto-2-embebido,114 :: 		
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_draw_MenuGame
;proyecto-2-embebido,115 :: 		
L_draw_MenuGame22:
;proyecto-2-embebido,116 :: 		
	MOVF        draw_MenuGame_key_L0+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__draw_MenuGame136
	MOVF        draw_MenuGame_key_L0+1, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__draw_MenuGame136
	GOTO        L_draw_MenuGame27
L__draw_MenuGame136:
	MOVF        FARG_draw_MenuGame_modeGame+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_MenuGame27
L__draw_MenuGame135:
;proyecto-2-embebido,118 :: 		
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
;proyecto-2-embebido,119 :: 		
	MOVLW       14
	SUBWF       draw_MenuGame_select_L0+1, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       draw_MenuGame_select_L0+1 
;proyecto-2-embebido,120 :: 		
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
;proyecto-2-embebido,121 :: 		
	CLRF        FARG_draw_MenuGame_modeGame+0 
;proyecto-2-embebido,122 :: 		
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
;proyecto-2-embebido,123 :: 		
L_draw_MenuGame27:
;proyecto-2-embebido,124 :: 		
	GOTO        L_draw_MenuGame6
;proyecto-2-embebido,125 :: 		
L_end_draw_MenuGame:
	RETURN      0
; end of _draw_MenuGame

_draw_partial_image:

;proyecto-2-embebido,128 :: 		
;proyecto-2-embebido,132 :: 		
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
;proyecto-2-embebido,133 :: 		
L_end_draw_partial_image:
	RETURN      0
; end of _draw_partial_image

_draw_text:

;proyecto-2-embebido,135 :: 		
;proyecto-2-embebido,137 :: 		
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
;proyecto-2-embebido,138 :: 		
L_end_draw_text:
	RETURN      0
; end of _draw_text

_draw_score:

;proyecto-2-embebido,140 :: 		
;proyecto-2-embebido,143 :: 		
	MOVF        FARG_draw_score_a+0, 0 
	MOVWF       FARG_ShortToStr_input+0 
	MOVLW       _score_text+0
	MOVWF       FARG_ShortToStr_output+0 
	MOVLW       hi_addr(_score_text+0)
	MOVWF       FARG_ShortToStr_output+1 
	CALL        _ShortToStr+0, 0
;proyecto-2-embebido,144 :: 		
	MOVLW       _score_text+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(_score_text+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
;proyecto-2-embebido,145 :: 		
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
;proyecto-2-embebido,146 :: 		
	MOVF        FARG_draw_score_b+0, 0 
	MOVWF       FARG_ShortToStr_input+0 
	MOVLW       _score_text+0
	MOVWF       FARG_ShortToStr_output+0 
	MOVLW       hi_addr(_score_text+0)
	MOVWF       FARG_ShortToStr_output+1 
	CALL        _ShortToStr+0, 0
;proyecto-2-embebido,147 :: 		
	MOVLW       _score_text+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(_score_text+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
;proyecto-2-embebido,148 :: 		
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
;proyecto-2-embebido,149 :: 		
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
	GOTO        L_main_check_collision00158
	MOVF        R1, 0 
	SUBWF       FARG_main_check_collision00_rect1+0, 0 
L_main_check_collision00158:
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
	GOTO        L_main_check_collision00159
	MOVF        R1, 0 
	SUBWF       FARG_main_check_collision00_rect2+0, 0 
L_main_check_collision00159:
	BTFSC       STATUS+0, 0 
	GOTO        L_main_check_collision0032
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
	GOTO        L_main_check_collision00160
	MOVF        R1, 0 
	SUBWF       FARG_main_check_collision00_rect1+1, 0 
L_main_check_collision00160:
	BTFSC       STATUS+0, 0 
	GOTO        L_main_check_collision0032
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
	GOTO        L_main_check_collision00161
	MOVF        R1, 0 
	SUBWF       FARG_main_check_collision00_rect2+1, 0 
L_main_check_collision00161:
	BTFSC       STATUS+0, 0 
	GOTO        L_main_check_collision0032
	MOVLW       1
	MOVWF       R0 
	GOTO        L_main_check_collision0031
L_main_check_collision0032:
	CLRF        R0 
L_main_check_collision0031:
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
L_move_player35:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_move_player35
;proyecto-2-embebido,44 :: 		
	CLRF        move_player_i_L0+0 
L_move_player36:
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__move_player165
	MOVF        move_player_i_L0+0, 0 
	SUBLW       12
L__move_player165:
	BTFSS       STATUS+0, 0 
	GOTO        L_move_player37
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
L_move_player42:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_move_player42
	GOTO        L_end_move_player
;proyecto-2-embebido,50 :: 		
L_move_player41:
;proyecto-2-embebido,44 :: 		
	INCF        move_player_i_L0+0, 1 
;proyecto-2-embebido,52 :: 		
	GOTO        L_move_player36
L_move_player37:
;proyecto-2-embebido,57 :: 		
	MOVF        move_player_key_L0+1, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_move_player43
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
	GOTO        L__move_player166
	MOVLW       63
	SUBWF       R2, 0 
L__move_player166:
	BTFSS       STATUS+0, 0 
	GOTO        L_move_player44
;proyecto-2-embebido,61 :: 		
	MOVLW       55
	MOVWF       FARG_move_player_player+1 
;proyecto-2-embebido,62 :: 		
L_move_player44:
;proyecto-2-embebido,63 :: 		
	GOTO        L_move_player45
L_move_player43:
;proyecto-2-embebido,65 :: 		
	MOVF        move_player_key_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_move_player46
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
	GOTO        L_move_player47
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
L_move_player48:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_move_player48
	GOTO        L_end_move_player
;proyecto-2-embebido,74 :: 		
L_move_player47:
;proyecto-2-embebido,75 :: 		
	GOTO        L_move_player49
L_move_player46:
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
L_move_player50:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_move_player50
	GOTO        L_end_move_player
;proyecto-2-embebido,78 :: 		
L_move_player49:
L_move_player45:
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
L_move_player51:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_move_player51
;proyecto-2-embebido,83 :: 		
L_end_move_player:
	RETURN      0
; end of _move_player

_move_ai:

;proyecto-2-embebido,85 :: 		
	MOVF        R0, 0 
	MOVWF       _move_ai_su_addr+0 
	MOVF        R1, 0 
	MOVWF       _move_ai_su_addr+1 
;proyecto-2-embebido,88 :: 		
	MOVLW       200
	MOVWF       FARG_randint_n+0 
	CALL        _randint+0, 0
	MOVF        R0, 0 
	MOVWF       move_ai_luck_L0+0 
;proyecto-2-embebido,89 :: 		
	CLRF        move_ai_i_L0+0 
L_move_ai52:
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__move_ai168
	MOVF        move_ai_i_L0+0, 0 
	SUBLW       12
L__move_ai168:
	BTFSS       STATUS+0, 0 
	GOTO        L_move_ai53
;proyecto-2-embebido,92 :: 		
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
;proyecto-2-embebido,94 :: 		
	MOVLW       94
	MOVWF       FARG_move_ai_pc+0 
;proyecto-2-embebido,95 :: 		
	MOVLW       55
	MOVWF       FARG_move_ai_pc+1 
;proyecto-2-embebido,96 :: 		
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
;proyecto-2-embebido,97 :: 		
L_move_ai57:
;proyecto-2-embebido,89 :: 		
	INCF        move_ai_i_L0+0, 1 
;proyecto-2-embebido,98 :: 		
	GOTO        L_move_ai52
L_move_ai53:
;proyecto-2-embebido,112 :: 		
	MOVF        move_ai_luck_L0+0, 0 
	SUBLW       185
	BTFSC       STATUS+0, 0 
	GOTO        L_move_ai59
;proyecto-2-embebido,114 :: 		
	MOVF        FARG_move_ai_pc+5, 0 
	ADDWF       FARG_move_ai_pc+1, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       FARG_move_ai_pc+1 
;proyecto-2-embebido,115 :: 		
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
;proyecto-2-embebido,116 :: 		
L_move_ai59:
;proyecto-2-embebido,118 :: 		
	MOVLW       15
	SUBWF       move_ai_luck_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_move_ai62
;proyecto-2-embebido,120 :: 		
	MOVF        FARG_move_ai_pc+5, 0 
	SUBWF       FARG_move_ai_pc+1, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       FARG_move_ai_pc+1 
;proyecto-2-embebido,121 :: 		
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
;proyecto-2-embebido,122 :: 		
L_move_ai62:
;proyecto-2-embebido,127 :: 		
	MOVF        FARG_move_ai_pc+5, 0 
	SUBWF       FARG_move_ai_pc+1, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       FARG_move_ai_pc+1 
;proyecto-2-embebido,129 :: 		
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	XORWF       R1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_move_ai64
;proyecto-2-embebido,131 :: 		
	MOVLW       94
	MOVWF       FARG_move_ai_pc+0 
;proyecto-2-embebido,132 :: 		
	MOVLW       55
	MOVWF       FARG_move_ai_pc+1 
;proyecto-2-embebido,133 :: 		
	INCF        _scoreB+0, 1 
;proyecto-2-embebido,134 :: 		
	MOVF        _scoreA+0, 0 
	MOVWF       FARG_draw_score_a+0 
	MOVF        _scoreB+0, 0 
	MOVWF       FARG_draw_score_b+0 
	CALL        _draw_score+0, 0
;proyecto-2-embebido,135 :: 		
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
;proyecto-2-embebido,136 :: 		
L_move_ai64:
;proyecto-2-embebido,138 :: 		
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
	GOTO        L__move_ai169
	MOVLW       63
	SUBWF       R2, 0 
L__move_ai169:
	BTFSS       STATUS+0, 0 
	GOTO        L_move_ai67
;proyecto-2-embebido,139 :: 		
	MOVLW       55
	MOVWF       FARG_move_ai_pc+1 
;proyecto-2-embebido,140 :: 		
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
;proyecto-2-embebido,141 :: 		
L_move_ai67:
;proyecto-2-embebido,145 :: 		
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
;proyecto-2-embebido,147 :: 		
L_end_move_ai:
	RETURN      0
; end of _move_ai

_initEnvironment:

;proyecto-2-embebido,151 :: 		
;proyecto-2-embebido,154 :: 		
	CLRF        initEnvironment_offset_x_L0+0 
;proyecto-2-embebido,155 :: 		
	MOVLW       53
	MOVWF       initEnvironment_offset_y_L0+0 
;proyecto-2-embebido,156 :: 		
	CLRF        initEnvironment_i_L0+0 
L_initEnvironment71:
	MOVF        initEnvironment_i_L0+0, 0 
	SUBLW       12
	BTFSS       STATUS+0, 0 
	GOTO        L_initEnvironment72
;proyecto-2-embebido,158 :: 		
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
;proyecto-2-embebido,159 :: 		
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
;proyecto-2-embebido,160 :: 		
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
;proyecto-2-embebido,161 :: 		
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
;proyecto-2-embebido,163 :: 		
	MOVLW       123
	MOVWF       FARG_randint_n+0 
	CALL        _randint+0, 0
	MOVF        R0, 0 
	MOVWF       initEnvironment_offset_x_L0+0 
;proyecto-2-embebido,164 :: 		
	MOVLW       4
	SUBWF       initEnvironment_offset_y_L0+0, 1 
;proyecto-2-embebido,156 :: 		
	INCF        initEnvironment_i_L0+0, 1 
;proyecto-2-embebido,165 :: 		
	GOTO        L_initEnvironment71
L_initEnvironment72:
;proyecto-2-embebido,166 :: 		
L_end_initEnvironment:
	RETURN      0
; end of _initEnvironment

_environment:

;proyecto-2-embebido,169 :: 		
;proyecto-2-embebido,172 :: 		
	CLRF        R4 
L_environment74:
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__environment172
	MOVF        R4, 0 
	SUBLW       12
L__environment172:
	BTFSS       STATUS+0, 0 
	GOTO        L_environment75
;proyecto-2-embebido,174 :: 		
	MOVLW       1
	ANDWF       R4, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_environment77
;proyecto-2-embebido,176 :: 		
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
	GOTO        L_environment78
;proyecto-2-embebido,178 :: 		
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
;proyecto-2-embebido,179 :: 		
L_environment78:
;proyecto-2-embebido,180 :: 		
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
;proyecto-2-embebido,181 :: 		
	GOTO        L_environment79
L_environment77:
;proyecto-2-embebido,184 :: 		
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
	GOTO        L_environment80
;proyecto-2-embebido,186 :: 		
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
;proyecto-2-embebido,187 :: 		
L_environment80:
;proyecto-2-embebido,188 :: 		
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
;proyecto-2-embebido,189 :: 		
L_environment79:
;proyecto-2-embebido,172 :: 		
	INCF        R4, 1 
;proyecto-2-embebido,190 :: 		
	GOTO        L_environment74
L_environment75:
;proyecto-2-embebido,192 :: 		
L_end_environment:
	RETURN      0
; end of _environment

_init_game:

;main.c,25 :: 		void init_game()
;main.c,28 :: 		scoreA = 0;
	CLRF        _scoreA+0 
;main.c,29 :: 		scoreB = 0;
	CLRF        _scoreB+0 
;main.c,30 :: 		timeFlag = 0;
	CLRF        _timeFlag+0 
;main.c,31 :: 		contador_ms = 0;
	CLRF        _contador_ms+0 
;main.c,32 :: 		modeGame = 0;
	CLRF        _modeGame+0 
;main.c,34 :: 		playerOne.rect.x = 32;
	MOVLW       32
	MOVWF       _playerOne+0 
;main.c,35 :: 		playerOne.rect.y = 55;
	MOVLW       55
	MOVWF       _playerOne+1 
;main.c,36 :: 		playerOne.rect.w = 9;
	MOVLW       9
	MOVWF       _playerOne+2 
;main.c,37 :: 		playerOne.rect.h = 9;
	MOVLW       9
	MOVWF       _playerOne+3 
;main.c,38 :: 		playerOne.vel.dx = 0;
	CLRF        _playerOne+4 
;main.c,39 :: 		playerOne.vel.dy = 1;
	MOVLW       1
	MOVWF       _playerOne+5 
;main.c,41 :: 		playerPC.rect.x = 94;
	MOVLW       94
	MOVWF       _playerPC+0 
;main.c,42 :: 		playerPC.rect.y = 55;
	MOVLW       55
	MOVWF       _playerPC+1 
;main.c,43 :: 		playerPC.rect.w = 9;
	MOVLW       9
	MOVWF       _playerPC+2 
;main.c,44 :: 		playerPC.rect.h = 9;
	MOVLW       9
	MOVWF       _playerPC+3 
;main.c,45 :: 		playerPC.vel.dx = 0;
	CLRF        _playerPC+4 
;main.c,46 :: 		playerPC.vel.dy = 1;
	MOVLW       1
	MOVWF       _playerPC+5 
;main.c,48 :: 		playerTwo = playerPC;
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
L_init_game81:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_init_game81
;main.c,50 :: 		timer.x = 62;
	MOVLW       62
	MOVWF       _timer+0 
;main.c,51 :: 		timer.y = 3;
	MOVLW       3
	MOVWF       _timer+1 
;main.c,52 :: 		timer.w = 1;
	MOVLW       1
	MOVWF       _timer+2 
;main.c,53 :: 		timer.h = 60;
	MOVLW       60
	MOVWF       _timer+3 
;main.c,55 :: 		initEnvironment(m);
	MOVLW       _m+0
	MOVWF       FARG_initEnvironment_s+0 
	MOVLW       hi_addr(_m+0)
	MOVWF       FARG_initEnvironment_s+1 
	CALL        _initEnvironment+0, 0
;main.c,56 :: 		}
L_end_init_game:
	RETURN      0
; end of _init_game

_updateGameTime:

;main.c,60 :: 		void updateGameTime(Rect *t)
;main.c,63 :: 		if (t->y >= 63)
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
	GOTO        L_updateGameTime82
;main.c,65 :: 		if (scoreA > scoreB)
	MOVF        _scoreA+0, 0 
	SUBWF       _scoreB+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_updateGameTime83
;main.c,67 :: 		draw_winFrame();
	CALL        _draw_winFrame+0, 0
;main.c,68 :: 		init_game();
	CALL        _init_game+0, 0
;main.c,69 :: 		state = MENU;
	MOVLW       1
	MOVWF       _state+0 
;main.c,70 :: 		}
	GOTO        L_updateGameTime84
L_updateGameTime83:
;main.c,72 :: 		else if (scoreB > scoreA)
	MOVF        _scoreB+0, 0 
	SUBWF       _scoreA+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_updateGameTime85
;main.c,74 :: 		draw_loseFrame();
	CALL        _draw_loseFrame+0, 0
;main.c,75 :: 		init_game();
	CALL        _init_game+0, 0
;main.c,76 :: 		state = MENU;
	MOVLW       1
	MOVWF       _state+0 
;main.c,77 :: 		}
L_updateGameTime85:
L_updateGameTime84:
;main.c,81 :: 		}
L_updateGameTime82:
;main.c,84 :: 		if (timeFlag)
	MOVF        _timeFlag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_updateGameTime86
;main.c,86 :: 		t->y++;
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
;main.c,87 :: 		timeFlag = 0;
	CLRF        _timeFlag+0 
;main.c,88 :: 		}
L_updateGameTime86:
;main.c,90 :: 		}
L_end_updateGameTime:
	RETURN      0
; end of _updateGameTime

_main:

;main.c,95 :: 		void main() {
;main.c,97 :: 		state = 0;
	CLRF        _state+0 
;main.c,99 :: 		init_game();
	CALL        _init_game+0, 0
;main.c,100 :: 		ADCON1 = 0x0F;
	MOVLW       15
	MOVWF       ADCON1+0 
;main.c,101 :: 		Glcd_Init();
	CALL        _Glcd_Init+0, 0
;main.c,102 :: 		Serial_Init();
	CALL        main_Serial_Init+0, 0
;main.c,103 :: 		InitTimer0();
	CALL        main_InitTimer0+0, 0
;main.c,105 :: 		while (1)
L_main87:
;main.c,107 :: 		switch (state)
	GOTO        L_main89
;main.c,109 :: 		case TITLE:
L_main91:
;main.c,110 :: 		draw_InitFrame();
	CALL        _draw_InitFrame+0, 0
;main.c,111 :: 		state = MENU;
	MOVLW       1
	MOVWF       _state+0 
;main.c,112 :: 		break;
	GOTO        L_main90
;main.c,114 :: 		case MENU:
L_main92:
;main.c,115 :: 		state = draw_MenuGame(modeGame);
	MOVF        _modeGame+0, 0 
	MOVWF       FARG_draw_MenuGame_modeGame+0 
	CALL        _draw_MenuGame+0, 0
	MOVF        R0, 0 
	MOVWF       _state+0 
;main.c,116 :: 		break;
	GOTO        L_main90
;main.c,118 :: 		case ONEPLAYER:
L_main93:
;main.c,119 :: 		init_game();
	CALL        _init_game+0, 0
;main.c,120 :: 		draw_clear();
	CALL        _draw_clear+0, 0
;main.c,121 :: 		draw_score(scoreA, scoreB);
	MOVF        _scoreA+0, 0 
	MOVWF       FARG_draw_score_a+0 
	MOVF        _scoreB+0, 0 
	MOVWF       FARG_draw_score_b+0 
	CALL        _draw_score+0, 0
;main.c,122 :: 		TMR0IE_bit    = 1; //lo vuelvo a habilitar ya que si salto de dos jugadores a uno, esta apagado
	BSF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;main.c,123 :: 		while (1)
L_main94:
;main.c,126 :: 		updateGameTime(&timer);
	MOVLW       _timer+0
	MOVWF       FARG_updateGameTime_t+0 
	MOVLW       hi_addr(_timer+0)
	MOVWF       FARG_updateGameTime_t+1 
	CALL        _updateGameTime+0, 0
;main.c,127 :: 		if (state == MENU)
	MOVF        _state+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main96
;main.c,129 :: 		draw_clear();
	CALL        _draw_clear+0, 0
;main.c,130 :: 		break;
	GOTO        L_main95
;main.c,131 :: 		}
L_main96:
;main.c,133 :: 		playerOne = move_player(playerOne, m);
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
L_main97:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main97
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
L_main98:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main98
;main.c,134 :: 		environment(m);
	MOVLW       _m+0
	MOVWF       FARG_environment_s+0 
	MOVLW       hi_addr(_m+0)
	MOVWF       FARG_environment_s+1 
	CALL        _environment+0, 0
;main.c,135 :: 		playerPC = move_ai(playerPC, m);
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
L_main99:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main99
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
L_main100:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main100
;main.c,140 :: 		draw_box(timer, DRAW);
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
L_main101:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main101
	MOVLW       1
	MOVWF       FARG_draw_box_color+0 
	CALL        _draw_box+0, 0
;main.c,141 :: 		draw_partial_image(playerPC.rect, ship);
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
L_main102:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main102
	MOVLW       _ship+0
	MOVWF       FARG_draw_partial_image_image+0 
	MOVLW       hi_addr(_ship+0)
	MOVWF       FARG_draw_partial_image_image+1 
	MOVLW       higher_addr(_ship+0)
	MOVWF       FARG_draw_partial_image_image+2 
	CALL        _draw_partial_image+0, 0
;main.c,142 :: 		draw_partial_image(playerOne.rect, ship);
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
L_main103:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main103
	MOVLW       _ship+0
	MOVWF       FARG_draw_partial_image_image+0 
	MOVLW       hi_addr(_ship+0)
	MOVWF       FARG_draw_partial_image_image+1 
	MOVLW       higher_addr(_ship+0)
	MOVWF       FARG_draw_partial_image_image+2 
	CALL        _draw_partial_image+0, 0
;main.c,143 :: 		for (i = 0; i <= NUM_ASTEROIDS - 1; i++){
	CLRF        _i+0 
L_main104:
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main176
	MOVF        _i+0, 0 
	SUBLW       12
L__main176:
	BTFSS       STATUS+0, 0 
	GOTO        L_main105
;main.c,144 :: 		draw_horizontal_line(m[i], DRAW);
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
L_main107:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main107
	MOVLW       1
	MOVWF       FARG_draw_horizontal_line_color+0 
	CALL        _draw_horizontal_line+0, 0
;main.c,143 :: 		for (i = 0; i <= NUM_ASTEROIDS - 1; i++){
	INCF        _i+0, 1 
;main.c,145 :: 		}
	GOTO        L_main104
L_main105:
;main.c,146 :: 		Delay_ms(60);
	MOVLW       156
	MOVWF       R12, 0
	MOVLW       215
	MOVWF       R13, 0
L_main108:
	DECFSZ      R13, 1, 1
	BRA         L_main108
	DECFSZ      R12, 1, 1
	BRA         L_main108
;main.c,147 :: 		for (i = 0; i <= NUM_ASTEROIDS - 1; i++){
	CLRF        _i+0 
L_main109:
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main177
	MOVF        _i+0, 0 
	SUBLW       12
L__main177:
	BTFSS       STATUS+0, 0 
	GOTO        L_main110
;main.c,148 :: 		draw_horizontal_line(m[i], ERASE);
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
L_main112:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main112
	CLRF        FARG_draw_horizontal_line_color+0 
	CALL        _draw_horizontal_line+0, 0
;main.c,147 :: 		for (i = 0; i <= NUM_ASTEROIDS - 1; i++){
	INCF        _i+0, 1 
;main.c,149 :: 		}
	GOTO        L_main109
L_main110:
;main.c,150 :: 		draw_box(timer, ERASE);
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
L_main113:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main113
	CLRF        FARG_draw_box_color+0 
	CALL        _draw_box+0, 0
;main.c,151 :: 		draw_partial_image(playerOne.rect, parche);
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
L_main114:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main114
	MOVLW       _parche+0
	MOVWF       FARG_draw_partial_image_image+0 
	MOVLW       hi_addr(_parche+0)
	MOVWF       FARG_draw_partial_image_image+1 
	MOVLW       higher_addr(_parche+0)
	MOVWF       FARG_draw_partial_image_image+2 
	CALL        _draw_partial_image+0, 0
;main.c,152 :: 		draw_partial_image(playerPC.rect, parche);
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
L_main115:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main115
	MOVLW       _parche+0
	MOVWF       FARG_draw_partial_image_image+0 
	MOVLW       hi_addr(_parche+0)
	MOVWF       FARG_draw_partial_image_image+1 
	MOVLW       higher_addr(_parche+0)
	MOVWF       FARG_draw_partial_image_image+2 
	CALL        _draw_partial_image+0, 0
;main.c,157 :: 		}
	GOTO        L_main94
L_main95:
;main.c,159 :: 		break;
	GOTO        L_main90
;main.c,161 :: 		case MULTIPLAYER:
L_main116:
;main.c,162 :: 		init_game();
	CALL        _init_game+0, 0
;main.c,163 :: 		draw_clear();
	CALL        _draw_clear+0, 0
;main.c,164 :: 		TMR0IE_bit    = 0;     //deshabilito la interrupcion por timer0, ya que me hace freezeado el micro
	BCF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;main.c,165 :: 		while (1)
L_main117:
;main.c,172 :: 		if (state == MENU)
	MOVF        _state+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main119
;main.c,174 :: 		draw_clear();
	CALL        _draw_clear+0, 0
;main.c,175 :: 		break;
	GOTO        L_main118
;main.c,176 :: 		}
L_main119:
;main.c,180 :: 		key = readKeys();
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
L_main120:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main120
;main.c,181 :: 		if (key.up)
	MOVF        _key+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main121
;main.c,183 :: 		playerOne.rect.y--;
	DECF        _playerOne+1, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _playerOne+1 
;main.c,184 :: 		}
	GOTO        L_main122
L_main121:
;main.c,185 :: 		else if (key.down)
	MOVF        _key+1, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main123
;main.c,187 :: 		playerOne.rect.y++;
	MOVF        _playerOne+1, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _playerOne+1 
;main.c,188 :: 		}
L_main123:
L_main122:
;main.c,191 :: 		Serial_Write(&SendPlayer , 2);
	MOVLW       _SendPlayer+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_SendPlayer+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       2
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;main.c,192 :: 		Serial_Write(&playerOne, sizeof(Splite));
	MOVLW       _playerOne+0
	MOVWF       FARG_Serial_Write_buf+0 
	MOVLW       hi_addr(_playerOne+0)
	MOVWF       FARG_Serial_Write_buf+1 
	MOVLW       6
	MOVWF       FARG_Serial_Write_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Write_n+1 
	CALL        _Serial_Write+0, 0
;main.c,195 :: 		while(1)
L_main124:
;main.c,197 :: 		num = Serial_available();
	CALL        _Serial_available+0, 0
	MOVF        R0, 0 
	MOVWF       _num+0 
;main.c,199 :: 		if (num >= (2 + sizeof(Splite)))
	MOVLW       128
	MOVWF       R2 
	MOVLW       128
	XORLW       0
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main178
	MOVLW       8
	SUBWF       R0, 0 
L__main178:
	BTFSS       STATUS+0, 0 
	GOTO        L_main126
;main.c,201 :: 		Serial_Read(&mark, 2);
	MOVLW       _mark+0
	MOVWF       FARG_Serial_Read_buf+0 
	MOVLW       hi_addr(_mark+0)
	MOVWF       FARG_Serial_Read_buf+1 
	MOVLW       2
	MOVWF       FARG_Serial_Read_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Read_n+1 
	CALL        _Serial_Read+0, 0
;main.c,204 :: 		if (mark == SendPlayer)
	MOVF        _mark+1, 0 
	XORWF       _SendPlayer+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main179
	MOVF        _SendPlayer+0, 0 
	XORWF       _mark+0, 0 
L__main179:
	BTFSS       STATUS+0, 2 
	GOTO        L_main127
;main.c,206 :: 		Serial_Read(&playerTwo, sizeof(Splite));
	MOVLW       _playerTwo+0
	MOVWF       FARG_Serial_Read_buf+0 
	MOVLW       hi_addr(_playerTwo+0)
	MOVWF       FARG_Serial_Read_buf+1 
	MOVLW       6
	MOVWF       FARG_Serial_Read_n+0 
	MOVLW       0
	MOVWF       FARG_Serial_Read_n+1 
	CALL        _Serial_Read+0, 0
;main.c,207 :: 		continue;
	GOTO        L_main124
;main.c,208 :: 		}
L_main127:
;main.c,209 :: 		Serial_clear();
	CALL        _Serial_clear+0, 0
;main.c,210 :: 		}
L_main126:
;main.c,212 :: 		}
L_main125:
;main.c,214 :: 		if (playerOne.rect.y == 0)
	MOVF        _playerOne+1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main128
;main.c,216 :: 		init_game();
	CALL        _init_game+0, 0
;main.c,217 :: 		state = MENU;
	MOVLW       1
	MOVWF       _state+0 
;main.c,218 :: 		}
L_main128:
;main.c,220 :: 		draw_partial_image(playerTwo.rect, ship);
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
;main.c,221 :: 		draw_partial_image(playerOne.rect, ship);
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
;main.c,222 :: 		Delay_ms(45);
	MOVLW       117
	MOVWF       R12, 0
	MOVLW       225
	MOVWF       R13, 0
L_main131:
	DECFSZ      R13, 1, 1
	BRA         L_main131
	DECFSZ      R12, 1, 1
	BRA         L_main131
;main.c,223 :: 		draw_partial_image(playerOne.rect, parche);
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
L_main132:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main132
	MOVLW       _parche+0
	MOVWF       FARG_draw_partial_image_image+0 
	MOVLW       hi_addr(_parche+0)
	MOVWF       FARG_draw_partial_image_image+1 
	MOVLW       higher_addr(_parche+0)
	MOVWF       FARG_draw_partial_image_image+2 
	CALL        _draw_partial_image+0, 0
;main.c,224 :: 		draw_partial_image(playerTwo.rect, parche);
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
;main.c,226 :: 		}
	GOTO        L_main117
L_main118:
;main.c,228 :: 		break;
	GOTO        L_main90
;main.c,230 :: 		default:
L_main134:
;main.c,231 :: 		break;
	GOTO        L_main90
;main.c,232 :: 		}
L_main89:
	MOVF        _state+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main91
	MOVF        _state+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main92
	MOVF        _state+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_main93
	MOVF        _state+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_main116
	GOTO        L_main134
L_main90:
;main.c,233 :: 		}
	GOTO        L_main87
;main.c,237 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

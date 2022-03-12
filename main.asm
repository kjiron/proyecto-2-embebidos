
_draw_InitFrame:

;proyecto-2-embebido,6 :: 		
;proyecto-2-embebido,7 :: 		
	MOVLW       _pantallaDeInicio+0
	MOVWF       FARG_Glcd_Image_image+0 
	MOVLW       hi_addr(_pantallaDeInicio+0)
	MOVWF       FARG_Glcd_Image_image+1 
	MOVLW       higher_addr(_pantallaDeInicio+0)
	MOVWF       FARG_Glcd_Image_image+2 
	CALL        _Glcd_Image+0, 0
;proyecto-2-embebido,8 :: 		
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_draw_InitFrame0:
	DECFSZ      R13, 1, 1
	BRA         L_draw_InitFrame0
	DECFSZ      R12, 1, 1
	BRA         L_draw_InitFrame0
	DECFSZ      R11, 1, 1
	BRA         L_draw_InitFrame0
;proyecto-2-embebido,9 :: 		
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;proyecto-2-embebido,11 :: 		
L_end_draw_InitFrame:
	RETURN      0
; end of _draw_InitFrame

_main:

;main.c,7 :: 		void main() {
;main.c,8 :: 		Glcd_Init();
	CALL        _Glcd_Init+0, 0
;main.c,10 :: 		while (1)
L_main1:
;main.c,12 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;main.c,13 :: 		draw_InitFrame();
	CALL        _draw_InitFrame+0, 0
;main.c,14 :: 		}
	GOTO        L_main1
;main.c,18 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

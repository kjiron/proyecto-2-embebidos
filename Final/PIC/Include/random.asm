
random_pcg32_random_r:

;random.c,6 :: 		static uint32_t pcg32_random_r(pcg32_random_t *rng)
;random.c,10 :: 		oldstate = rng->state;
	MOVFF       FARG_random_pcg32_random_r_rng+0, FSR0L+0
	MOVFF       FARG_random_pcg32_random_r_rng+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	MOVWF       random_pcg32_random_r_oldstate_L0+0 
	MOVF        R1, 0 
	MOVWF       random_pcg32_random_r_oldstate_L0+1 
	MOVF        R2, 0 
	MOVWF       random_pcg32_random_r_oldstate_L0+2 
	MOVF        R3, 0 
	MOVWF       random_pcg32_random_r_oldstate_L0+3 
;random.c,12 :: 		rng->state = oldstate * 636413623u + (rng->inc|1);
	MOVLW       183
	MOVWF       R4 
	MOVLW       230
	MOVWF       R5 
	MOVLW       238
	MOVWF       R6 
	MOVLW       37
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       4
	ADDWF       FARG_random_pcg32_random_r_rng+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_random_pcg32_random_r_rng+1, 0 
	MOVWF       FSR0L+1 
	MOVLW       1
	IORWF       POSTINC0+0, 0 
	MOVWF       R4 
	MOVF        POSTINC0+0, 0 
	MOVWF       R5 
	MOVF        POSTINC0+0, 0 
	MOVWF       R6 
	MOVF        POSTINC0+0, 0 
	MOVWF       R7 
	MOVLW       0
	IORWF       R5, 1 
	IORWF       R6, 1 
	IORWF       R7, 1 
	MOVFF       FARG_random_pcg32_random_r_rng+0, FSR1L+0
	MOVFF       FARG_random_pcg32_random_r_rng+1, FSR1H+0
	MOVF        R4, 0 
	ADDWF       R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R5, 0 
	ADDWFC      R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        R6, 0 
	ADDWFC      R2, 0 
	MOVWF       POSTINC1+0 
	MOVF        R7, 0 
	ADDWFC      R3, 0 
	MOVWF       POSTINC1+0 
;random.c,14 :: 		xorshifted = ((oldstate >> 7u) ^ oldstate) >> 18u;
	MOVLW       7
	MOVWF       R4 
	MOVF        random_pcg32_random_r_oldstate_L0+0, 0 
	MOVWF       R0 
	MOVF        random_pcg32_random_r_oldstate_L0+1, 0 
	MOVWF       R1 
	MOVF        random_pcg32_random_r_oldstate_L0+2, 0 
	MOVWF       R2 
	MOVF        random_pcg32_random_r_oldstate_L0+3, 0 
	MOVWF       R3 
	MOVF        R4, 0 
L_random_pcg32_random_r1:
	BZ          L_random_pcg32_random_r2
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	ADDLW       255
	GOTO        L_random_pcg32_random_r1
L_random_pcg32_random_r2:
	MOVF        random_pcg32_random_r_oldstate_L0+0, 0 
	XORWF       R0, 0 
	MOVWF       R4 
	MOVF        random_pcg32_random_r_oldstate_L0+1, 0 
	XORWF       R1, 0 
	MOVWF       R5 
	MOVF        random_pcg32_random_r_oldstate_L0+2, 0 
	XORWF       R2, 0 
	MOVWF       R6 
	MOVF        random_pcg32_random_r_oldstate_L0+3, 0 
	XORWF       R3, 0 
	MOVWF       R7 
	MOVLW       18
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R12 
	MOVF        R5, 0 
	MOVWF       R13 
	MOVF        R6, 0 
	MOVWF       R14 
	MOVF        R7, 0 
	MOVWF       R15 
	MOVF        R0, 0 
L_random_pcg32_random_r3:
	BZ          L_random_pcg32_random_r4
	RRCF        R15, 1 
	RRCF        R14, 1 
	RRCF        R13, 1 
	RRCF        R12, 1 
	BCF         R15, 7 
	ADDLW       255
	GOTO        L_random_pcg32_random_r3
L_random_pcg32_random_r4:
;random.c,15 :: 		rot = oldstate >> 27u;
	MOVLW       27
	MOVWF       R0 
	MOVF        random_pcg32_random_r_oldstate_L0+0, 0 
	MOVWF       R4 
	MOVF        random_pcg32_random_r_oldstate_L0+1, 0 
	MOVWF       R5 
	MOVF        random_pcg32_random_r_oldstate_L0+2, 0 
	MOVWF       R6 
	MOVF        random_pcg32_random_r_oldstate_L0+3, 0 
	MOVWF       R7 
	MOVF        R0, 0 
L_random_pcg32_random_r5:
	BZ          L_random_pcg32_random_r6
	RRCF        R7, 1 
	RRCF        R6, 1 
	RRCF        R5, 1 
	RRCF        R4, 1 
	BCF         R7, 7 
	ADDLW       255
	GOTO        L_random_pcg32_random_r5
L_random_pcg32_random_r6:
;random.c,16 :: 		return (xorshifted >> rot) | (xorshifted << ((-rot) & 15u));
	MOVF        R4, 0 
	MOVWF       R0 
	MOVF        R12, 0 
	MOVWF       R8 
	MOVF        R13, 0 
	MOVWF       R9 
	MOVF        R14, 0 
	MOVWF       R10 
	MOVF        R15, 0 
	MOVWF       R11 
	MOVF        R0, 0 
L_random_pcg32_random_r7:
	BZ          L_random_pcg32_random_r8
	RRCF        R11, 1 
	RRCF        R10, 1 
	RRCF        R9, 1 
	RRCF        R8, 1 
	BCF         R11, 7 
	ADDLW       255
	GOTO        L_random_pcg32_random_r7
L_random_pcg32_random_r8:
	CLRF        R0 
	CLRF        R1 
	CLRF        R2 
	CLRF        R3 
	MOVF        R4, 0 
	SUBWF       R0, 1 
	MOVF        R5, 0 
	SUBWFB      R1, 1 
	MOVF        R6, 0 
	SUBWFB      R2, 1 
	MOVF        R7, 0 
	SUBWFB      R3, 1 
	MOVLW       15
	ANDWF       R0, 1 
	MOVLW       0
	ANDWF       R1, 1 
	ANDWF       R2, 1 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R12, 0 
	MOVWF       R0 
	MOVF        R13, 0 
	MOVWF       R1 
	MOVF        R14, 0 
	MOVWF       R2 
	MOVF        R15, 0 
	MOVWF       R3 
	MOVF        R4, 0 
L_random_pcg32_random_r9:
	BZ          L_random_pcg32_random_r10
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L_random_pcg32_random_r9
L_random_pcg32_random_r10:
	MOVF        R8, 0 
	IORWF       R0, 1 
	MOVF        R9, 0 
	IORWF       R1, 1 
	MOVF        R10, 0 
	IORWF       R2, 1 
	MOVF        R11, 0 
	IORWF       R3, 1 
;random.c,17 :: 		}
L_end_pcg32_random_r:
	RETURN      0
; end of random_pcg32_random_r

_randomSeed:

;random.c,21 :: 		void randomSeed(uint32_t seed)
;random.c,23 :: 		rng.state = seed << 16;
	MOVF        FARG_randomSeed_seed+1, 0 
	MOVWF       R3 
	MOVF        FARG_randomSeed_seed+0, 0 
	MOVWF       R2 
	CLRF        R0 
	CLRF        R1 
	MOVF        R0, 0 
	MOVWF       random_rng+0 
	MOVF        R1, 0 
	MOVWF       random_rng+1 
	MOVF        R2, 0 
	MOVWF       random_rng+2 
	MOVF        R3, 0 
	MOVWF       random_rng+3 
;random.c,24 :: 		rng.inc = seed & 0xffff;
	MOVLW       255
	ANDWF       FARG_randomSeed_seed+0, 0 
	MOVWF       R0 
	MOVLW       255
	ANDWF       FARG_randomSeed_seed+1, 0 
	MOVWF       R1 
	MOVF        FARG_randomSeed_seed+2, 0 
	MOVWF       R2 
	MOVF        FARG_randomSeed_seed+3, 0 
	MOVWF       R3 
	MOVLW       0
	ANDWF       R2, 1 
	ANDWF       R3, 1 
	MOVF        R0, 0 
	MOVWF       random_rng+4 
	MOVF        R1, 0 
	MOVWF       random_rng+5 
	MOVF        R2, 0 
	MOVWF       random_rng+6 
	MOVF        R3, 0 
	MOVWF       random_rng+7 
;random.c,25 :: 		}
L_end_randomSeed:
	RETURN      0
; end of _randomSeed

_randint:

;random.c,27 :: 		int randint(int min, int max)
;random.c,29 :: 		uint32_t rand = pcg32_random_r(&rng);
	MOVLW       random_rng+0
	MOVWF       FARG_random_pcg32_random_r_rng+0 
	MOVLW       hi_addr(random_rng+0)
	MOVWF       FARG_random_pcg32_random_r_rng+1 
	CALL        random_pcg32_random_r+0, 0
;random.c,30 :: 		return min + rand % (max - min + 1);
	MOVF        FARG_randint_min+0, 0 
	SUBWF       FARG_randint_max+0, 0 
	MOVWF       R4 
	MOVF        FARG_randint_min+1, 0 
	SUBWFB      FARG_randint_max+1, 0 
	MOVWF       R5 
	INFSNZ      R4, 1 
	INCF        R5, 1 
	MOVLW       0
	BTFSC       R5, 7 
	MOVLW       255
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Div_32x32_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R10, 0 
	MOVWF       R2 
	MOVF        R11, 0 
	MOVWF       R3 
	MOVF        FARG_randint_min+0, 0 
	ADDWF       R0, 1 
	MOVF        FARG_randint_min+1, 0 
	ADDWFC      R1, 1 
;random.c,31 :: 		}
L_end_randint:
	RETURN      0
; end of _randint

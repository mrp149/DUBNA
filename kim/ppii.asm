	NAME PPI
BOOT	SEGMENT AT 0FFFFH
STR	LABEL	WORD
BOOT	ENDS
code segment at 01000h
assume	cs:code
;	ACTIVATE 8255 PPI
	MOV	AL,0A6H
	OUT	046H,AL
	MOV	AL,05H	;SET UP INTERRUPT ENABLE
	OUT	046H,AL
	MOV	AL,0DH
	OUT	046H,AL
	MOV	AL,0FH
	OUT	046H,AL
START:
DMA_PAGE0	EQU	0A0H
DMA_PAGE1	EQU	0A2H
DMA_ADR0	EQU	060H
DMA_CNT0	EQU	062H
DMA_ADR1	EQU	064H
DMA_CNT1	EQU	066H
DMA_MODE	EQU	070H
DMA_STAT	EQU	070H
TEST_LEN	EQU	03FFEH
;	DISABLE DMA
	XOR	AL,AL
	OUT	DMA_MODE,AL
;SET CH0
;	SET CH0 PAGE TO 20000H
	MOV	DX,DMA_PAGE0
	MOV	AL,2
	OUT	DX,AL
;	SET CH0 ADDRESS
	MOV	AX,0000H
	OUT	DMA_ADR0,AL
	XCHG	AL,AH
	OUT	DMA_ADR0,AL
;	SET CH0 COUNTER
	MOV	AX,TEST_LEN
	DEC	AX
	OUT	DMA_CNT0,AL
	XCHG	AL,AH
	AND	AL,3FH
	OR	AL,40H
	OUT	DMA_CNT0,AL
;SET CH1
;	SET CH1 PAGE TO 30000H
	MOV	DX,DMA_PAGE1
	MOV	AL,3
	OUT	DX,AL
;	SET CH1 ADDRESS
	MOV	AX,0000H
	OUT	DMA_ADR1,AL
	XCHG	AL,AH
	OUT	DMA_ADR1,AL
;	SET CH1 COUNTER
	MOV	AX,TEST_LEN
	DEC	AX
	OUT	DMA_CNT1,AL
	XCHG	AL,AH
	AND	AL,3FH
	OR	AL,80H
	OUT	DMA_CNT1,AL
;	ACTIVATE 8257 DMA
	MOV	AL,41H
	OUT	DMA_MODE,AL
;	WAIT TERMINAL COUNTS
	MOV	CX,3000H
C1:	IN	AL,DMA_STAT
	AND	AL,3
	JNE	C2
	MOV	AL,09H
	OUT	46H,AL
	MOV	AL,08H
	OUT	46H,AL
	LOOP	C1
C2:
;	ACTIVATE 8257 DMA
	MOV	AL,42H
	OUT	DMA_MODE,AL
;	WAIT TERMINAL COUNTS
	MOV	CX,3000H
C3:	IN	AL,DMA_STAT
	AND	AL,3
	JNE	C4
	MOV	AL,0BH
	OUT	46H,AL
	MOV	AL,0AH
	OUT	46H,AL
	LOOP	C3
C4:	JMP	START
	END

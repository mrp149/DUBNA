	NAME DPM
BOOT	SEGMENT AT 0FFFFH
STR	LABEL	WORD
BOOT	ENDS
code segment at 01000h
assume	cs:code
START:
	MOV	DX,2048
	MOV	AX,0E000H
	MOV	ES,AX
	MOV	CX,DX
	CLD
	MOV	SI,0H
	MOV	DI,0H
	MOV	BX,0A5A5H
	MOV	DX,05A5AH
C123:
	MOV	AX,BX
	MOV	ES:[DI],AX
	ADD	DI,2
	MOV	AX,DX
	MOV	ES:[DI],AX
	ADD	DI,2
	LOOP C123
	INT 3
code	ends
	end

	NAME DPM
BOOT	SEGMENT AT 0FFFFH
STR	LABEL	WORD
BOOT	ENDS
code segment at 01000h
assume	cs:code
START:
	MOV	DX,1024
	MOV	AX,0E000H
	MOV	ES,AX
	MOV	CX,DX
	CLD
	MOV	SI,0H
	MOV	DI,0H
	MOV	BX,0A5A5H
	MOV	DX,05A5AH
C123:
	MOV	AX,0001H
	MOV	ES:[DI],AX
	ADD	DI,2
	MOV	AX,0203H
	MOV	ES:[DI],AX
	ADD	DI,2
	MOV	AX,0405H
	MOV	ES:[DI],AX
	ADD	DI,2
	MOV	AX,0607H
	MOV	ES:[DI],AX
	ADD	DI,2
	MOV	AX,7060H
	MOV	ES:[DI],AX
	ADD	DI,2
	MOV	AX,5040H
	MOV	ES:[DI],AX
	ADD	DI,2
	MOV	AX,3020H
	MOV	ES:[DI],AX
	ADD	DI,2
	MOV	AX,1000H
	MOV	ES:[DI],AX
	ADD	DI,2
	LOOP C123
C125:	MOV	CX,4096
	MOV	SI,0
C134:	MOV	AX,ES:[SI]
	ADD	SI,2
	LOOP	C134
	JMP C125
	INT 3
code	ends
	end

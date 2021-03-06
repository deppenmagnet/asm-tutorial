; Using Strings
; Each string instruction may require a source operand, a destination operand or both. 
; For 32-bit sections, string instructions use ESI and EDI to point to the source and destination
; operands, respectively.
;
; For 16-bit sections, however, the SI and DI are used.
;
; There are as far as I know 5 basic instructions for string processing:
; - MOVS - This instruction moves 1 Byte, Word or Doubleword of data from one memory location
;          to another.
; - LODS - This instruction loads from memory. If the operand is a Byte, it is loaded into AL,
;          if it is a Word into AX and if it is a Doubleword into EAX.
; - STOS - This instruction stores data like the LODS loads.
; - CMPS - This instruction compares two data items in memory. Data could be of size Byte, Word
;          or Doubleword
; - SCAS - This instruction compares the contentsw of a register (AL, AX, EAX) with the contents
;          of an item in memory of the same size.
;
; Each of these instructions has a Byte, Word and Doubleword version. String instructions can be repeated
; by using a repetition prefix.
;
; These instuctions use the ES:DI and DS:SI pair of registers, where DI and SI contain valid offset 
; addresses thet refer to byes stored in memory. SI is normally associated with DS (DataSegment); 
; DI is associated with ES (ExtraSegment).
;
; The DI:SI (or ESI) and ES:DI (or EDI) registers point to the source and destination operands.
; 
; For 16-bit addresses, the SI and DI are used. For 32-bit addresses, the ESI and EDI are used.
;
; Repetition Prefixes
; The REP prefix, when set before a string instruction, for example REP MOVSB, causes repetition
; of the instruction based on a counter placed in the CX register. REP executes the instruction,
; decreases CX and checks wherer CX equals zero.
;
; The Direction Flag (DF) determins the direction of the operation.
; - CLD (Clear Direction Flag -> DF=0) makes the operation left to right.
; - STD (Set Direction Flag -> DF=1) makes it the opposite direction.
;
; The REP prefix has the following variations:
; - REP: It is the unconditions REP. It repeats until CX is zero.
; - REPE or REPZ: Conditional REP. Repeats until CX is zero or ZF indicates zero/equal.
; - REPNE or REPNZ: Conditional REP. Repeats until CX is zero or ZF indicates not zero/not equal
;
section	.data
	msg1	db 13,10,"The strings are equal.",13,10
	m1len	equ $-msg1
	msg2	db 13,10, "The strings are not equal",13,10
	m2len	equ $-msg2
	str1	db "This is a string in memory.",13,10,0
	s1len	equ $-str1-1
	str2	db "This is a string in memory.",13,10,0
	s2len	equ $-str2-1
	str3	db "This is another string in memory.",13,10,0
	s3len	equ $-str3-1

section	.bss

section .text
	global _start				;tell the linker where to start

_start:						;start the program
						;print the first string
	mov	eax,4
	mov	ebx,1
	mov	ecx,str1
	mov	edx,s2len
	int	80h

						;print the second string
	mov	eax,4
	mov	ebx,1
	mov	ecx,str2
	mov	edx,s2len
	int 	80h

						;compare str1 with str2
	



_exit:						;end of program
	mov	eax,1
	mov	ebx,0
	int	80h


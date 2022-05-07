%ifdef COMMENT
write a program to perform multiplication of two eight bit hex no using successive addition  add and shift

%endif

section .data
	msg1 db "Enter first number : ", 0Ah
	len1 equ $-msg1
	msg2 db "Enter second number : ", 0Ah
	len2 equ $-msg2
	msg3 db " Result of Multiplication : ",0Ah
	len3 equ $-msg3
	newl db " ",0Ah
	nlen equ $-newl

section .bss

	num resb 10
	num1 resb 10
	num2 resb 10
	disparr resb 32
	
section .text
global _start
_start:

%macro accept 2

	mov rax,0
	mov rdi,0
	mov rsi,%1
	mov rdx,%2
	syscall
%endm

 %macro Disp 2
	mov rax,1
	mov rdi,1
	mov rsi,%1
	mov rdx,%2
	syscall
%endm

	Disp newl,nlen
	Disp msg1,len1
	accept num,03
	call convert
	mov [num1],al
	
	Disp newl,nlen
	
	Disp msg2,len2
	accept num,03
	call convert
	mov [num2],al
	
	Disp newl,nlen
		mov ax,0000h
con:
	add ax,[num1]
	dec byte[num2]
	jnz con
	push rax
	Disp msg3,len3		;result of multip
	pop rax
	call display
	Disp newl,nlen


mov rax,60			;Exit call
mov rdi,0
syscall



convert:				;convert ascii to hex procedure
	mov rsi,num
	mov al, [rsi]
	cmp al,39h
	jbe l1
	sub al,07h
l1:	sub al,30h
	rol al,04h
	mov bl,al
	inc rsi
	mov al,[rsi]
	cmp al,39h
	jbe l2
	sub al,07h
l2:	sub al,30h
	add al,bl
ret
	


display:
	
	mov rsi,disparr+1
	mov rcx,2
a1:
	mov rdx,0h
	mov rbx,10h
	div rbx
	cmp dl,09h
	jbe add30
	add dl,07h
add30:

	add dl,30h
	mov[rsi],dl
	dec rsi
	dec rcx
	jnz a1
	
Disp disparr,16
ret

	


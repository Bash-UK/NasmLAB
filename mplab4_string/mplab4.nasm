%ifdef COMMENT

write a program to enter a string and calculate its lengths


%endif


section .data
	msg1 db "Enter the string : ", 0Ah
	len1 equ $-msg1
	msg2 db "String  Lenght is : ", 0Ah
	len2 equ $-msg2
	newl db " ",0Ah
	nlen equ $-newl

section .bss
	str1 resb 10
	strlen resb 10
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


Disp msg1,len1
accept str1,strlen
push rax
Disp msg2,len2
pop rax
dec rax
call display

mov rax,60
mov rdi,0
syscall




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
Disp newl,nlen
ret

	
	
	
	
	
	

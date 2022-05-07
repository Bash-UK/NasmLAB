%ifdef COMMENT
factorial alp
%endif




section .data
msg db "Enter the number : ",0Ah
len equ $-msg
msg1 db "Factorial of the number is 1 ",0Ah
len1 equ $-msg1
msg2 db "The factorial of the number is  : ",0Ah
len2 equ $-msg2
newline db " ",0ah
nlen equ $-newline

section .bss

	disparr resb 20
	num resb 10
	no resb 10




section .text

global _start
_start :
	%macro Disp 2
	mov rax,1
	mov rdi,1
	mov rsi,%1
	mov rdx,%2
	syscall
	%endm

	%macro accept 2
	mov rax,0
	mov rdi,0
	mov rsi,%1
	mov rdx,%2
	syscall
	%endm
	
	Disp newline,nlen
	Disp msg,len
	accept num,3
	call convert
	cmp al,01h
	ja l3

	Disp msg1,len1
	Disp newline,nlen
	jmp exit

l3:	
	push rax
	Disp msg2,len2
	Disp newline,nlen
	pop rax
	mov rcx,rax
	dec rcx

l4:	
	push rax
	dec rax
	cmp rax , 01
	ja l4

l5:	
	pop rbx
	mul rbx
	dec rcx
	jnz l5
	call display
	
exit:	mov rax,60
	mov rdi,0
	syscall
	
display:
	mov rsi,disparr+3
	mov rcx,4

a2:	mov rdx,0
	mov rbx,10H
	div rbx
	cmp dl,09H
	jbe a1
	add dl,07h

a1:	
	add dl,30H
	mov[rsi],dl
	dec rsi
	dec rcx
	jnz a2 
Disp disparr,4
ret


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




%ifdef COMMENT

Enter the number : 
05
The factorial of the number is  : 
0078
%endif







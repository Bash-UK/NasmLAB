%ifdef COMMENT 

statement: write 64 bit alp to perform non overlap block transfer. 
block containing data can be defined in data section 
a macro is sequence of instruction assigned by name and to be used anywhere

%endif

section .data
	sarr db 01h,02h,03h,04h,05h
	darr db 00h,00h,00h,00h,00h
	cnt1 db 05		;to display source arr
	cnt2 db 05 		; to copy
	cnt3 db 05 		; to displ dest arr
	msg1 db "Source array : ", 0Ah
	len equ $-msg1
	msg2 db "Destination array : ", 0Ah
	len2 equ $-msg2
	newline db " ",0Ah
	nlen equ $-newline
	
	space db " "
	slen equ $-space

section .bss
	disparr resb 16



section .text
global _start
_start:

 %macro Disp 2
	mov rax,1
	mov rdi,1
	mov rsi,%1
	mov rdx,%2
	syscall
%endm


	Disp msg1,len
	mov rsi,sarr
	
l1:	push rsi			;displaying source arr sarr
	mov rax, [rsi]
	call display
	pop rsi
	inc rsi
	dec byte[cnt1]
	jnz l1
	
Disp newline,nlen
mov rsi,sarr
mov rdi,darr

l2:						;copying the src arr to dest arr
	mov al,[rsi]
	mov [rdi],al
	inc rsi
	inc rdi
	dec byte[cnt2]
	jnz l2
Disp newline,nlen
Disp msg2,len2
mov rsi,darr

l3:						;Displaying dest array
	push rsi
	mov rax,[rsi]
	call display
	pop rsi
	inc rsi
	dec byte[cnt3]
	jnz l3
	
Disp newline,nlen

	mov rax,60				;exit call
	mov rdi,0
	syscall
		
display:						;Display procedure
	mov rsi,disparr+1
	mov rcx,2
a1:
	mov rdx,0
	mov rbx,10h
	div rbx
	cmp dl,09h
	jbe add30h
	add dl,07h
add30h:
	add dl,30h
	mov[rsi],dl
	dec rsi
	dec rcx
jnz a1
Disp disparr,16
Disp space,slen
ret

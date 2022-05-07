section .data
	msg db "array. is:  ",0Ah
	len equ $-msg
	msg1 db "  ",0Ah
	len1 equ $-msg1
	pcount db " positive count is :  ",0Ah
	plen equ $-pcount
	ncount db "negative count is:   ",0Ah
	nlen equ $-ncount

	arr dq 1234567812345678h,1233745535276123h,8765432187654321h,1234876512348765h,4567546532722231h
	cnt db 05
	cnt1 db 05
	pcnt db 00
	ncnt db 00
section .bss
	disparr resb 16

section .text
	global _start:
_start:
		mov rax,1
		mov rdi,1
		mov rsi,msg
		mov rdx,len
		syscall
		mov rsi,arr
l1:
		push rsi
		mov rax,[rsi]
		call display
		mov rax,1
		mov rdi,1
		mov rsi,msg1
		mov rdx,len1
		syscall
		pop rsi
		add rsi,8
		dec byte[cnt]
		jnz l1
		
		mov rsi,arr
a2:		bt qword[rsi],63
		jc nc
		inc byte[pcnt]
		jmp a3
nc:		inc byte[ncnt]
a3:		add rsi,8
		dec byte[cnt1]
		jnz a2
	
		mov rax,1
		mov rdi,1
		mov rsi,pcount
		mov rdx,plen
		syscall
		
		mov ah,00h
		mov al,[pcnt] 
		call display
		
		mov rax,1
		mov rdi,1
		mov rsi,msg1
		mov rdx,len1
		syscall
		
		mov rax,1
		mov rdi,1
		mov rsi,ncount
		mov rdx,nlen
		syscall
		
		mov ah,00h				;negative count
		mov al,[ncnt]
		call display
		
		mov rax,60				;exit call
		mov rdi,0
		syscall
		
display:						;Display procedure
	mov rsi,disparr+15
	mov rcx,16
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
mov rax,1
mov rdi,1
mov rsi,disparr
mov rdx,16
syscall
ret
					

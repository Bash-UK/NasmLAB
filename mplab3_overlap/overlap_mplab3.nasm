%ifdef COMMENT
write an ALP to perform overlap block transfer with string specific instructions
%endif


section .data

arr db 01h,02h,03h,04h,05h,06h,07h,08h,09h,0Ah,0Bh,0Ch,0Dh,0Eh,0Fh

	msg1 db "Input array : ", 0Ah
	len1 equ $-msg1
	msg2 db "Output array : ", 0Ah
	len2 equ $-msg2
	newline db " ",0Ah
	nlen equ $-newline
	space db " "
	slen equ $-space
	cnt1 db 15		;to display source arr
	cnt2 db 15		; to displ dest arr
	 		

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


Disp msg1,len1

mov rsi,arr

l1:	mov al,[rsi]
	push rsi			;displaying source arr sarr
	mov rax, [rsi]
	call display
	pop rsi
	inc rsi
	dec byte[cnt1]
	jnz l1
	
Disp newline,nlen


std					; Overlap  Block transfer
mov rsi,arr
mov rdi,arr
add rsi,09
add rdi,13
mov rcx,0Ah
rep movsb				; ES:[rdi]=DS:[rsi]


Disp msg2,len2
mov rsi,arr

l3:					;Displaying dest array
	push rsi
	mov rax,[rsi]
	call display
	pop rsi
	inc rsi
	dec byte[cnt2]
	jnz l3
	
Disp newline,nlen



	mov rax,60			;exit call
	mov rdi,0
	syscall
	
	
display:				;Display procedure
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














































































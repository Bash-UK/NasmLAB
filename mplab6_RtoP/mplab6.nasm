
%ifdef COMMENT

write an alp to switch from real to protected mode
display value of MSW,ldtr,tr,gdtr,idtr

%endif


section .data
	msgMSW db "Data In MSW:  ",0Ah
	MSWlen equ $-msgMSW

	msgLDT db "Data In LDTR:  ",0Ah
	LDTlen equ $-msgLDT
	msgGDT db "Data In GDTR:  ",0Ah
	GDTlen equ $-msgGDT
	msgIDT db "Data In IDTR:  ",0Ah
	IDTlen equ $-msgIDT
	msgTR db "Data In TR:  ",0Ah
	TRlen equ $-msgTR

	realmode db "Data In LDTR:  ",0Ah
	rlen equ $-realmode

	newline db "  ",0Ah
	nlen equ $-newline
	 

section .bss
	disparr resb 10
	cr0_data resb 10
    	gdt_data resb 10
    	ldt_data resb 10
    	idt_data resb 10
    	tr_data resb 10





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

	smsw eax
	bt eax,00
	jc protectedMode
	
	Disp realmode,rlen
	jmp exit
	
protectedMode:
	Disp msgMSW,MSWlen
	mov [cr0_data],eax
	mov ax,[cr0_data+2]
	call display
	mov ax,[cr0_data]
	call display
	Disp newline,nlen
	
	Disp msgLDT,LDTlen
	sldt [ldt_data]
	mov ax,[ldt_data]
	call display
	Disp newline,nlen
	
	Disp msgTR,TRlen
	str [tr_data]
	mov ax,[tr_data]
	call display
	Disp newline,nlen
	
	Disp msgGDT,GDTlen
	sgdt [gdt_data]
	mov ax,[gdt_data+4]
	call display
	mov ax,[gdt_data+2]
	call display
	mov ax,[gdt_data]
	call display	
	Disp newline,nlen

	Disp msgIDT,IDTlen
	sidt [idt_data]
	mov ax,[idt_data+4]
	call display
	mov ax,[idt_data+2]
	call display
	mov ax,[idt_data]
	call display	
	Disp newline,nlen




exit:
	mov rax,60
        mov rdx,0
        syscall



		
display:						;Display procedure
	mov rsi,disparr+3
	mov rcx,4
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
Disp disparr,4
ret





%ifdef OUTPUT

Data In MSW:  
0000000F  
Data In LDTR:  
0000  
Data In TR:  
0040  
Data In GDTR:  
00077000007F  
Data In IDTR:  
000000000FFF  


%endif







































	
	
	


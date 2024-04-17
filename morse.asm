; input: program
; output: .--..-.-----..-..---
format ELF64 executable 3	; value 3 marks the executable for Linux system

entry start

struc morse_code alphabet, len, code{
        .alphabet db alphabet
	.len db len
        .code db code
}

morse_a morse_code "a", 2, ".-"
morse_g morse_code "g", 3, "--."
morse_m morse_code "m", 2, "--"
morse_o morse_code "o", 3, "---"
morse_p morse_code "p", 4, ".--."
morse_r morse_code "r", 3, ".-."

morse_codes:
	dq morse_a
	dq morse_g
	dq morse_m
	dq morse_o
	dq morse_p
	dq morse_r

segment readable writable

input	db "program", 0

segment readable writable

morse_output dq ?

segment readable executable

start:
	mov rdx, input	

.char_to_morse_loop:
	mov bl, byte [rdx]	; bl = arg to find_morse_code
	cmp bl, 0
	je .end
	add rdx, 1
	push rdx
	call find_morse_code	
	mov rsi, rax 	; arg 2 = msg
	mov rdx, 0
	mov dl, byte [r8]; arg 3 = r8 = char count. Return value in r8
	call print
	pop rdx
	jmp .char_to_morse_loop

.end:
	call exit

find_morse_code:
	mov rdx, morse_codes

find_morse_code_loop:
	mov rcx, [rdx]
	mov al, byte [rcx]
	add rdx, 8
	cmp al, bl
	jne find_morse_code_loop
	 
	lea rax, [rcx + 2]		; adddress of code
	lea r8, [rcx + 1]		; len of code
	ret	; result in rax and r8

print:
	; write string to stdout
	mov     rax, 1		; syscall #1 (write)
	mov     rdi, rax	; arg 1 = 1 (stdout)
	syscall			; call write
	ret

exit:
	mov rax, 60     ; syscall #60 (exit)
	mov rdi, 0      ; arg 1 = 0 (OK)
	syscall         ; call exit

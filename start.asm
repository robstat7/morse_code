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


segment readable executable

start:

exit:
	mov rax, 60     ; syscall #60 (exit)
	mov rdi, 0      ; arg 1 = 0 (OK)
	syscall         ; call exit

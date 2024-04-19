format ELF64 executable 3	; value 3 marks the executable for Linux system

entry start

start:
	mov eax, 1 ; one instruction is needed to assemble a correct ELF64 executable

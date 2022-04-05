.data
	sum: .long 0

.text

.globl f
.type f, @function

f: 
	pushq %rdi
	pushq %rsi
	pushq %rdx
	 
    movq %rdx, %rcx

	cycle:
		movl (%rdi), %eax
		
		mull (%rsi)

		addl %eax, sum

		addq $4, %rdi
		addq $4, %rsi
		
		loop cycle
		
	movl sum, %eax

	popq %rdx
	popq %rsi
	popq %rdi
	
	ret 
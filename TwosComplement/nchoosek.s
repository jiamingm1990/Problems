	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 12, 0	sdk_version 12, 3
	.globl	_main                           ## -- Begin function main
	.p2align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$96, %rsp
	movq	___stack_chk_guard@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	movq	%rax, -8(%rbp)
	movl	$0, -68(%rbp)
	leaq	-64(%rbp), %rdi
	leaq	l___const.main.tests(%rip), %rsi
	movl	$48, %edx
	callq	_memcpy
	movq	$6, -80(%rbp)
	movl	$0, -84(%rbp)
LBB0_1:                                 ## =>This Inner Loop Header: Depth=1
	movslq	-84(%rbp), %rax
	cmpq	$6, %rax
	jae	LBB0_4
## %bb.2:                               ##   in Loop: Header=BB0_1 Depth=1
	movslq	-84(%rbp), %rax
	movl	-64(%rbp,%rax,8), %eax
	movl	%eax, -92(%rbp)                 ## 4-byte Spill
	movslq	-84(%rbp), %rax
	movl	-60(%rbp,%rax,8), %eax
	movl	%eax, -88(%rbp)                 ## 4-byte Spill
	movslq	-84(%rbp), %rax
	movl	-64(%rbp,%rax,8), %edi
	movslq	-84(%rbp), %rax
	movl	-60(%rbp,%rax,8), %esi
	callq	_choose
	movl	-92(%rbp), %esi                 ## 4-byte Reload
	movl	-88(%rbp), %edx                 ## 4-byte Reload
	movl	%eax, %ecx
	leaq	L_.str(%rip), %rdi
	movb	$0, %al
	callq	_printf
## %bb.3:                               ##   in Loop: Header=BB0_1 Depth=1
	movl	-84(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -84(%rbp)
	jmp	LBB0_1
LBB0_4:
	movq	___stack_chk_guard@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	movq	-8(%rbp), %rcx
	cmpq	%rcx, %rax
	jne	LBB0_6
## %bb.5:
	xorl	%eax, %eax
	addq	$96, %rsp
	popq	%rbp
	retq
LBB0_6:
	callq	___stack_chk_fail
	ud2
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90                         ## -- Begin function choose
_choose:                                ## @choose
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movl	%edi, -8(%rbp)
	movl	%esi, -12(%rbp)
	cmpl	$0, -12(%rbp)
	jge	LBB1_2
## %bb.1:
	movl	$0, -4(%rbp)
	jmp	LBB1_7
LBB1_2:
	movl	$1, -16(%rbp)
	cmpl	$0, -8(%rbp)
	jge	LBB1_6
## %bb.3:
	movl	-12(%rbp), %eax
	subl	-8(%rbp), %eax
	subl	$1, %eax
	movl	%eax, -8(%rbp)
	movl	-12(%rbp), %eax
	movl	$2, %ecx
	cltd
	idivl	%ecx
	cmpl	$1, %edx
	jne	LBB1_5
## %bb.4:
	movl	$-1, -16(%rbp)
LBB1_5:
	jmp	LBB1_6
LBB1_6:
	movl	-16(%rbp), %eax
	movl	%eax, -20(%rbp)                 ## 4-byte Spill
	movl	-8(%rbp), %edi
	movl	-12(%rbp), %esi
	callq	_pos_choose
	movl	%eax, %ecx
	movl	-20(%rbp), %eax                 ## 4-byte Reload
	imull	%ecx, %eax
	movl	%eax, -4(%rbp)
LBB1_7:
	movl	-4(%rbp), %eax
	addq	$32, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90                         ## -- Begin function pos_choose
_pos_choose:                            ## @pos_choose
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	movl	%edi, -8(%rbp)
	movl	%esi, -12(%rbp)
	cmpl	$0, -12(%rbp)
	jl	LBB2_2
## %bb.1:
	movl	-8(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jge	LBB2_3
LBB2_2:
	movl	$0, -4(%rbp)
	jmp	LBB2_17
LBB2_3:
	movl	-12(%rbp), %eax
	addl	$1, %eax
	movslq	%eax, %rdi
	shlq	$2, %rdi
	callq	_malloc
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rdi
	movl	-12(%rbp), %eax
	addl	$1, %eax
	movslq	%eax, %rsi
	callq	_init
	movq	%rax, -24(%rbp)
	movl	$1, -28(%rbp)
LBB2_4:                                 ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB2_9 Depth 2
	movl	-28(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jge	LBB2_14
## %bb.5:                               ##   in Loop: Header=BB2_4 Depth=1
	movl	-28(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jge	LBB2_7
## %bb.6:                               ##   in Loop: Header=BB2_4 Depth=1
	movl	-28(%rbp), %eax
	movl	%eax, -40(%rbp)                 ## 4-byte Spill
	jmp	LBB2_8
LBB2_7:                                 ##   in Loop: Header=BB2_4 Depth=1
	movl	-12(%rbp), %eax
	movl	%eax, -40(%rbp)                 ## 4-byte Spill
LBB2_8:                                 ##   in Loop: Header=BB2_4 Depth=1
	movl	-40(%rbp), %eax                 ## 4-byte Reload
	movl	%eax, -32(%rbp)
LBB2_9:                                 ##   Parent Loop BB2_4 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	cmpl	$1, -32(%rbp)
	jl	LBB2_12
## %bb.10:                              ##   in Loop: Header=BB2_9 Depth=2
	movq	-24(%rbp), %rax
	movl	-32(%rbp), %ecx
	subl	$1, %ecx
	movslq	%ecx, %rcx
	movl	(%rax,%rcx,4), %edx
	movq	-24(%rbp), %rax
	movslq	-32(%rbp), %rcx
	addl	(%rax,%rcx,4), %edx
	movl	%edx, (%rax,%rcx,4)
## %bb.11:                              ##   in Loop: Header=BB2_9 Depth=2
	movl	-32(%rbp), %eax
	addl	$-1, %eax
	movl	%eax, -32(%rbp)
	jmp	LBB2_9
LBB2_12:                                ##   in Loop: Header=BB2_4 Depth=1
	jmp	LBB2_13
LBB2_13:                                ##   in Loop: Header=BB2_4 Depth=1
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
	jmp	LBB2_4
LBB2_14:
	movl	$1, -36(%rbp)
	cmpl	$0, -12(%rbp)
	jle	LBB2_16
## %bb.15:
	movq	-24(%rbp), %rax
	movslq	-12(%rbp), %rcx
	movl	(%rax,%rcx,4), %eax
	movq	-24(%rbp), %rcx
	movl	-12(%rbp), %edx
	subl	$1, %edx
	movslq	%edx, %rdx
	addl	(%rcx,%rdx,4), %eax
	movl	%eax, -36(%rbp)
LBB2_16:
	movq	-24(%rbp), %rdi
	callq	_free
	movl	-36(%rbp), %eax
	movl	%eax, -4(%rbp)
LBB2_17:
	movl	-4(%rbp), %eax
	addq	$48, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90                         ## -- Begin function init
_init:                                  ## @init
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rax
	movl	$1, (%rax)
	movl	$1, -20(%rbp)
LBB3_1:                                 ## =>This Inner Loop Header: Depth=1
	movslq	-20(%rbp), %rax
	cmpq	-16(%rbp), %rax
	jae	LBB3_4
## %bb.2:                               ##   in Loop: Header=BB3_1 Depth=1
	movq	-8(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movl	$0, (%rax,%rcx,4)
## %bb.3:                               ##   in Loop: Header=BB3_1 Depth=1
	movl	-20(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -20(%rbp)
	jmp	LBB3_1
LBB3_4:
	movq	-8(%rbp), %rax
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__const
	.p2align	4                               ## @__const.main.tests
l___const.main.tests:
	.long	4294967295                      ## 0xffffffff
	.long	8                               ## 0x8
	.long	4294967293                      ## 0xfffffffd
	.long	7                               ## 0x7
	.long	5                               ## 0x5
	.long	2                               ## 0x2
	.long	10                              ## 0xa
	.long	5                               ## 0x5
	.long	1000                            ## 0x3e8
	.long	500                             ## 0x1f4
	.long	4294967286                      ## 0xfffffff6
	.long	9                               ## 0x9

	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"C(%d, %d) = %d\n"

.subsections_via_symbols

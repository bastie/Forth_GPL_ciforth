dnl $Id$
dnl Copyright(2000): Albert van der Horst, HCC FIG Holland by GNU Public License
divert(-1)dnl
dnl
define({_HEADER_ASM},{;
; This is a NASM version of ciforth created by ``m4'' from the generic listing.
; It can be assembled using ``nasm'' obtainable via :
; Source: ftp://ftp.us.kernel.org/pub/software/devel/nasm/source/
; URL: http://www.cryogen.com/Nasm/
_LINUX_N_({
; This version can be assembled on a Linux system by
;   nasm forth.asm -felf -o forth.o
;   ld forth.o -o forth
;And to get the smallest possible executable(optional):
;   strip forth -s -R .bss -R .comment
})dnl
_LINUX_C_({
; This source is to be linked with c-code. You are referred to the
; information in the generic system for building the executable.
; In general be warned that GNU(-Linux) is hard on those linking c
;  with assembler code.
})dnl
_PC_({
; This version can be assembled on a Linux system in behalf of a
; _HOSTED_MSDOS_({MS-DOS}) _BOOTED_({standalone (booting)}) version by
;   nasm -fbin ciforth.asm -o ciforth.com})
; For assembling on other systems where nasm is available see the
; documentation of nasm.
_BOOTED_({; See again the generic system manual for more information how to install
; booting versions.
})})dnl
dnl
dnl Directives ignored by NASM.
define({ASSUME},;)dnl Turn ASSUME into comment.
define({CSEG},;)dnl Turn CSEG into comment.
define({END},;)dnl Turn END into comment.
define({_OFFSET})dnl Ignore this design error altogether.
define({PAGE},;)dnl Turn PAGE into comment.
define({PROC},;)dnl Turn PROC into comment.
define({TITLE},;)dnl Turn TITLE into comment.
define({_CELL_PTR},{ CELL_M4})dnl Make it specify SIZE only.
dnl
dnl NASM doesnot allow to shift the program counter with ORG
define({_NEW_ORG},{RESB    $1-($-$$)})dnl
dnl
define({_RESB},{RESB    $1})dnl
dnl
dnl Specification of the length of an operand,
dnl needed to get exactly the same code as MASM.
define({_BYTE},BYTE)dnl Operand has length BYTE.
dnl Fill in where MASM introduces a superfluous NOP
define({_EXTRANOP},NOP)dnl Superfluous nops introduced by MASM
dnl
dnl More complicated tricks to get rid of MASM.
define({_ENDP},;)dnl Each ENDP is started with _ENDP in generic listing.
dnl
define({RELATIVE_WRT_ORIG}, {$1 - $$})
dnl
dnl Handling large blocks of comment
define({_COMMENT},{%if 0})dnl
define({_ENDCOMMENT},{%endif})dnl
define({_BYTE_PTR},{BYTE $1})dnl
define({SET_16_BIT_MODE},{BITS   16})dnl
define({SET_32_BIT_MODE},{BITS   32})dnl
define({_ALIGN},{ALIGN    $1})dnl
define({DSS},{DB})dnl
divert{}dnl

RISC-V extensions can be enabled using .option which is used in situations where some functions may have alternate implementations using them. These functions can be swapped at runtime based on the available extensions on the current system whilst the executable itself runs on systems without these extensions. When this is used, GDB does not properly disassemble functions containing instructions from extensions enabled with .option.

Example tested on (GDB 14.2):

`marchgc` compiled with: gcc -march=rv64gc -o marchgc marchgc.S

    .option push
    .option arch, +zve64x
    .globl main
    main:
           vsetivli zero, 16, e8, ta, ma
    .option pop

`gdb -ex 'disas main' marchgc`:

     0x0000000000000608 <+0>:	.insn	4, 0xcc087057

`marchgcv` compiled with gcc -march=rv64gcv -o marchgcv marchgcv.S

    .globl main
    main:
           vsetivli zero, 16, e8, ta, ma

`gdb -ex 'disas main' marchgcv`:

    0x0000000000000608 <+0>:	vsetivli	zero,16,e8,m1,ta,ma

See https://sourceware.org/bugzilla/show_bug.cgi?id=31926

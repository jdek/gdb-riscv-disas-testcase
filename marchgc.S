.option push
.option arch, +zve64x
.globl main
main:
       vsetivli zero, 16, e8, ta, ma
.option pop

all: disas.txt

marchgc: marchgc.S
	gcc -march=rv64gc -o $@ $<
marchgcv: marchgcv.S
	gcc -march=rv64gcv -o $@ $<

disas.txt: marchgc marchgcv
	echo | gdb -ex 'disas main' marchgc  > disas.txt
	echo | gdb -ex 'disas main' marchgcv >> disas.txt
	rm -f marchgc
	rm -f marchgcv

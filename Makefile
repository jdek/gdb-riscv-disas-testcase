default: all

marchgc: marchgc.S
	gcc -march=rv64gc -o $@ $<

marchgcv: marchgcv.S
	gcc -march=rv64gcv -o $@ $<

%_disas.txt: %
	echo | gdb -ex 'disas main' $< > $@

%_objdump.txt: %
	objdump -D $< > $@

%_readelf.txt: %
	readelf -a $< > $@

INFO  = marchgc_disas.txt marchgc_objdump.txt marchgc_readelf.txt 
INFO += marchgcv_disas.txt marchgcv_objdump.txt marchgcv_readelf.txt

all: $(INFO)

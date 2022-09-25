all: compile run_verdi

compile:
	vcs \
		-f file.list \
		-timescale=1ns/10ps \
		-fsdb -full64 -R +vc +v2k -sverilog -debug_all\
		-P ${LD_LIBRARY_PATH}/novas.tab ${LD_LIBRARY_PATH}/pli.a \
		| tee vcs.log &

sim:
	./simv -l sim.log

run_verdi:
	verdi -f file.list -ssf tb.fsdb &

clean:
	rm -rf *.log csrc *.vpd *.key *.vdb verdiLog *.bat *.conf simv.daidir simv *.fsdb *.bak *.rc



QUESTA := /home/share/questa.csh
SHELL  := /bin/csh

TOP := tb

.ONESHELL:

# -------------------------------------------------
# Default target
# -------------------------------------------------
all:
	source $(QUESTA)
	make clean
	make compile
	make simulate

# -------------------------------------------------
# Compile
# -------------------------------------------------
compile:
	source $(QUESTA)
	vlib work
	vmap work work
	vlog -sv dma_top.sv

# -------------------------------------------------
# Simulate (no coverage)
# -------------------------------------------------
simulate:
	source $(QUESTA)
	vsim -c work.$(TOP) \
		+UVM_VERBOSITY=UVM_MEDIUM \
		-do "run -all; exit"

# -------------------------------------------------
# Simulate with coverage
# -------------------------------------------------
main:
	source $(QUESTA)
	make clean
	vlib work
	vmap work work
	vlog -sv +acc +cover +fcover -l dma_top.log dma_top.sv
	vsim -vopt work.$(TOP) \
		-voptargs="+acc=npr" \
		-assertdebug \
		-l simulation.log \
		-coverage \
		-c \
		-do "coverage save -onexit -assert -directive -cvg -codeAll coverage.ucdb; run -all; exit"
	vcover report -html coverage.ucdb -htmldir covReport -details

# -------------------------------------------------
# Coverage read
# -------------------------------------------------
read:
	source $(QUESTA)
	vcover report -details coverage.ucdb

# -------------------------------------------------
# View coverage
# -------------------------------------------------
view:
	firefox ./covReport/index.html &

# -------------------------------------------------
# View log
# -------------------------------------------------
log:
	less -R simulation.log

# -------------------------------------------------
# Clean
# -------------------------------------------------
clean:
	rm -rf work transcript *.log *.ucdb covReport wave.vcd
	clear

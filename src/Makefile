# -------------------------------------------------
# Questa setup
# -------------------------------------------------
QUESTA := /home/share/questa.csh
SHELL  := /bin/csh

TOP := top

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
	vlog -sv +acc dma_top.sv

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
cov:
	source $(QUESTA)
	vsim -coverage -c work.$(TOP) \
		-voptargs="+acc=npr" \
		-assertdebug \
		-l simulation.log \
		-do "run -all; coverage save coverage.ucdb; exit"
	vcover report -details coverage.ucdb
	vcover report -html coverage.ucdb -htmldir covReport

# -------------------------------------------------
# View coverage
# -------------------------------------------------
view:
	firefox covReport/index.html &

# -------------------------------------------------
# View log
# -------------------------------------------------
log:
	less -R simulation.log

# -------------------------------------------------
# Clean
# -------------------------------------------------
clean:
	rm -rf work transcript *.log *.ucdb covReport
	clear

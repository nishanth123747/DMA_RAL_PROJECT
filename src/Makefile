#compile:
#			vlib work;
#			vlog -sv dma_top.sv
					 
#simulate:
			#vsim top -voptargs=+acc=npr -l top.log -c -do "run -all;quit;"
			 #vsim -novopt work.top
#			 vsim -c work.top
#clear:
#			clear

QUESTA := /home/share/questa.csh
SHELL := /bin/csh

IGNORE:
	make clean
	make view

.ONESHELL:

all:
	source $(QUESTA) 
	make clean 
	make compile 
	make simulate

main:
	source $(QUESTA)
	make clean
	vlog -sv +acc +cover +fcover -l dma_top.log dma_top.sv
	vsim -vopt work.top -voptargs=+acc=npr -assertdebug -l simulation.log -coverage -c -do "coverage save -onexit -assert -directive -cvg -codeAll coverage.ucdb; run -all; exit"
	vcover report -html coverage.ucdb -htmldir covReport -details

read:
	source $(QUESTA)
	vcover report -details coverage.ucdb

view:
	firefox ./covReport/index.html

compile:
	source $(QUESTA)
	vlog -sv dma_top.sv

simulate:
	vsim -c top +UVM_VERBOSITY=UVM_MEDIUM -do "run -all; exit"

log:
	less -R simulation.log

clean:
	rm transcript 
	rm -rf work covReport
	rm wave.vcd simulation.log dma_top.log coverage.ucdb 

clear:
	clear

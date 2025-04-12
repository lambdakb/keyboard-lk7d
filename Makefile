NAME	:= LK7D
GITROOT	:= $(shell git rev-parse --show-toplevel)
KIBOT	:= $(GITROOT)/.kibot/bin/kibot

default: export step

test:
	$(info + [$(NAME)] $@)
	$(KIBOT) -c .kibot/test.kibot.yaml -b ./pcb/lk7d-pcb.kicad_pcb

export: pcb plate

pcb:
	$(info + [$(NAME)] $@)
	mkdir -p ./output/pcb
	$(KIBOT) -c .kibot/pcb.kibot.yaml -b ./pcb/lk7d-pcb.kicad_pcb

plate:
	$(info + [$(NAME)] $@)
	mkdir -p ./output/plate
	$(KIBOT) -c .kibot/plate.kibot.yaml -d output/plate -b ./case/plate/lk7d-plate.kicad_pcb

step:
	$(info + [$(NAME)] $@)
	mkdir -p ./output/step
	$(KIBOT) -c .kibot/pcb.kibot.yaml   -d output -b ./pcb/lk7d-pcb.kicad_pcb 3d_step
	$(KIBOT) -c .kibot/plate.kibot.yaml -d output -b ./case/plate/lk7d-plate.kicad_pcb 3d_step

clean:
	$(info + [$(NAME)] $@)
	rm -rf output/pcb output/case output/step

.PHONY: default test export pcb plate clean

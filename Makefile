USER_ID := $(shell id -u)

HTML_REPORT=results/wolf_sheep_AB.html
RMD_REPORT=src/wolf_sheep_AB.Rmd
NLOGO_MODEL=src/wolf-sheep-predation.nlogo
NLOGO_DATA=data/vary_food_gains.csv
BEHAVIOR_SPACE_SCRIPT=src/run-behavior-space.sh
BUILD=build

# Note: using the empty target pattern to prevent rebuilding unecessarily
# https://www.gnu.org/software/make/manual/make.html#Empty-Targets
$(BUILD): docker-compose.yml netlogo/* rstudio/* .Rprofile wolf-sheep.Rproj
	docker-compose build
	touch $(BUILD)

$(HTML_REPORT): $(RMD_REPORT) $(NLOGO_DATA) $(BUILD)
	echo "Producing report"
	docker-compose run --rm analysis R -e "rmarkdown::render(\"$(RMD_REPORT)\", output_file=\"../$(HTML_REPORT)\")"

$(NLOGO_DATA): $(NLOGO_MODEL) $(BEHAVIOR_SPACE_SCRIPT)
	echo "Producing behaviour space results"
	docker-compose run --rm netlogo /code/$(BEHAVIOR_SPACE_SCRIPT)

.DEFAULT_GOAL := run
.PHONY: run
run: $(HTML_REPORT)

.PHONY: interact
interact:
	xhost +local:docker
	docker-compose up -d
	sensible-browser localhost:8787

.PHONY: clean
clean:
	rm -f $(HTML_REPORT) $(NLOGO_DATA)

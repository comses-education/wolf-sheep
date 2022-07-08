HTML_REPORT=results/wolf_sheep_AB.html
RMD_REPORT=src/wolf_sheep_AB.Rmd
NLOGO_MODEL=src/wolf-sheep-predation.nlogo
NLOGO_DATA=data/vary_food_gains.csv
BEHAVIOR_SPACE_SCRIPT=src/run-behavior-space.sh
BUILD=build

# OSG preamble

# user to connect to OSG as
OSG_USERNAME := ${USER}
# name of this computational model
MODEL_NAME := wolf-sheep
# the directory (in the container) where the computational model source
# code or executable can be called, e.g., main.py | netlogo-headless.sh
MODEL_CODE_DIRECTORY := /code
# entrypoint script to be called by job-wrapper.sh
ENTRYPOINT_SCRIPT := src/run-behavior-space.sh
# entrypoint script language
ENTRYPOINT_SCRIPT_EXECUTABLE := bash
# the OSG output file to be transferred
OSG_OUTPUT_FILES := results.zip
# OSG submit template
OSG_SUBMIT_TEMPLATE := scripts/submit.template
# the submit file to be executed on OSG via `condor_submit ${OSG_SUBMIT_FILE}`
OSG_SUBMIT_FILENAME := scripts/${MODEL_NAME}.submit
# the initial entrypoint for the OSG job, calls ENTRYPOINT_SCRIPT
OSG_JOB_SCRIPT := job-wrapper.sh

SINGULARITY_DEF := Singularity.def
CURRENT_VERSION := v1
SINGULARITY_IMAGE_NAME = ${MODEL_NAME}-${CURRENT_VERSION}.sif


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

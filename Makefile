USER_ID := $(shell id -u)

HTML_REPORT=results/wolf_sheep_AB.html
RMD_REPORT=src/wolf_sheep_AB.Rmd
NLOGO_MODEL=src/wolf-sheep-predation.nlogo
NLOGO_DATA=data/vary_food_gains.csv
SH_BEHAVIOUR_SPACE=src/run-wolf-sheep-predation-behaviourspace.sh

.PHONY: build
build: docker-compose.yml netlogo/* rstudio/* .Rprofile wolf-sheep.Rproj
	docker-compose build

$(HTML_REPORT): $(RMD_REPORT) $(NLOGO_DATA) build
	echo "Producing report"
	docker-compose run --rm --user ${USER_ID}:${USER_ID} analysis R -e "rmarkdown::render(\"$(RMD_REPORT)\", output_file=\"../$(HTML_REPORT)\")"

$(NLOGO_DATA): $(NLOGO_MODEL) $(SH_BEHAVIOUR_SPACE)
	echo "Producing behaviour space results"
	docker-compose run --rm --user ${USER_ID}:${USER_ID} netlogo /code/$(SH_BEHAVIOUR_SPACE)

.DEFAULT_GOAL := run
.PHONY: run
run: $(HTML_REPORT)

.PHONY: interact
interact:
	xhost +local:docker
	docker-compose up -d
	sensible-browser localhost:8787

.PHONY: build
build: docker-compose.yml netlogo/* rstudio/* src/*
	docker-compose build

results/wolf_sheep_AB.html: src/wolf_sheep_AB.Rmd data/vary_food_gains.csv
	echo "Producing report"
	docker-compose run --rm analysis R -e "rmarkdown::render(\"src/wolf_sheep_AB.Rmd\", output_file=\"../results/wolf_sheep_AB.html\")"

data/vary_food_gains.csv: src/wolf-sheep-predation.nlogo src/run-wolf-sheep-predation-behaviourspace.sh
	echo "Producing behaviour space results"
	docker-compose run --rm netlogo /code/src/run-wolf-sheep-predation-behaviourspace.sh

.PHONY: run
run: results/wolf_sheep_AB.html

.PHONY: interact
interact:
	docker-compose up -d
	sensible-browser localhost:8787

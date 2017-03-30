#!/usr/bin/env bash

netlogo_image="comses/resbaz-netlogo:5.3.1"
analysis_image="comses/resbaz-analysis:3.3.3"

netlogo_volumes="-v `pwd`:/code"
analysis_volumes="-v `pwd`:/home/rstudio/code -v /home/rstudio/code/packrat" 

if [ "$1" == "build" ]; then
	docker build netlogo --tag comses/resbaz-netlogo:5.3.1
	docker build . -f rstudio/Dockerfile --tag comses/resbaz-analysis:3.3.3
elif [ "$1" == "run" ]; then
	netlogo_command=$(cat <<-END
		/netlogo/app/netlogo-headless.sh \
			--model /code/src/wolf-sheep-predation.nlogo \
			--experiment vary_food_gains \
			--table /code/data/vary_food_gains.csv
		END)
	analysis_command='R -e "rmarkdown::render(\"src/wolf_sheep_AB.Rmd\", output_file=\"../results/wolf_sheep_AB.html\")"' 

	printf "Running Analysis Pipeline...\n"
	if [ ! -f "data/vary_food_gains.csv" ]; then
		echo Generating NetLogo data
		netlogo_docker_run="docker run --rm -i $netlogo_volumes $netlogo_image $netlogo_command"
		echo $netlogo_docker_run
		eval $netlogo_docker_run
		echo NetLogo data generated
	else
		echo NetLogo data already exists. Skipping...
	fi

	echo -e "\nCreating HTML Report"
	echo $analysis_command
	analysis_docker_run="docker run --rm -i $analysis_volumes $analysis_image $analysis_command"
	echo $analysis_docker_run
	eval $analysis_docker_run

elif [ "$1" == "interact" ]; then
	echo Running RStudio and NetLogo interactively

	netlogo_command="docker run --rm -d -p 6080:6080 -e PASSWORD=netlogo $netlogo_volumes $netlogo_image"
	echo $netlogo_command
	eval $netlogo_command

	analysis_command="docker run --rm -d -p 8787:8787 $analysis_volumes $analysis_image"
	echo $analysis_command
	eval $analysis_command
else
	echo Bad argument. Must be either \'build\', \'run\' or \'interact\'
	exit 1
fi

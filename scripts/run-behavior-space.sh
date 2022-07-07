#!/usr/bin/env bash

/opt/netlogo/netlogo-headless.sh \
  --model /code/src/wolf-sheep-predation.nlogo \
  --experiment vary_food_gains \
  --table /code/results/vary_food_gains.csv

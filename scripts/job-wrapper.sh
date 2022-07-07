#!/bin/bash

set -e

# the directory (in the container) where the computational model source code or executable can be called, e.g.,
# main.py | run.sh | julia-entrypoint.jl | model.R | netlogo-headless.sh
MODEL_CODE_DIRECTORY=${MODEL_CODE_DIRECTORY:-/code}

# executable to run on the entrypoint script, e.g., python | julia | netlogo-headless.sh | bash
ENTRYPOINT_SCRIPT_EXECUTABLE=${1:-/bin/bash}
# entrypoint script to run your model
ENTRYPOINT_SCRIPT=${2:-run.sh}
# directory where your model's results should be stored, relative to /srv/ in the singularity container
RESULTS_DIR=${3:-results}

export TMPDIR=$_CONDOR_SCRATCH_DIR

printf "Start time: "; /bin/date -Iminutes
printf "Job running on node: "; /bin/hostname
printf "OSG site: $OSG_SITE_NAME"
printf "Job running as user: "; /usr/bin/id
echo "Command line args: $@"
echo "Creating results dir at /srv/${RESULTS_DIR}"
printf "Running model code in ${MODEL_CODE_DIRECTORY} [${SCRIPT_EXECUTABLE} ${ENTRYPOINT_SCRIPT}]"

mkdir -p /srv/${RESULTS_DIR}

cd ${MODEL_CODE_DIRECTORY}

${ENTRYPOINT_SCRIPT_EXECUTABLE} ${ENTRYPOINT_SCRIPT} 2>&1

printf "${ENTRYPOINT_SCRIPT_EXECUTABLE} ${ENTRYPOINT_SCRIPT} execution completed: "; /bin/date -Iminutes

zip -r /srv/results.zip /srv/${RESULTS_DIR}

echo "Results archived in results.zip with exit code $?"

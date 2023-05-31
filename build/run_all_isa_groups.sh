#!/bin/bash

# script located IN: one folder above root folder of OpenPiton
# example: cd build && source run_all_isa_groups.sh
# Results will be saved in build/date_folder

FOLDER_NAME=$(date +%y%m%d_%H%M_%S)
RESULT_LOG=report_isa_groups.txt
SECONDS=0

echo "***** SETUP LAGARTO AS THE CORE *****"
cd ..
source piton/lagarto_setup.sh
source piton/lagarto_build_tools.sh

echo "***** RUNNING all ISA Group Tests, Results in ${FOLDER_NAME}/${RESULT_LOG}"
cd build
mkdir $FOLDER_NAME
cd $FOLDER_NAME

while IFS="" read -r p || [ -n "$p" ]
do
  printf '****************************\n'
  printf '    Running ISA GROUP: %s\n' "$p"
  printf '****************************\n'
  sims -group=$p -sim_type=msm > /dev/null 

  # Do the report of the latest modified folder
  regreport $(ls -td -- */ | head -n 1) -summary |tee -a $RESULT_LOG
  
  if grep -q 'REGRESSION FAILED' $RESULT_LOG
  then
    echo "Regression FAILED. Finish report"
    exit 1
  fi
done < ../isa_group_list.txt

echo "Elapsed Time: $SECONDS seconds"

# Perform the report once all sims are finished
#for d in */ ; do
#    regreport $d -summary >> ver_$RESULT_LOG
#done

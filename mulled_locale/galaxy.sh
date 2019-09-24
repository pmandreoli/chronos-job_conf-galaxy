#!/bin/bash



# The following block can be used by the job system
# to ensure this script is runnable before actually attempting
# to run it.
if [ -n "$ABC_TEST_JOB_SCRIPT_INTEGRITY_XYZ" ]; then
    exit 42
fi

GALAXY_SLOTS="2"; export GALAXY_SLOTS; GALAXY_SLOTS_CONFIGURED="1"; export GALAXY_SLOTS_CONFIGURED;
export GALAXY_SLOTS
PRESERVE_GALAXY_ENVIRONMENT="False"
GALAXY_LIB="/home/galaxy/galaxy/lib"
if [ "$GALAXY_LIB" != "None" -a "$PRESERVE_GALAXY_ENVIRONMENT" = "True" ]; then
    if [ -n "$PYTHONPATH" ]; then
        PYTHONPATH="$GALAXY_LIB:$PYTHONPATH"
    else
        PYTHONPATH="$GALAXY_LIB"
    fi
    export PYTHONPATH
fi

GALAXY_VIRTUAL_ENV="/home/galaxy/galaxy/.venv"
if [ "$GALAXY_VIRTUAL_ENV" != "None" -a -z "$VIRTUAL_ENV" \
     -a -f "$GALAXY_VIRTUAL_ENV/bin/activate" -a "$PRESERVE_GALAXY_ENVIRONMENT" = "True" ]; then
    . "$GALAXY_VIRTUAL_ENV/bin/activate"
fi
echo "$GALAXY_SLOTS" > '/export/job_work_dir/001/1519/__instrument_core_galaxy_slots' 
date +"%s" > /export/job_work_dir/001/1519/__instrument_core_epoch_start
cd /export/job_work_dir/001/1519
rm -rf working; mkdir -p working; cd working; sudo docker inspect biocontainers/fastqc:v0.11.5_cv3 > /dev/null 2>&1
[ $? -ne 0 ] && sudo docker pull biocontainers/fastqc:v0.11.5_cv3 > /dev/null 2>&1

sudo docker run -e '"GALAXY_SLOTS=$GALAXY_SLOTS"' -v /home/galaxy/galaxy:/home/galaxy/galaxy:rw -v /home/galaxy/shed_tools/toolshed.g2.bx.psu.edu/repos/devteam/fastqc/ff9530579d1f/fastqc:/home/galaxy/shed_tools/toolshed.g2.bx.psu.edu/repos/devteam/fastqc/ff9530579d1f/fastqc:rw -v /export/job_work_dir/001/1519:/export/job_work_dir/001/1519:rw -v /export/job_work_dir/001/1519/working:/export/job_work_dir/001/1519/working:rw -v /export/galaxy/database/files:/export/galaxy/database/files:rw -w /export/job_work_dir/001/1519/working --net none --rm -u root biocontainers/fastqc:v0.11.5_cv3 /export/job_work_dir/001/1519/tool_script.sh; return_code=$?; if [ -f /export/job_work_dir/001/1519/working/output.txt ] ; then cp /export/job_work_dir/001/1519/working/output.txt /export/galaxy/database/files/002/dataset_2761.dat ; fi; if [ -f /export/job_work_dir/001/1519/working/output.html ] ; then cp /export/job_work_dir/001/1519/working/output.html /export/galaxy/database/files/002/dataset_2760.dat ; fi; cd '/export/job_work_dir/001/1519'; 
if [ "$GALAXY_LIB" != "None" ]; then
    if [ -n "$PYTHONPATH" ]; then
        PYTHONPATH="$GALAXY_LIB:$PYTHONPATH"
    else
        PYTHONPATH="$GALAXY_LIB"
    fi
    export PYTHONPATH
fi
if [ "$GALAXY_VIRTUAL_ENV" != "None" -a -z "$VIRTUAL_ENV"      -a -f "$GALAXY_VIRTUAL_ENV/bin/activate" ]; then
    . "$GALAXY_VIRTUAL_ENV/bin/activate"
fi
GALAXY_PYTHON=`command -v python`
export PATH=$PATH:'/export/_conda/envs/__samtools@1.3.1/bin' ; python "/export/job_work_dir/001/1519/set_metadata_Euhw4I.py" "/export/job_work_dir/001/1519/registry.xml" "/export/job_work_dir/001/1519/working/galaxy.json" "/export/job_work_dir/001/1519/metadata_in_HistoryDatasetAssociation_2812_6IVff4,/export/job_work_dir/001/1519/metadata_kwds_HistoryDatasetAssociation_2812_rWMWOd,/export/job_work_dir/001/1519/metadata_out_HistoryDatasetAssociation_2812_BpWQYk,/export/job_work_dir/001/1519/metadata_results_HistoryDatasetAssociation_2812_8JnxDP,/export/galaxy/database/files/002/dataset_2761.dat,/export/job_work_dir/001/1519/metadata_override_HistoryDatasetAssociation_2812_ZEDDWE" "/export/job_work_dir/001/1519/metadata_in_HistoryDatasetAssociation_2811_04En67,/export/job_work_dir/001/1519/metadata_kwds_HistoryDatasetAssociation_2811_wSZPRj,/export/job_work_dir/001/1519/metadata_out_HistoryDatasetAssociation_2811_od9ppi,/export/job_work_dir/001/1519/metadata_results_HistoryDatasetAssociation_2811_k9AGjV,/export/galaxy/database/files/002/dataset_2760.dat,/export/job_work_dir/001/1519/metadata_override_HistoryDatasetAssociation_2811_CB_fPg" 5242880; sh -c "exit $return_code"
echo $? > /export/job_work_dir/001/1519/galaxy_1519.ec
date +"%s" > /export/job_work_dir/001/1519/__instrument_core_epoch_end

#!/bin/bash



_galaxy_setup_environment() {
    local _use_framework_galaxy="$1"
    if [ "$GALAXY_LIB" != "None" -a "$_use_framework_galaxy" = "True" ]; then
        if [ -n "$PYTHONPATH" ]; then
            PYTHONPATH="$GALAXY_LIB:$PYTHONPATH"
        else
            PYTHONPATH="$GALAXY_LIB"
        fi
        export PYTHONPATH
    fi
    _GALAXY_JOB_HOME_DIR="/export/galaxy/database/job_working_directory/000/231/home"
    _GALAXY_JOB_TMP_DIR=$([ ! -e '/export/galaxy/database/job_working_directory/000/231/tmp' ] || mv '/export/galaxy/database/job_working_directory/000/231/tmp' '/export/galaxy/database/job_working_directory/000/231'/tmp.$(date +%Y%m%d-%H%M%S) ; mkdir '/export/galaxy/database/job_working_directory/000/231/tmp'; echo '/export/galaxy/database/job_working_directory/000/231/tmp')
    
    # These don't get cleaned on a re-run but may in the future.
    [ -z "$_GALAXY_JOB_TMP_DIR" -a ! -f "$_GALAXY_JOB_TMP_DIR" ] || mkdir -p "$_GALAXY_JOB_TMP_DIR"
    [ -z "$_GALAXY_JOB_HOME_DIR" -a ! -f "$_GALAXY_JOB_HOME_DIR" ] || mkdir -p "$_GALAXY_JOB_HOME_DIR"
    if [ "$GALAXY_VIRTUAL_ENV" != "None" -a -f "$GALAXY_VIRTUAL_ENV/bin/activate" \
         -a "`command -v python`" != "$GALAXY_VIRTUAL_ENV/bin/python" ]; then
        . "$GALAXY_VIRTUAL_ENV/bin/activate"
    fi
}


# The following block can be used by the job system
# to ensure this script is runnable before actually attempting
# to run it.
if [ -n "$ABC_TEST_JOB_SCRIPT_INTEGRITY_XYZ" ]; then
    exit 42
fi

GALAXY_SLOTS="2"; export GALAXY_SLOTS; GALAXY_SLOTS_CONFIGURED="1"; export GALAXY_SLOTS_CONFIGURED;
export GALAXY_SLOTS
GALAXY_VIRTUAL_ENV="/home/galaxy/galaxy/.venv"
_GALAXY_VIRTUAL_ENV="/home/galaxy/galaxy/.venv"
PRESERVE_GALAXY_ENVIRONMENT="False"
GALAXY_LIB="/home/galaxy/galaxy/lib"
_galaxy_setup_environment "$PRESERVE_GALAXY_ENVIRONMENT"
GALAXY_PYTHON=`command -v python`
cd /export/galaxy/database/job_working_directory/000/231
if [ -n "$SLURM_JOB_ID" ]; then
    GALAXY_MEMORY_MB=`scontrol -do show job "$SLURM_JOB_ID" | sed 's/.*\( \|^\)Mem=\([0-9][0-9]*\)\( \|$\).*/\2/p;d'` 2>memory_statement.log
fi

if [ -z "$GALAXY_MEMORY_MB_PER_SLOT" -a -n "$GALAXY_MEMORY_MB" ]; then
    GALAXY_MEMORY_MB_PER_SLOT=$(($GALAXY_MEMORY_MB / $GALAXY_SLOTS))
elif [ -z "$GALAXY_MEMORY_MB" -a -n "$GALAXY_MEMORY_MB_PER_SLOT" ]; then
    GALAXY_MEMORY_MB=$(($GALAXY_MEMORY_MB_PER_SLOT * $GALAXY_SLOTS))
fi
[ "${GALAXY_MEMORY_MB--1}" -gt 0 ] 2>>memory_statement.log && export GALAXY_MEMORY_MB || unset GALAXY_MEMORY_MB
[ "${GALAXY_MEMORY_MB_PER_SLOT--1}" -gt 0 ] 2>>memory_statement.log && export GALAXY_MEMORY_MB_PER_SLOT || unset GALAXY_MEMORY_MB_PER_SLOT

echo "$GALAXY_SLOTS" > '/export/galaxy/database/job_working_directory/000/231/__instrument_core_galaxy_slots' 
echo "$GALAXY_MEMORY_MB" > '/export/galaxy/database/job_working_directory/000/231/__instrument_core_galaxy_memory_mb' 
date +"%s" > /export/galaxy/database/job_working_directory/000/231/__instrument_core_epoch_start
rm -rf working; mkdir -p working; cd working; sudo docker inspect quay.io/biocontainers/fastqc:0.11.6--2 > /dev/null 2>&1
[ $? -ne 0 ] && sudo docker pull quay.io/biocontainers/fastqc:0.11.6--2 > /dev/null 2>&1

sudo docker run -e "GALAXY_SLOTS=$GALAXY_SLOTS" -v /home/galaxy/galaxy:/home/galaxy/galaxy:ro -v /home/galaxy/shed_tools/toolshed.g2.bx.psu.edu/repos/devteam/fastqc/ff9530579d1f/fastqc:/home/galaxy/shed_tools/toolshed.g2.bx.psu.edu/repos/devteam/fastqc/ff9530579d1f/fastqc:rw -v /export/galaxy/database/job_working_directory/000/231:/export/galaxy/database/job_working_directory/000/231:rw -v /export/galaxy/database/job_working_directory/000/231/working:/export/galaxy/database/job_working_directory/000/231/working:rw -v /export/galaxy/database/files:/export/galaxy/database/files:rw -w /export/galaxy/database/job_working_directory/000/231/working --net none --rm --user 4001:4001 quay.io/biocontainers/fastqc:0.11.6--2 /export/galaxy/database/job_working_directory/000/231/tool_script.sh; return_code=$?; if [ -f /export/galaxy/database/job_working_directory/000/231/working/output.html ] ; then cp /export/galaxy/database/job_working_directory/000/231/working/output.html /export/galaxy/database/files/000/dataset_434.dat ; fi; if [ -f /export/galaxy/database/job_working_directory/000/231/working/output.txt ] ; then cp /export/galaxy/database/job_working_directory/000/231/working/output.txt /export/galaxy/database/files/000/dataset_435.dat ; fi; cd '/export/galaxy/database/job_working_directory/000/231'; 
[ "$GALAXY_VIRTUAL_ENV" = "None" ] && GALAXY_VIRTUAL_ENV="$_GALAXY_VIRTUAL_ENV"; _galaxy_setup_environment True
export PATH=$PATH:'/export/tool_deps/_conda/envs/__bcftools@1.5/bin' ; python "/export/galaxy/database/job_working_directory/000/231/set_metadata_3FPE7C.py" "/export/galaxy/database/job_working_directory/000/231/registry.xml" "/export/galaxy/database/job_working_directory/000/231/working/galaxy.json" "/export/galaxy/database/job_working_directory/000/231/metadata_in_HistoryDatasetAssociation_435_95iViR,/export/galaxy/database/job_working_directory/000/231/metadata_kwds_HistoryDatasetAssociation_435_iWCGIQ,/export/galaxy/database/job_working_directory/000/231/metadata_out_HistoryDatasetAssociation_435_xbhP69,/export/galaxy/database/job_working_directory/000/231/metadata_results_HistoryDatasetAssociation_435_FJLo8J,/export/galaxy/database/files/000/dataset_434.dat,/export/galaxy/database/job_working_directory/000/231/metadata_override_HistoryDatasetAssociation_435_LA5VPE" "/export/galaxy/database/job_working_directory/000/231/metadata_in_HistoryDatasetAssociation_436_DqCk0o,/export/galaxy/database/job_working_directory/000/231/metadata_kwds_HistoryDatasetAssociation_436_kJKqNz,/export/galaxy/database/job_working_directory/000/231/metadata_out_HistoryDatasetAssociation_436_7uYoNT,/export/galaxy/database/job_working_directory/000/231/metadata_results_HistoryDatasetAssociation_436_VbpGkI,/export/galaxy/database/files/000/dataset_435.dat,/export/galaxy/database/job_working_directory/000/231/metadata_override_HistoryDatasetAssociation_436_m8bXUh" 5242880; sh -c "exit $return_code"
echo $? > /export/galaxy/database/job_working_directory/000/231/galaxy_231.ec
date +"%s" > /export/galaxy/database/job_working_directory/000/231/__instrument_core_epoch_end

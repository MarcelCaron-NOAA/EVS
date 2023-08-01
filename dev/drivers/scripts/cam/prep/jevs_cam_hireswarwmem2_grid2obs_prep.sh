#PBS -S /bin/bash
#PBS -N jevs_cam_hireswarwmem2_grid2obs_prep
#PBS -j oe
#PBS -S /bin/bash
#PBS -q dev_transfer
#PBS -A EVS-DEV
#PBS -l walltime=1:00:00
#PBS -l select=1:ncpus=1:mem=5GB
#PBS -l debug=true
#PBS -V

set -x
export model=evs
module reset
export machine=WCOSS2

# ECF Settings
export RUN_ENVIR=nco
export SENDECF=YES
export SENDCOM=YES
export KEEPDATA=YES
export SENDDBN=YES
export SENDDBN_NTC=
export job=${PBS_JOBNAME:-jevs_cam_hireswarwmem2_grid2obs_prep}
export jobid=$job.${PBS_JOBID:-$$}
export SITE=$(cat /etc/cluster_name)
export USE_CFP=NO
export nproc=128

# General Verification Settings
export NET="evs"
export STEP="prep"
export COMPONENT="cam"
export RUN="atmos"
export VERIF_CASE="grid2obs"
export MODELNAME="hireswarwmem2"

# EVS Settings
export HOMEevs="/lfs/h2/emc/vpppg/noscrub/$USER/EVS"
export HOMEevs=${HOMEevs:-${PACKAGEROOT}/evs.${evs_ver}}
export config=$HOMEevs/parm/evs_config/cam/config.evs.prod.${STEP}.${COMPONENT}.${RUN}.${VERIF_CASE}.${MODELNAME}

# Load Modules
source $HOMEevs/versions/run.ver
source /usr/share/lmod/lmod/init/sh
module reset
source $HOMEevs/modulefiles/$COMPONENT/${COMPONENT}_${STEP}.sh
export MET_PLUS_PATH="/apps/ops/para/libs/intel/${intel_ver}/metplus/${metplus_ver}"
export MET_PATH="/apps/ops/para/libs/intel/${intel_ver}/met/${met_ver}"
export MET_CONFIG="${MET_PLUS_PATH}/parm/met_config"
export PYTHONPATH=$HOMEevs/ush/$COMPONENT:$PYTHONPATH

# Developer Settings
export DATA=/lfs/h2/emc/stmp/$USER/evs_test/$envir/tmp/${jobid:?}
export COMOUT=/lfs/h2/emc/vpppg/noscrub/${USER}/$NET/$evs_ver/$STEP/$COMPONENT
export FIXevs="/lfs/h2/emc/vpppg/noscrub/emc.vpppg/verification/EVS_fix"
export cyc=$(date -d "today" +"%H")
export mPINGToken="9dd1b109ab13bc9454d14d5bf631398d88fec93d"

# Job Settings and Run
. ${HOMEevs}/jobs/cam/prep/JEVS_CAM_PREP
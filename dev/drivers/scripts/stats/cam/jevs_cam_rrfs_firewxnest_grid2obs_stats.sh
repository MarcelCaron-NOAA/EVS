#PBS -N jevs_cam_rrfs_firewxnest_grid2obs_stats
#PBS -j oe
#PBS -S /bin/bash
#PBS -q "dev"
#PBS -A VERF-DEV
#PBS -l walltime=02:00:00
#PBS -l place=shared,select=1:ncpus=1:mem=2GB
#PBS -l debug=true

export model=evs

cd $PBS_O_WORKDIR

export HOMEevs=/lfs/h2/emc/vpppg/save/$USER/EVS_rrfs/para/EVS

source $HOMEevs/versions/run.ver

############################################################
# Load modules
############################################################
set -x

module reset
module load prod_envir/${prod_envir_ver}

export envir=prod
export DATAROOT=/lfs/h2/emc/stmp/${USER}/evs_test/$envir/tmp
export KEEPDATA=YES
export SENDMAIL=NO

export vhr
export NET=evs
export STEP=stats
export COMPONENT=cam
export RUN=atmos
export VERIF_CASE=grid2obs
export MODELNAME=rrfs_firewxnest
export modsys=rrfs
export mod_ver=${rrfs_ver}

source $HOMEevs/dev/modulefiles/$COMPONENT/${COMPONENT}_${STEP}.sh
evs_ver_2d=$(echo $evs_ver | cut -d'.' -f1-2)

export job=${PBS_JOBNAME:-jevs_${MODELNAME}_${VERIF_CASE}_${STEP}}
export jobid=$job.${PBS_JOBID:-$$}

export COMIN=/lfs/h2/emc/vpppg/noscrub/$USER/${NET}_retro${retro_num}/$evs_ver_2d
export COMOUT=/lfs/h2/emc/vpppg/noscrub/$USER/${NET}_retro${retro_num}/$evs_ver_2d/$STEP/$COMPONENT
export RETRO_BEG=${RETRO_BEG:-${RETRO_BEG}}
export RETRO_END=${RETRO_END:-${RETRO_END}}
export retro_num=${retro_num:-${retro_num}}

export MAILTO=${MAILTO:-'marcel.caron@noaa.gov'}

# CALL executable job script here
$HOMEevs/jobs/JEVS_CAM_STATS

######################################################################
## Purpose: This job will generate the grid2obs statistics for the RRFS_FIREWXNEST
##          model and generate stat files.
#######################################################################
#
exit


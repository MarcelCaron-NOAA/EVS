#PBS -N jevs_cam_severe_plots_00
#PBS -j oe
#PBS -S /bin/bash
#PBS -q dev
#PBS -A VERF-DEV
#PBS -l walltime=0:45:00
#PBS -l place=vscatter:exclhost,select=1:ncpus=64
#PBS -l debug=true
#PBS -V


set -x

cd $PBS_O_WORKDIR


############################################################
# Load modules
############################################################


export model=evs
export NET=evs
export COMPONENT=cam
export STEP=plots
export RUN=atmos

export HOMEevs=/lfs/h2/emc/vpppg/save/$USER/EVS_rrfs/retro/EVS
source $HOMEevs/versions/run.ver
module reset
module load prod_envir/${prod_envir_ver}

source $HOMEevs/dev/modulefiles/$COMPONENT/${COMPONENT}_${STEP}.sh
export evs_ver_2d=$(echo $evs_ver | cut -d'.' -f1-2)

############################################################
# For dev testing
############################################################
export envir=prod
export DATAROOT=/lfs/h2/emc/stmp/${USER}/evs_test/$envir/tmp
export KEEPDATA=YES
export VERIF_CASE=severe
export MODELNAME=${COMPONENT}
export job=${PBS_JOBNAME:-jevs_${MODELNAME}_${VERIF_CASE}_${LINE_TYPE}_${STEP}}
export jobid=$job.${PBS_JOBID:-$$}
export COMIN=/lfs/h2/emc/vpppg/noscrub/emc.vpppg/$NET/$evs_ver_2d
export COMOUT=/lfs/h2/emc/vpppg/noscrub/${USER}/${NET}_retro${retro_num}/$evs_ver_2d/$STEP/$COMPONENT
export nproc=64
export RETRO_BEG=${RETRO_BEG:-${RETRO_BEG}}
export RETRO_END=${RETRO_END:-${RETRO_END}}
export retro_num=${retro_num:-${retro_num}}
############################################################

export vhr=${vhr:-${vhr}}
export EVAL_PERIOD=${EVAL_PERIOD:-${EVAL_PERIOD}}
export LINE_TYPE=${LINE_TYPE:-${LINE_TYPE}}

export SENDMAIL=${SENDMAIL:-NO}
export SENDCOM=${SENDCOM:-YES}
export SENDECF=${SENDECF:-YES}
export SENDDBN=${SENDDBN:-NO}
export KEEPDATA=${KEEPDATA:-NO}

export MAILTO=${MAILTO:-'marcel.caron@noaa.gov,alicia.bentley@noaa.gov'}

if [ -z "$MAILTO" ]; then

   echo "MAILTO variable is not defined. Exiting without continuing."

else

   # CALL executable job script here
   $HOMEevs/jobs/JEVS_CAM_PLOTS

fi


######################################################################
# Purpose: This job generates severe verification graphics
#          for the CAM component (deterministic and ensemble CAMs)
######################################################################


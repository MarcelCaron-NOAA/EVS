#PBS -N jevs_cam_hireswfv3_radar_stats
#PBS -j oe
#PBS -S /bin/bash
#PBS -q dev
#PBS -A VERF-DEV
#PBS -l walltime=0:30:00
#PBS -l place=vscatter:exclhost,select=1:ncpus=3:mem=500GB
#PBS -l debug=true
#PBS -V


set -x

cd $PBS_O_WORKDIR


############################################################
# Load modules
############################################################


export OMP_NUM_THREADS=1
export model=evs
export NET=evs
export STEP=stats
export COMPONENT=cam
export RUN=atmos

export HOMEevs=/lfs/h2/emc/vpppg/save/$USER/EVS_rrfs/retro/EVS
source $HOMEevs/versions/run.ver
module reset
module load prod_envir/${prod_envir_ver}

source $HOMEevs/dev/modulefiles/$COMPONENT/${COMPONENT}_${STEP}.sh
evs_ver_2d=$(echo $evs_ver | cut -d'.' -f1-2)

export vhr=${vhr:-${vhr}}


############################################################
# For dev testing
############################################################
export envir=prod
export DATAROOT=/lfs/h2/emc/stmp/${USER}/evs_test/$envir/tmp
export KEEPDATA=YES
export VERIF_CASE=radar
export MODELNAME=hireswfv3
export modsys=hiresw
export job=${PBS_JOBNAME:-jevs_${COMPONENT}_${MODELNAME}_${VERIF_CASE}_${STEP}_${vhr}}
export jobid=$job.${PBS_JOBID:-$$}
export COMIN=/lfs/h2/emc/vpppg/noscrub/$USER/${NET}_retro${retro_num}/$evs_ver_2d
export COMOUT=/lfs/h2/emc/vpppg/noscrub/$USER/${NET}_retro${retro_num}/$evs_ver_2d/$STEP/$COMPONENT
export USE_CFP=YES
export nproc=3
export RETRO_BEG=${RETRO_BEG:-${RETRO_BEG}}
export RETRO_END=${RETRO_END:-${RETRO_END}}
export retro_num=${retro_num:-${retro_num}}
############################################################

export SENDMAIL=${SENDMAIL:-NO}
export SENDCOM=${SENDCOM:-YES}
export SENDECF=${SENDECF:-YES}
export SENDDBN=${SENDDBN:-NO}
export KEEPDATA=${KEEPDATA:-NO}

export MAILTO=${MAILTO:-'marcel.caron@noaa.gov'}

if [ -z "$MAILTO" ]; then

   echo "MAILTO variable is not defined. Exiting without continuing."

else

   # CALL executable job script here
   $HOMEevs/jobs/JEVS_CAM_STATS

fi


######################################################################
# Purpose: This job generates radar verification statistics
#          for the HiResW FV3
######################################################################


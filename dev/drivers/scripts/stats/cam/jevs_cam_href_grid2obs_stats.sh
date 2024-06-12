#PBS -N jevs_cam_href_grid2obs_stats
#PBS -j oe
#PBS -q dev
#PBS -S /bin/bash
#PBS -A VERF-DEV
#PBS -l walltime=04:30:00
#PBS -l place=vscatter:exclhost,select=1:ncpus=72:mem=500GB
#PBS -l debug=true

set -x 

export OMP_NUM_THREADS=1

export HOMEevs=/lfs/h2/emc/vpppg/save/$USER/EVS_rrfs/retro/EVS
source $HOMEevs/versions/run.ver

export NET=evs
export STEP=stats
export COMPONENT=cam
export RUN=atmos
export VERIF_CASE=grid2obs
export MODELNAME=href
export KEEPDATA=YES
export SENDMAIL=NO

module reset
module load prod_envir/${prod_envir_ver}
source $HOMEevs/dev/modulefiles/$COMPONENT/${COMPONENT}_${STEP}.sh
evs_ver_2d=$(echo $evs_ver | cut -d'.' -f1-2)

export vhr=00

export run_mpi=yes
export gather=yes


export COMIN=/lfs/h2/emc/vpppg/noscrub/$USER/${NET}_retro${retro_num}/$evs_ver_2d
export COMOUT=/lfs/h2/emc/vpppg/noscrub/$USER/${NET}_retro${retro_num}/$evs_ver_2d/$STEP/$COMPONENT
export envir=prod
export DATAROOT=/lfs/h2/emc/stmp/${USER}/evs_test/$envir/tmp
export job=${PBS_JOBNAME:-jevs_${MODELNAME}_${VERIF_CASE}_${STEP}}
export jobid=$job.${PBS_JOBID:-$$}
export RETRO_BEG=${RETRO_BEG:-${RETRO_BEG}}
export RETRO_END=${RETRO_END:-${RETRO_END}}
export retro_num=${retro_num:-${retro_num}}

export MAILTO='binbin.zhou@noaa.gov'
if [ -z "$MAILTO" ]; then

   echo "MAILTO variable is not defined. Exiting without continuing."

else

 ${HOMEevs}/jobs/JEVS_CAM_STATS

fi

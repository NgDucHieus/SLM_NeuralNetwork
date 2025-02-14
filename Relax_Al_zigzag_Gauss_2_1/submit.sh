# Set job parameters

# Queue
#BSUB -q medium_priority

#Job Name
#BSUB -J LAMMPS

# Output and Input Errors
#BSUB -o job%J.out
#BSUB -e job%J.err

# Specify walltime in HH:MM
#BSUB -W 20:00

# 16 Processors per Host
#BSUB -R "span[ptile=16]"

# Requesting for 32 cores
#BSUB -n 16

# Email yourself
#BSUB -u xxx@ntu.edu.sg

# Need to make our own machinefile
MACHINEFILE=mymacs.$LSB_JOBID
for i in `echo $LSB_HOSTS`
do
echo $i
done > $MACHINEFILE

# load module enviroement
module load gcc/4.8.4
module load openmpi-1.6.4-gnu

inputfile=myfile_kim.in

# Run mpi program
/usr/local/RH6_apps/openmpi-1.6.4-gnu/bin/mpirun -np 16 --mca orte_base_help_aggregate 0  -machinefile $MACHINEFILE /usr/local/RH6_apps/liggghts-15Feb2016/bin/liggghts < $inputfile > myfile_kim.out

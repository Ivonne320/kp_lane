#!/bin/bash
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 10
#SBATCH --mem 48G
#SBATCH --partition gpu
#SBATCH --gres gpu:1
#SBATCH --time 10:00:00
#SBATCH --account=vita
#SBATCH --mail-user=yihan.wang@epfl.ch 
#SBATCH --mail-type=ALL
#SBATCH --output=/work/vita/yiwang/predictions/culane/swinb-120e.out



echo STARTING


find /work/vita/datasets/CULane/test/ -path '***/**/*.jpg' | xargs -n 8 -P 8 python3 -m openpifpaf.predict --checkpoint /work/vita/yiwang/outputs/culane/basenet/swin_b_00003/swin_b.epoch120 \
--debug-indices cif:0 caf:0 \
--loader-workers=8 --force-complete-pose --instance-threshold=0.15 \
--batch-size=16 \
--long-edge=621 \
--json-output=/work/vita/yiwang/predictions/culane/swin_b/120/\




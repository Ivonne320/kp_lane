#!/bin/bash
#SBATCH --nodes 1
#SBATCH --ntasks 2
#SBATCH --cpus-per-task 10
#SBATCH --mem 128G
#SBATCH --partition gpu
#SBATCH --gres gpu:2
#SBATCH --time 3-00:00:00
#SBATCH --account=vita
#SBATCH --output=/work/vita/yiwang/outputs/culane/basenet/newexp/slurm-swin-1.out




echo "STARTING AT NODE $SLURM_NODEID, 48kps, cocosame resumption"
export MASTER_ADDR=127.0.0.1
export MASTER_PORT=29500
export CUDA_VISIBLE_DEVICES=0,1
srun python3 -u -m openpifpaf.train --ddp --lr=0.00003 --momentum=0.95 --b-scale=10.0 --clip-grad-value=10 --epochs=250   --batch-size=16 --weight-decay=1e-5 --dataset=culane --culane-upsample=2 --checkpoint=/work/vita/yiwang/outputs/culane/basenet/newexp/M-00003-scale/shufflenetv2k30-240625-001426-culane_scale-slurm2114116.pkl.epoch030 --culanescale-orientation-invariant=0.1 --culane-extended-scale --culane-train-annotations /home/yiwang/CIVIL-459-Project/data_culane/annotations/culane_keypoints_training.json --culane-val-annotations /home/yiwang/CIVIL-459-Project/data_culane/annotations/culane_keypoints_validation.json --culane-train-image-dir /work/vita/datasets/CULane/training/ --culane-val-image-dir /work/vita/datasets/CULane/validation/  --output /work/vita/yiwang/outputs/culane/basenet/newexp/M-00003-scale/e-5/ "$@"


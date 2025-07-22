#!/bin/bash
#SBATCH --job-name=hdt_ppo
#SBATCH --nodes=1
#SBATCH --gpus-per-node=4      # 每节点 1 GPU
#SBATCH --ntasks-per-node=4    # 与 --gpus-per-node 保持一致
#SBATCH --exclude=dgx-34
#SBATCH --time=04:00:00
#SBATCH --account=msccsit2024
#SBATCH --partition=normal
#SBATCH --container-writable
#SBATCH --container-image /home/zyangdm/nv_image_llama
#SBATCH --container-save /home/zyangdm/nv_image_llama

cd /home/zyangdm/LLaMA-Factory
export WANDB_API_KEY=dce12064d30900b2cc538f73e82997de5aafbb96
llamafactory-cli train examples/train_lora/qwen3_lora_ppo.yaml 
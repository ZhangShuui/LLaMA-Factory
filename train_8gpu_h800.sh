#!/bin/bash
#SBATCH --job-name=hdt_ppo
#SBATCH --nodes=1
#SBATCH --gpus-per-node=8      # 每节点 1 GPU
#SBATCH --ntasks-per-node=8    # 与 --gpus-per-node 保持一致
#SBATCH --exclude=dgx-34
#SBATCH --time=04:00:00
#SBATCH --account=msccsit2024
#SBATCH --partition=normal
#SBATCH --container-writable
#SBATCH --container-image /home/zyangdm/nv_image_llama
#SBATCH --container-save /home/zyangdm/nv_image_llama

cd /home/zyangdm/LLaMA-Factory
export WANDB_API_KEY=dce12064d30900b2cc538f73e82997de5aafbb96
export CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7
export NCCL_DEBUG=INFO
export NCCL_IB_DISABLE=0
export NCCL_SOCKET_IFNAME=eth0
export NCCL_P2P_DISABLE=0

# H800优化环境变量
export CUDA_LAUNCH_BLOCKING=0
export TORCH_CUDNN_V8_API_ENABLED=1
export CUDA_DEVICE_MAX_CONNECTIONS=1

# 内存优化
export PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:512

llamafactory-cli train examples/train_lora/qwen3_lora_ppo_8gpu_h800_aggressive.yaml

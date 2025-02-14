#!/bin/bash

deepspeed --master_port 29600 llava_phi/train/train.py \
    --deepspeed ./scripts/zero2.json \
    --model_name_or_path zxmonent/llava-phi \
    --version v0 \
    --data_path /shared-network/CLEVR_v1.0 \
    --image_folder /path/to/llava-finetune/data \
    --tune_mm_mlp_adapter True \
    --lora_enable True \
    --lora_r 128 \
    --lora_alpha 256 \
    --freeze_vision_tower False \
    --freeze_backbone False \
    --mm_use_im_start_end False \
    --mm_use_im_patch_token False \
    --image_aspect_ratio pad \
    --group_by_modality_length True \
    --fp16 True \
    --output_dir ./checkpoints/llavaPhi-v0-3b-finetune \
    --num_train_epochs 2 \
    --per_device_train_batch_size 1 \
    --per_device_eval_batch_size 1 \
    --gradient_accumulation_steps 1 \
    --evaluation_strategy "no" \
    --save_strategy "steps" \
    --save_steps 1000 \
    --save_total_limit 1 \
    --learning_rate 2e-5 \
    --weight_decay 0. \
    --warmup_ratio 0.03 \
    --lr_scheduler_type "cosine" \
    --logging_steps 1 \
    --tf32 True \
    --model_max_length 2048 \
    --gradient_checkpointing True \
    --dataloader_num_workers 1 \
    --lazy_preprocess True \
    --report_to wandb

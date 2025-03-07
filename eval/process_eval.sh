#!/bin/bash
# use gsm8k to find best thesholds
python processbench.py \
  --mode inference \
  --input_file ./data/gsm8k.json \
  --output_file ./results/gsm8k_rewards.json \
  --model_path ./EurusPRM-Stage2 \
  --ref_model_path ./Qwen2.5-7B-Instruct \
  --tokenizer_path ./EurusPRM-Stage2 \
  --batch_size 8 \
  --coef 0.005 \
  --best_threshold None

python processbench.py \
  --mode evaluate \
  --input_file ./results/gsm8k_rewards.json \
  --output_file ./results/gsm8k_threshold.txt \
  --num_thresholds 10000 \
  --best_threshold None 

# use best_thresholds for other dataset
python processbench.py \
  --mode inference \
  --input_file ./data/new_dataset.json \
  --output_file ./results/new_rewards.json \
  --model_path ./EurusPRM-Stage2 \
  --ref_model_path ./Qwen2.5-7B-Instruct \
  --tokenizer_path ./EurusPRM-Stage2 \
  --batch_size 8 \
  --coef 0.005 \
  --best_threshold None

python processbench.py \
  --mode evaluate \
  --input_file ./results/new_rewards.json \
  --output_file ./results/new_threshold.txt \
  --num_thresholds 10000 \
  --best_threshold 0.5005

#!/bin/bash

set -e

python ./compute_bn_statistics.py \
--out_dir=/home/nathan/mzmo/analysis/nuclear_seg \
--train_model=/home/nathan/caffe-segnet-crf/notebooks/train-SegNet-CRFRNN.prototxt \
--weights=/home/nathan/mzmo/analysis/nuclear_seg/segcrfrnn_resume_raw_iter_854.caffemodel \
--out_name=segcrfrnn_resume_norm_iter_854.caffemodel
#!/bin/bash

set -e

cf=/home/nathan/caffe-segnet-crf/build/tools

$cf/caffe train \
--solver ./models/solver-SegNet.prototxt


$cf/caffe train \
--solver ./models/solver-SegNet-CRFRNN.prototxt \
--weights /home/nathan/histo-seg/semantic-ccrcc/weights/segnet-crfrnn/segnet_iter_25000.caffemodel

# python ./compute_bn_statistics.py \
# --out_dir=/Users/nathaning/databases/nuclei/ \
# --train_model=./models/train-SegNet-CRFRNN.prototxt \
# --weights=/Users/nathaning/histo-seg/semantic-ccrcc/segnet-crfrnn/crfrnn_iter_15000.caffemodel \
# --out_name=norm_segnet_iter_15000.caffemodel
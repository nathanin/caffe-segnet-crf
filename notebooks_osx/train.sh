#!/bin/bash

set -e

cf=/Users/nathaning/software/caffe-segnet-crf/build/tools

$cf/caffe train \
--solver ./models/solver-SegNet.prototxt

# python ./compute_bn_statistics.py \
# --out_dir=/Users/nathaning/databases/nuclei/ \
# --train_model=./models/train-segnet-small-128x128.prototxt \
# --weights=/Users/nathaning/databases/nuclei/segnet_iter_15000.caffemodel \
# --out_name=norm_segnet_iter_15000.caffemodel

$cf/caffe train \
--solver ./models/solver-SegNet-CRFRNN.prototxt \
--weights /Users/nathaning/databases/pca/segnet_iter_36000.caffemodel
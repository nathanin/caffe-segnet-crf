#!/bin/bash

set -e

cf=/home/nathan/caffe-segnet-crf/build/tools

$cf/caffe train \
--solver ./solver-SegNet-CRFRNN.prototxt \
# --weights /home/nathan/histo-seg/semantic-pca/weights/seg_0.8.1/raw_iter_50000.caffemodel
#!/bin/bash

set -e

# cf=/Users/nathaning/software/caffe-segnet-crf/build/tools
cf=/home/nathan/caffe-segnet-crf/build/tools
# cf=/home/nathan/caffe-segnet-cudnn5/build/tools

$cf/caffe train \
--solver ./solver-SegNet-CRFRNN.prototxt \
--weights /home/nathan/mzmo/analysis/nuclear_seg/weights/crfrnn_iter_16783.caffemodel

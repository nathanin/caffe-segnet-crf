#!/bin/bash

set -e

# cf=/Users/nathaning/software/caffe-segnet-crf/build/tools
cf=/home/nathan/caffe-segnet-crf/build/tools
# cf=/home/nathan/caffe-segnet-cudnn5/build/tools

$cf/caffe train \
--solver ./solver-SegNet.prototxt


$cf/caffe train \
--solver ./solver-SegNet-CRFRNN.prototxt \
--weights /home/nathan/mzmo/analysis/nuclear_seg/weights/segnet_iter_25000.caffemodel
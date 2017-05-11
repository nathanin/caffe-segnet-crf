#!/bin/bash

set -e

cf=/home/nathan/caffe-segnet-crf/build/tools

$cf/caffe train \
--solver ./solver-SegNet-CRFRNN.prototxt \
--weights /home/nathan/mzmo/analysis/nuclear_seg/segcrfrnn_raw_iter_10000.caffemodel
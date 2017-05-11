#!/bin/bash

set -e

cf=/Users/nathaning/software/caffe-segnet-crf/build/tools

$cf/caffe train \
--solver ./solver-SegNet-CRFRNN.prototxt \
<<<<<<< HEAD
# --weights /home/nathan/histo-seg/semantic-pca/weights/seg_0.8.1/raw_iter_50000.caffemodel
=======
# --weights /home/nathan/mzmo/analysis/nuclear_seg/segcrfrnn_raw_iter_10000.caffemodel
>>>>>>> 1f46a6b198582f04879baafd9fc95b975a800a98

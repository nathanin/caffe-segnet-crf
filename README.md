# Caffe SegNet and CRFasRNN merger

### Notes
Personal work in progress. 

System information:
**Ubuntu 16.04:**
'''
$ g++ --version

$ make --version

$ nvcc --version

$ cat /usr/local/cuda/include/cudnn.h | grep CUDNN_MAJOR -A 2

'''

**OS X 10.11.5:**
'''
$ g++ --version

$ make --version

$ nvcc --version

$ cat /usr/local/cuda/include/cudnn.h | grep CUDNN_MAJOR -A 2

'''

Caffe-SegNet contributes the upsample layer, and dense image data layer. CRFasRNN contributes Meanfield layer which implements Conditional Random Fields according to their paper (below). I used `make` to compile. `CMake` lists have yet to be updated. The tests (except noted) pass and I obtain resonable results with the demonstration CRFasRNN model. 

**Note that `make runtest` fails the Meanfield layer gradient checker. I observed intractably long execution time in GPU mode, and many, many fails in CPU mode.**

--- 
# Caffe-Segnet
**Original by Alex Kendall (https://github.com/alexgkendall/caffe-segnet), with updated GPU implementation by Timo-Saemann:**
[Caffe SegNet cuDNN5](https://github.com/TimoSaemann/caffe-segnet-cudnn5) is is a modified version of [Caffe](https://github.com/BVLC/caffe) which supports the [SegNet architecture](http://mi.eng.cam.ac.uk/projects/segnet/)

As described in **SegNet: A Deep Convolutional Encoder-Decoder Architecture for Image Segmentation** Vijay Badrinarayanan, Alex Kendall and Roberto Cipolla [http://arxiv.org/abs/1511.00561]

Please refer to Alex Kendalls caffe-segnet for a tutorial and a guide how to use it (https://github.com/alexgkendall/caffe-segnet).

# CRF-RNN for Semantic Image Segmentation
This package contains code for the "CRF-RNN" semantic image segmentation method, published in the ICCV 2015 paper [Conditional Random Fields as Recurrent Neural Networks](http://www.robots.ox.ac.uk/~szheng/papers/CRFasRNN.pdf). This paper was initially described in an [arXiv tech report](http://arxiv.org/abs/1502.03240). The online demonstration based on this code won the Best Demo Prize at ICCV 2015. Our software is built on top of the [Caffe](http://caffe.berkeleyvision.org/) deep learning library. The current version was developed by:

[Sadeep Jayasumana](http://www.robots.ox.ac.uk/~sadeep/),
[Shuai Zheng](http://kylezheng.org/),
[Bernardino Romera Paredes](http://romera-paredes.com/), 
[Anurag Arnab](http://www.robots.ox.ac.uk/~aarnab/),
and
Zhizhong Su.

Supervisor: [Philip Torr](http://www.robots.ox.ac.uk/~tvg/)


## How to use the CRF-RNN layer
CRF-RNN has been developed as a custom Caffe layer named MultiStageMeanfieldLayer. Usage of this layer in the model definition prototxt file looks the following. Check the matlab-scripts or the python-scripts folder for more detailed examples.
```
# This is part of FCN, coarse is a blob coming from FCN
layer { type: 'Crop' name: 'crop' bottom: 'bigscore' bottom: 'data' top: 'coarse' }

# This layer is used to split the output of FCN into two. This is required by CRF-RNN.
layer { type: 'Split' name: 'splitting'
  bottom: 'coarse' top: 'unary' top: 'Q0'
}

layer {
  name: "inference1" # Keep the name "inference1" to load the trained parameters from our caffemodel.
  type: "MultiStageMeanfield" # Type of this layer
  bottom: "unary" # Unary input from FCN
  bottom: "Q0" # A copy of the unary input from FCN
  bottom: "data" # Input image
  top: "pred" # Output of CRF-RNN
  param {
    lr_mult: 10000 # learning rate for W_G
  }
  param {
    lr_mult: 10000 # learning rate for W_B
  }
  param {
    lr_mult: 1000 # learning rate for compatiblity transform matrix
  }
  multi_stage_meanfield_param {
    num_iterations: 10 # Number of iterations for CRF-RNN
    compatibility_mode: POTTS # Initialize the compatilibity transform matrix with a matrix whose diagonal is -1.
    threshold: 2
    theta_alpha: 160
    theta_beta: 3
    theta_gamma: 3
    spatial_filter_weight: 3
    bilateral_filter_weight: 5
  }
}
```


Caffe is a deep learning framework made with expression, speed, and modularity in mind.
It is developed by Berkeley AI Research ([BAIR](http://bair.berkeley.edu))/The Berkeley Vision and Learning Center (BVLC) and community contributors.

## Publications

If you use this software in your research, please cite their publications:

http://arxiv.org/abs/1511.02680
Alex Kendall, Vijay Badrinarayanan and Roberto Cipolla "Bayesian SegNet: Model Uncertainty in Deep Convolutional Encoder-Decoder Architectures for Scene Understanding." arXiv preprint arXiv:1511.02680, 2015.

```
@inproceedings{crfasrnn_ICCV2015,
    author = {Shuai Zheng and Sadeep Jayasumana and Bernardino Romera-Paredes and Vibhav Vineet and
    Zhizhong Su and Dalong Du and Chang Huang and Philip H. S. Torr},
    title  = {Conditional Random Fields as Recurrent Neural Networks},
    booktitle = {International Conference on Computer Vision (ICCV)},
    year   = {2015}
}
```
```
@inproceedings{higherordercrf_ECCV2016,
    author = {Anurag Arnab and Sadeep Jayasumana and Shuai Zheng and Philip H. S. Torr},
    title  = {Higher Order Conditional Random Fields in Deep Neural Networks},
    booktitle = {European Conference on Computer Vision (ECCV)},
    year   = {2016}
}
```


## License

This extension to the Caffe library is released under a creative commons license which allows for personal and research use only. For a commercial license please contact the authors. You can view a license summary here:
http://creativecommons.org/licenses/by-nc/4.0/

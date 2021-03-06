# Caffe SegNet and CRFasRNN merger

### Notes
Work in progress. This development is for research purposes only. See publications of the original authors below.

#### What I did:
Next to nothing; I combined two great `caffe` branches into one and updated one layer to use cuDNN 5.1; I exposed the solver update operation in pycaffe.


System information:
**Ubuntu 16.04:**
```
$ g++ --version
g++ (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609

$ make --version
GNU Make 4.1
Built for x86_64-pc-linux-gnu

$ nvcc --version
nvcc: NVIDIA (R) Cuda compiler driver
Copyright (c) 2005-2016 NVIDIA Corporation
Built on Tue_Jan_10_13:22:03_CST_2017
Cuda compilation tools, release 8.0, V8.0.61

$ cat /usr/local/cuda/include/cudnn.h | grep CUDNN_MAJOR -A 2
#define CUDNN_MAJOR      5
#define CUDNN_MINOR      1
#define CUDNN_PATCHLEVEL 5
--
#define CUDNN_VERSION    (CUDNN_MAJOR * 1000 + CUDNN_MINOR * 100 + CUDNN_PATCHLEVEL)

```

**OS X 10.11.5:**
```
$ g++ --version

$ make --version

$ nvcc --version

$ cat /usr/local/cuda/include/cudnn.h | grep CUDNN_MAJOR -A 2

```

Pycaffe imporvement to reveal the SGDSolver's ApplyUpdate() function. The forward-backward-update pass can be called like:

```
solver.net.forward()  
solver.net.backward()  # Calculate diff
solver.update()  # change the weights
```

Caffe-SegNet contributes the upsample layer, batch normalization, and dense image data layer. CRFasRNN contributes Meanfield layer which implements Conditional Random Fields according to their paper (below). I used `make` to compile. `CMake` lists have yet to be updated. All I did was clone SegNet from TimoSaemann's repo (below), and pull in CRFasRNN most up-to-date branch with the factored out layer headers. I have rewritten the original `DenseImageData` layer to work with the updated layer read/write functions. The tests (except noted) pass and I obtain resonable results with the demonstration CRFasRNN model. 


**Note that `make runtest` fails the Meanfield layer gradient checker. I observed intractably long execution time in GPU mode, and many, many fails in CPU mode.**

--- 
# Caffe-Segnet
**Original by Alex Kendall with updated GPU implementation by Timo-Saemann:**
[Caffe SegNet cuDNN5](https://github.com/TimoSaemann/caffe-segnet-cudnn5) is a modified version of [Caffe](https://github.com/BVLC/caffe) which supports the [SegNet architecture](http://mi.eng.cam.ac.uk/projects/segnet/)

As described in **SegNet: A Deep Convolutional Encoder-Decoder Architecture for Image Segmentation** Vijay Badrinarayanan, Alex Kendall and Roberto Cipolla [http://arxiv.org/abs/1511.00561]

Please refer to Alex Kendalls caffe-segnet for a tutorial and a guide how to use it (https://github.com/alexgkendall/caffe-segnet).

# CRF-RNN for Semantic Image Segmentation
[This package](https://github.com/torrvision/crfasrnn/) contains code for the "CRF-RNN" semantic image segmentation method, published in the ICCV 2015 paper [Conditional Random Fields as Recurrent Neural Networks](http://www.robots.ox.ac.uk/~szheng/papers/CRFasRNN.pdf). This paper was initially described in an [arXiv tech report](http://arxiv.org/abs/1502.03240). The online demonstration based on this code won the Best Demo Prize at ICCV 2015. Our software is built on top of the [Caffe](http://caffe.berkeleyvision.org/) deep learning library. The current version was developed by:

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

@inproceedings{higherordercrf_ECCV2016,
  author = {Anurag Arnab and Sadeep Jayasumana and Shuai Zheng and Philip H. S. Torr},
  title  = {Higher Order Conditional Random Fields in Deep Neural Networks},
  booktitle = {European Conference on Computer Vision (ECCV)},
  year   = {2016}
}

@article{jia2014caffe,
  Author = {Jia, Yangqing and Shelhamer, Evan and Donahue, Jeff and Karayev, Sergey and Long, Jonathan and Girshick, Ross and Guadarrama, Sergio and Darrell, Trevor},
  Journal = {arXiv preprint arXiv:1408.5093},
  Title = {Caffe: Convolutional Architecture for Fast Feature Embedding},
  Year = {2014}
}
```

##???
## Caffe SegNet License
This extension to the Caffe library is released under a creative commons license which allows for personal and research use only. For a commercial license please contact the authors. You can view a license summary here:
http://creativecommons.org/licenses/by-nc/4.0/

## Original Caffe License
Caffe is released under the [BSD 2-Clause license](https://github.com/BVLC/caffe/blob/master/LICENSE).
The BAIR/BVLC reference models are released for unrestricted use.

## Contact
Please address questions and comments to ing.nathany@gmail.com

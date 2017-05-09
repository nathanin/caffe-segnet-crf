<<<<<<< HEAD
# Caffe SegNet cuDNN5
**This is a modified version of [Caffe](https://github.com/BVLC/caffe) which supports the [SegNet architecture](http://mi.eng.cam.ac.uk/projects/segnet/)**
=======
# Caffe upstream for CRF-RNN
>>>>>>> 762871afac86f93f2e9c7da095448536ef3fe328

As described in **SegNet: A Deep Convolutional Encoder-Decoder Architecture for Image Segmentation** Vijay Badrinarayanan, Alex Kendall and Roberto Cipolla [http://arxiv.org/abs/1511.00561]

<<<<<<< HEAD
Please refer to Alex Kendalls caffe-segnet for tutorial and a guide how to use it (https://github.com/alexgkendall/caffe-segnet).
=======

Tutorial on how to compile the code:
```
mkdir build && cmake ../ && make all -j"$(nproc)" && make -j"$(nproc)" pycaffe
```
How to use the python demo code:
Assume you download caffemodel and save it at $CAFFE_ROOT/example/crfasrnn_segmentation/
```
python /opt/caffe/example/crfasrnn_segmentation/crfasrnn_demo.py
``` 

Caffe is a deep learning framework made with expression, speed, and modularity in mind.
It is developed by Berkeley AI Research ([BAIR](http://bair.berkeley.edu))/The Berkeley Vision and Learning Center (BVLC) and community contributors.
>>>>>>> 762871afac86f93f2e9c7da095448536ef3fe328

Since the original caffe-segnet supports just cuDNN v2, which is not supported for new pascal based GPUs, it was possible to decrease the inference time by 25 % to 35 % with caffe-segnet-cudnn5 using Titan X Pascal.

<<<<<<< HEAD
I recommend to use my trained weights (CityScapes Model) for semantic segmenation of traffic scenes, which you can find in segnet model zoo: https://github.com/alexgkendall/SegNet-Tutorial/blob/master/Example_Models/segnet_model_zoo.md
=======
- [DIY Deep Learning for Vision with Caffe](https://docs.google.com/presentation/d/1UeKXVgRvvxg9OUdh_UiC5G71UMscNPlvArsWER41PsU/edit#slide=id.p)
- [Tutorial Documentation](http://caffe.berkeleyvision.org/tutorial/)
- [BAIR reference models](http://caffe.berkeleyvision.org/model_zoo.html) and the [community model zoo](https://github.com/BVLC/caffe/wiki/Model-Zoo)
- [Installation instructions](http://caffe.berkeleyvision.org/installation.html)
>>>>>>> 762871afac86f93f2e9c7da095448536ef3fe328

If you like to use SegNet with C++, the test_segmentation.cpp might be helpful. 
https://github.com/alexgkendall/SegNet-Tutorial/blob/master/Scripts/test_segmentation.cpp

## News
cuDNN v.6 has been released. I have tested it using Titan X Pascal. It doesn't bring any noticeable improvements for SegNet. For that reason I will not update the repository to cuDNN6.

## Publications

If you use this software in your research, please cite their publications:

http://arxiv.org/abs/1511.02680
Alex Kendall, Vijay Badrinarayanan and Roberto Cipolla "Bayesian SegNet: Model Uncertainty in Deep Convolutional Encoder-Decoder Architectures for Scene Understanding." arXiv preprint arXiv:1511.02680, 2015.

<<<<<<< HEAD
http://arxiv.org/abs/1511.00561
Vijay Badrinarayanan, Alex Kendall and Roberto Cipolla "SegNet: A Deep Convolutional Encoder-Decoder Architecture for Image Segmentation." arXiv preprint arXiv:1511.00561, 2015. 
=======
Caffe is released under the [BSD 2-Clause license](https://github.com/BVLC/caffe/blob/master/LICENSE).
The BAIR/BVLC reference models are released for unrestricted use.
>>>>>>> 762871afac86f93f2e9c7da095448536ef3fe328


## License

This extension to the Caffe library is released under a creative commons license which allows for personal and research use only. For a commercial license please contact the authors. You can view a license summary here:
http://creativecommons.org/licenses/by-nc/4.0/

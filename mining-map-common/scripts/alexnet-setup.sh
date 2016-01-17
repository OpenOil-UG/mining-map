#!/bin/bash


if [ ! -d /mining-map/models/alexnet ]; then
  mkdir -p /mining-map/models/alexnet

  # Downloading directly from the BVLC Servers is **ridiculously** slow !! Hence moving the downloaded
  # model to a custom S3 Bucket !!
  # /home/$1/caffe/scripts/download_model_binary.py /home/$1/caffe/models/bvlc_alexnet
  # cp /home/$1/caffe/models/bvlc_alexnet/bvlc_alexnet.caffemodel /mining-map/models/alexnet/

  # Moving BVLC Alexnet Caffe Model to Custom S3 bucket
  wget http://mining-map.s3-website-us-east-1.amazonaws.com/models/bvlc_alexnet.caffemodel -O /mining-map/models/alexnet/bvlc_alexnet.caffemodel
  chown -R $1:$1 /mining-map/models/alexnet/
fi

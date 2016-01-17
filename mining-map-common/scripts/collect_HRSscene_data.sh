#!/bin/bash

export old_addr=`pwd`
rm -rf /mining-map/data/HRSscene

if [ ! -d /mining-map/data/HRSscene ]; then
  mkdir -p /mining-map/data/HRSscene
  cd /mining-map/data/HRSscene
  #TO-DO : Find a better place to host this
  # This is a clone of the HRSscene data set present at http://dsp.whu.edu.cn/cn/staff/yw/HRSscene.html
  # This is being used from this location, as the original hosted version is a very messed up rar file
  # which doesnt behave well with 7z or unrar or unrar-free
  wget http://web.iiit.ac.in/~sharada.mohanty/RSDataset.zip
  unzip *.zip
  mv RSDataset/* .
  rm -f RSDataset.zip
  rm -rf RSDataset
  rm -rf __MACOSX
fi

cd $old_addr

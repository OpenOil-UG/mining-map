#!/bin/bash

# This script will receive an environment where the
# /mining-map folder holds the Digits instance, data, models, etc
# /mining-map-common folder holds all the common scripts

# The current working directory is : /mining-map-common/scripts

# The environment variable "MINING_MAP_MODE" holds the current running mode
# It could be : "AWS-GPU", "AWS-CPU", "LOCAL"

# Setup Landsat-Util environment
apt-get install -y libgdal-dev libatlas-base-dev gfortran libfreetype6-dev

export CPLUS_INCLUDE_PATH=/usr/include/gdal
export C_INCLUDE_PATH=/usr/include/gdal
pip install landsat-util


# Collect & prepare Data
# In this case HRSScene Data
# This should be later replaced with our own dataset
/mining-map-common/scripts/collect_HRSscene_data.sh

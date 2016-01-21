#! /bin/sh

# Locale
update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

# Update package index:
apt-get update

# Install packages:
apt-get install -y \
    htop \
    python-dev \
    python-software-properties \
    python-virtualenv \
    python-pip \
    build-essential \
    libproj-dev \
    libgeos-dev \
    libgdal-dev \
    libgdal1h \
    gdal-bin \
    libatlas-base-dev \
    gfortran \
    libfreetype6-dev

# Install landsat-util without virtual environment (does not compile
# otherwise, maybe due to an outdated scipy version in the ubuntu repos)
#pip install landsat-util

# Install Python dependencies into dedicated virtual environment:
su - vagrant -c 'virtualenv ~/venv'
# install landsat-util after numpy and scipy, it wont work otherwise:
su - vagrant -c 'source ~/venv/bin/activate && pip install -r /srv/mining-map/requirements.txt'
su - vagrant -c 'source ~/venv/bin/activate && pip install landsat-util'

# Activate virtualenv at login via .bashrc
echo "source /home/vagrant/venv/bin/activate" >> /home/vagrant/.bashrc

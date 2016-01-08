#! /bin/sh

# Locale
update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

# Add postgresql PPA:
echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" > /etc/apt/sources.list.d/pgdg.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
apt-key add -

# Update package index:
apt-get update

# Install packages:
apt-get install -y \
    htop \
    python-dev \
    python-software-properties \
    python-virtualenv \
    python-pip \
    python-numpy \
    python-scipy \
    python-matplotlib \
    build-essential \
    libproj-dev \
    libgeos-dev \
    libgdal-dev \
    libgdal1h \
    gdal-bin \
    postgresql-9.4 \
    postgresql-9.4-postgis \
    postgresql-contrib \
    libatlas-base-dev \
    gfortran \
    libfreetype6-dev

# deploy custom pg_hba.conf and restart postgres server:
rm /etc/postgresql/9.4/main/pg_hba.conf
cp /srv/mining-map/provisioning/pg_hba.conf /etc/postgresql/9.4/main/
chown postgres:postgres /etc/postgresql/9.4/main/pg_hba.conf
echo "listen_addresses = '*'" >> /etc/postgresql/9.4/main/postgresql.conf
service postgresql restart

# Create system and database user 'vagrant':
sudo -u postgres psql -c "CREATE USER vagrant PASSWORD 'secret';"

# Setup databases:
sudo -u postgres createdb geodata --owner=vagrant

# Setup PostGIS on databases
sudo -u postgres psql -d geodata -c 'CREATE EXTENSION postgis;'

# Install landsat-util without virtual environment (does not compile
# otherwise, maybe due to an outdated scipy version in the ubuntu repos)
pip install landsat-util

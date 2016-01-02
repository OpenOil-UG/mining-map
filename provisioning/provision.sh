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
    build-essential \
    libproj-dev \
    libgeos-dev \
    libgdal-dev \
    postgresql-9.4 \
    postgresql-9.4-postgis \
    postgresql-contrib

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

# Install Python dependencies into dedicated virtual environment:
su - vagrant -c 'virtualenv ~/venv'
# su - vagrant -c 'source ~/venv/bin/activate && pip install -r /srv/mining-map/requirements.txt'

# Activate virtualenv at login via .bashrc
echo "source /home/vagrant/venv/bin/activate" >> /home/vagrant/.bashrc

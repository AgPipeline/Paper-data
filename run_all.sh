#!/bin/bash

CIMMYT_TAR_FILE_NAME=paper_data_cimmyt.tar.gz

echo "Creating working folder"
mkdir -p cimmyt
pushd cimmyt

if [ ! -f $CIMMYT_TAR_FILE_NAME ]; then
  echo "Downloading image files. This may take a while..."
  wget https://data.cyverse.org/dav-anon/iplant/home/schnaufer/paper_data/CIMMYT/paper_data_cimmyt.tar.gz
else
  echo "Found tar file \"$CIMMYT_TAR_FILE_NAME\" and skipping download"
  echo "Run \"rm $PWD/$CIMMYT_TAR_FILE_NAME\" to remove the file so it's downloaded again"
fi
echo "Extracting images"
tar -xzf paper_data_cimmyt.tar.gz

echo  "Downloading additional files"
wget --unlink https://raw.githubusercontent.com/AgPipeline/Paper-data/main/run_all_cimmyt.sh 
wget --unlink https://data.cyverse.org/dav-anon/iplant/home/schnaufer/paper_data/CIMMYT/gen_csv.sh
wget --unlink https://data.cyverse.org/dav-anon/iplant/home/schnaufer/paper_data/CIMMYT/template.json
wget --unlink https://data.cyverse.org/dav-anon/iplant/home/schnaufer/paper_data/CIMMYT/template.yaml

chmod 555 run_all_cimmyt.sh
chmod 555 gen_csv.sh

echo "Generating canopy cover"
./run_all_cimmyt.sh

cp canopycover.csv ../cimmyt_canopycover.csv

./run_all_cimmyt.sh --clean

popd
rmdir cimmyt

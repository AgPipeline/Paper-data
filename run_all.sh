!/bin/bash

CIMMYT_TAR_FILE_NAME=paper_data_cimmyt.tar.gz

echo "Processing CIMMYT data"
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

echo  "Downloading script file"
wget -O run_all_cimmyt.sh https://raw.githubusercontent.com/AgPipeline/Paper-data/main/run_all_cimmyt.sh 

chmod 555 run_all_cimmyt.sh

echo "Generating canopy cover"
./run_all_cimmyt.sh

cp canopycover.csv ../cimmyt_canopycover.csv

rm paper_data_cimmyt.tar.gz
./run_all_cimmyt.sh --clean

popd
rmdir cimmyt

echo "Processing TAMU Corn data"
echo "Creating working folder"
mkdir -p tamu_corn
pushd tamu_corn

echo "Downloading script file"
wget -O run_all_tamu_corn.sh https://raw.githubusercontent.com/AgPipeline/Paper-data/main/run_all_tamu_corn.sh

chmod 555 run_all_tamu_corn.sh

echo "Generating canopy cover"
./run_all_tamu_corn.sh

cp canopycover.csv ../canopycover_tamu_corn.csv

./run_all_tamu_corn.sh --clean

popd
rmdir tamu_corn

#!/bin/bash

if [[ "$1" ==  "--clean" ]]; then
  echo "Cleaning the folders and files ..."
  rm -r -v 2018-* 2019-*
  rm -v *.json
  rm -v *.sh
  rm -v *.yaml
  rm -v *.csv
  rm -v *.tif
  exit 0
fi

echo  "Downloading additional files"
wget -O gen_csv.sh https://data.cyverse.org/dav-anon/iplant/home/schnaufer/paper_data/terraref/gen_csv.sh

chmod 555 gen_csv.sh

./gen_csv.sh 20181011_Sony_.json 20181011.yaml 20181011_1145_MAC_SonyRGB_40m_georef.tif
./gen_csv.sh 20181011_South_.json 20181011.yaml S7_20181011_1145_South_40m_Sony.tif
./gen_csv.sh 20190624_1405_.json 20190624.yaml S9_20190624_1405_NorthSouth_60m_Sony.tif
./gen_csv.sh 20190624_1454_.json 20190624.yaml S9_20190624_1454_South_30m_Sony.tif 
./gen_csv.sh  20190625_1337_.json 20190625.yaml S9_20190625_1337_NorthSouth_60m_Sony.tif

echo '{' > merge_args.json
echo '"MERGECSV_SOURCE": "/input",' >> merge_args.json
echo '"MERGECSV_TARGET": "/output",' >> merge_args.json
echo '"MERGECSV_OPTIONS": " --ignore-dirs logs,and,others "' >> merge_args.json
echo '}' >> merge_args.json

docker run --rm -v ${PWD}:/input -v ${PWD}:/output -v ${PWD}/merge_args.json:/scif/apps/src/jx-args.json chrisatua/development:drone_makeflow run merge_csv
rm merge_args.json


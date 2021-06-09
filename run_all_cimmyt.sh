#!/bin/bash

if [[ "$1" ==  "--clean" ]]; then
  echo "Cleaning the folders and files ..."
  rm -r -v 2018-*
  rm -v *.tif
  rm -v *.json
  rm -v *.sh
  rm -v *.yaml
  rm -v *.csv
  exit 0
fi

echo  "Downloading additional files"
wget -O gen_csv.sh https://data.cyverse.org/dav-anon/iplant/home/schnaufer/paper_data/CIMMYT/gen_csv.sh
wget -O template.json https://data.cyverse.org/dav-anon/iplant/home/schnaufer/paper_data/CIMMYT/template.json
wget -O template.yaml https://data.cyverse.org/dav-anon/iplant/home/schnaufer/paper_data/CIMMYT/template.yaml

chmod 555 gen_csv.sh

./gen_csv.sh ST_29_DJI_r180119HiBAP_II_transparent_mosaic_group1.tif
./gen_csv.sh ST_29_DJI_r180122HiBAP_II_transparent_mosaic_group1.tif
./gen_csv.sh ST_29_DJI_r180124HiBAP_II_transparent_mosaic_group1.tif
./gen_csv.sh ST_29_DJI_r180126HiBAP_II_transparent_mosaic_group1.tif
./gen_csv.sh ST_29_DJI_r180129HiBAP_II_transparent_mosaic_group1.tif
./gen_csv.sh ST_29_DJI_r180131HiBAP_II_transparent_mosaic_group1.tif
./gen_csv.sh ST_29_DJI_r180202HiBAP_II_transparent_mosaic_group1.tif
./gen_csv.sh ST_29_DJI_r180208HiBAP_II_transparent_mosaic_group1.tif
./gen_csv.sh ST_29_DJI_r180214HiBAP_II_transparent_mosaic_group1.tif
./gen_csv.sh ST_29_DJI_r180216HiBAP_II_transparent_mosaic_group1.tif 0.90
./gen_csv.sh ST_29_DJI_r180221HiBAP_II_transparent_mosaic_group1.tif
./gen_csv.sh ST_29_DJI_r180223HiBAP_II_transparent_mosaic_group1.tif
./gen_csv.sh ST_29_DJI_r180226HiBAP_II_transparent_mosaic_group1.tif 0.95
./gen_csv.sh ST_29_DJI_r180228HiBAP_II_transparent_mosaic_group1.tif 0.95
./gen_csv.sh ST_29_DJI_r180305HiBAP_II_transparent_mosaic_group1.tif 0.90
./gen_csv.sh ST_29_DJI_r180306HiBAP_II_transparent_mosaic_group1.tif 0.90
./gen_csv.sh ST_29_DJI_r180313HiBAP_II_transparent_mosaic_group1.tif 0.90
./gen_csv.sh ST_29_DJI_r180320HiBAP_II_transparent_mosaic_group1.tif 0.90
./gen_csv.sh ST_29_DJI_r180326HiBAP_II_transparent_mosaic_group1.tif 0.90
./gen_csv.sh ST_29_DJI_r180406HiBAP_II_transparent_mosaic_group1.tif 0.90

echo '{' > merge_args.json
echo '"MERGECSV_SOURCE": "/input",' >> merge_args.json
echo '"MERGECSV_TARGET": "/output",' >> merge_args.json
echo '"MERGECSV_OPTIONS": " --ignore-dirs logs,and,others "' >> merge_args.json
echo '}' >> merge_args.json

docker run --rm -v ${PWD}:/input -v ${PWD}:/output -v ${PWD}/merge_args.json:/scif/apps/src/jx-args.json chrisatua/development:drone_makeflow run merge_csv
rm merge_args.json

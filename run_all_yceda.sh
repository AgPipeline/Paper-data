#!/bin/bash

if [[ "$1" ==  "--clean" ]]; then
  echo "Cleaning the folders and files ..."
  rm -r -v 2020-*
  rm -v *.json
  rm -v *.sh
  rm -v *.yaml
  rm -v *.csv
  exit 0
fi

echo  "Downloading additional files"
wget -O all_plots.json https://data.cyverse.org/dav-anon/iplant/home/schnaufer/yceda/SmithFieldLettuce/Smith-Ranch-Fall-2020.json
wget -O gen_csv.sh https://data.cyverse.org/dav-anon/iplant/home/schnaufer/paper_data/yceda/gen_csv.sh
wget -O template.json https://data.cyverse.org/dav-anon/iplant/home/schnaufer/paper_data/yceda/template.json

chmod 555 gen_csv.sh

./gen_csv.sh 2020-09-30 2020-09-30_smithfield_50ft_2_transparent_mosaic_group1.tif
./gen_csv.sh 2020-10-01 2020-10-01_smithfield_50ft_2_transparent_mosaic_group1.tif
./gen_csv.sh 2020-10-02 2020-10-02_smithfield_50ft_3_transparent_mosaic_group1.tif
./gen_csv.sh 2020-10-05 2020-10-05_smithfield_50ft_2_transparent_mosaic_group1.tif
./gen_csv.sh 2020-10-06 2020-10-06_smithfield_50ft_transparent_mosaic_group1.tif
./gen_csv.sh 2020-10-07 2020-10-07_smithfield_50ft_transparent_mosaic_group1.tif
./gen_csv.sh 2020-10-08 2020-10-08_smithfield_50ft_transparent_mosaic_group1.tif
./gen_csv.sh 2020-10-09 2020-10-09_smithfield_50ft_transparent_mosaic_group1.tif
./gen_csv.sh 2020-10-12 2020-10-12_smithfield_50ft_transparent_mosaic_group1.tif
./gen_csv.sh 2020-10-13 2020-10-13_smithfield_50ft_2_transparent_mosaic_group1.tif
./gen_csv.sh 2020-10-14 2020-10--14_smithfield_50ft_transparent_mosaic_group1.tif
./gen_csv.sh 2020-10-15 2020-10-15_smithfield_50ft_transparent_mosaic_group1.tif
./gen_csv.sh 2020-10-15 2020-10-15_smithfield_iceberg_transparent_mosaic_group1.tif
./gen_csv.sh 2020-10-19 2020-10-19_smithfield_50ft_transparent_mosaic_group1.tif
./gen_csv.sh 2020-10-19 2020-10-19_smithfield_iceberg_transparent_mosaic_group1.tif
./gen_csv.sh 2020-10-20 2020-10-20_smithfield_50ft_transparent_mosaic_group1.tif
./gen_csv.sh 2020-10-20 2020-10-20_smithfield_iceberg_transparent_mosaic_group1.tif
./gen_csv.sh 2020-10-21 2020-10-21_smithfield_50ft_transparent_mosaic_group1.tif
./gen_csv.sh 2020-10-21 2020-10-21_smithfield_iceburg_transparent_mosaic_group1.tif
./gen_csv.sh 2020-10-22 2020-10-22_smithfield_50ft_transparent_mosaic_group1.tif
./gen_csv.sh 2020-10-22 2020-10-22_smithfield_iceberg_transparent_mosaic_group1.tif
./gen_csv.sh 2020-10-23 2020-10-23_smithfield_50ft_transparent_mosaic_group1.tif
./gen_csv.sh 2020-10-23 2020-10-23_smithfield_iceburg_transparent_mosaic_group1.tif
./gen_csv.sh 2020-10-28 2020-10-28_smithfield_50ft_transparent_mosaic_group1.tif
./gen_csv.sh 2020-10-28 2020-10-28_smithfield_iceburg_transparent_mosaic_group1.tif
./gen_csv.sh 2020-10-29 2020-10-29_smithfield_50ft_transparent_mosaic_group1.tif
./gen_csv.sh 2020-10-29 2020-10-29_smithfield_iceberg_transparent_mosaic_group1.tif
./gen_csv.sh 2020-10-30 2020-10-30_iceberg_transparent_mosaic_group1.tif
./gen_csv.sh 2020-10-30 2020-10-30_smithfield_50ft_transparent_mosaic_group1.tif
./gen_csv.sh 2020-11-02 2020-11-02_smithfield_50ft_transparent_mosaic_group1.tif
./gen_csv.sh 2020-11-02 2020-11-02_smithfield_iceburg_transparent_mosaic_group1.tif
./gen_csv.sh 2020-11-03 2020-11-03_iceberg_transparent_mosaic_group1.tif
./gen_csv.sh 2020-11-03 2020-11-03_smithfield_50ft_transparent_mosaic_group1.tif
./gen_csv.sh 2020-11-04 2020-11-04_smithfield_50ft_transparent_mosaic_group1.tif
./gen_csv.sh 2020-11-04 2020-11-04_smithfield_iceberg_transparent_mosaic_group1.tif
./gen_csv.sh 2020-11-05 2020-11-05_smithfield_50ft_transparent_mosaic_group1.tif
./gen_csv.sh 2020-11-06 2020-11-06_smithfield_50ft_transparent_mosaic_group1.tif
./gen_csv.sh 2020-11-06 2020-11-06_smithfield_iceberg_transparent_mosaic_group1.tif

echo '{' > merge_args.json
echo '"MERGECSV_SOURCE": "/input",' >> merge_args.json
echo '"MERGECSV_TARGET": "/output",' >> merge_args.json
echo '"MERGECSV_OPTIONS": " --ignore-dirs logs,and,others "' >> merge_args.json
echo '}' >> merge_args.json

docker run --rm -v ${PWD}:/input -v ${PWD}:/output -v ${PWD}/merge_args.json:/scif/apps/src/jx-args.json chrisatua/development:drone_makeflow run merge_csv
rm merge_args.json


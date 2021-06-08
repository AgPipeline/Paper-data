#!/bin/bash

if [[ "$1" ==  "--clean" ]]; then
  echo "Cleaning the folders and files ..."
  rm -r -v 2018-*
  rm -v *.tar.gz
  rm -v *.tif
  rm -v *.json
  rm -v *.sh
  rm -v *.yaml
  rm -v *.csv
  exit 0
fi

echo  "Downloading additional files"
wget -O all_plots.json https://data.cyverse.org/dav-anon/iplant/home/schnaufer/paper_data/tamu_corn/all_plots.json
wget -O gen_csv.sh https://data.cyverse.org/dav-anon/iplant/home/schnaufer/paper_data/tamu_corn/gen_csv.sh
wget -O template.json https://data.cyverse.org/dav-anon/iplant/home/schnaufer/paper_data/tamu_corn/template.json
wget -O template.yaml https://data.cyverse.org/dav-anon/iplant/home/schnaufer/paper_data/tamu_corn/template.yaml

chmod 555 gen_csv.sh

./gen_csv.sh CS17_G2F_20170314_RC
./gen_csv.sh CS17_G2F_20170323_RC
./gen_csv.sh CS17_G2F_20170330_RC
./gen_csv.sh CS17_G2F_20170406_RC
./gen_csv.sh CS17_G2F_20170413_RC
./gen_csv.sh CS17_G2F_20170420_RC
./gen_csv.sh CS17_G2F_20170427_RC
./gen_csv.sh CS17_G2F_20170501_RC
./gen_csv.sh CS17_G2F_20170505_RC
./gen_csv.sh CS17_G2F_20170509_RC
./gen_csv.sh CS17_G2F_20170511_RC
./gen_csv.sh CS17_G2F_20170519_RC
./gen_csv.sh CS17_G2F_20170524_RC
./gen_csv.sh CS17_G2F_20170530_RC
./gen_csv.sh CS17_G2F_20170602_RC
./gen_csv.sh CS17_G2F_20170605_RC
./gen_csv.sh CS17_G2F_20170608_RC
./gen_csv.sh CS17_G2F_20170614_RC 0.95
./gen_csv.sh CS17_G2F_20170616_RC
./gen_csv.sh CS17_G2F_20170629_RC
./gen_csv.sh CS17_G2F_20170714_RC
./gen_csv.sh CS17_G2F_20170727_RC

echo '{' > merge_args.json
echo '"MERGECSV_SOURCE": "/input",' >> merge_args.json
echo '"MERGECSV_TARGET": "/output",' >> merge_args.json
echo '"MERGECSV_OPTIONS": " --ignore-dirs logs,and,others "' >> merge_args.json
echo '}' >> merge_args.json

docker run --rm -v ${PWD}:/input -v ${PWD}:/output -v ${PWD}/merge_args.json:/scif/apps/src/jx-args.json chrisatua/development:drone_makeflow run merge_csv
rm merge_args.json


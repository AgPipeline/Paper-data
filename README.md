# Paper-data

This repository provides the steps for reproducing the data used to generate the results for the DPP paper (TODO: provide link to actual paper)

The files that are downloaded when running the provided scripts are fairly large.
You may want to make sure you have at least 20Gb of disk space free and available.

## Before you start

**wget**

The scripts that reside in this repository use `wget`.
Please make sure that this tool is installed on your system.

**Docker**

The scripts also use [Docker](https://www.docker.com/products/docker-desktop) to run the Docker image containing the algorithms.
You will need to have Docker installed to successfully generate the canopy cover values.

**IRODs commands** <a href="irods" />

The *tamu_corn* and *yceda* data sets are stored on CyVerse in a manner that requires an account, and the installation of [IRODs commandline tools](https://learning.cyverse.org/projects/data_store_guide/en/latest/step2.html).
If you are processing the data sets individually and skipping *tamu_corn*, you don't need to install the IRODs commandline tools.

## Problems when running script files <a href="bash_problems">

[bash](https://www.gnu.org/software/bash/) scripts are used to run the processes needed to generate the canopy cover values.
Your computer may support running *bash* scripts.
We recommend trying to run the scripts before installing *bash*.

The script files **should** already have their executable permissions set.
This allows you to run the scripts directly from a command line, as follows:
```bash
./run_all.sh
```

It's possible that a permission error is displayed if the script can't currently be executed with your permissions.
To correct this, run the following command to grant execution permission to the script.
```bash
# Give the script in the above example execution permission
chmod +x ./run_all.sh
```

The script should run now.

## Output

For each of the data sets, several files are downloaded from online storage to support generating the canopy cover.
Also, source `.tif` image files are extracted from any downloaded image archives, or downloaded directly.

A series of folders that are named after the date of their source image are created.
Inside each of these folders are a set of files, and a folder named `output`.
The files are intermediate files generated during processing.
The *output* folder contains `canopycover.csv` (which contains the calculated values for all plots), a TIFF file with the soil masked out, some intermediate files, and a set of sub-folders.
Each of the sub-folder names corresponds the name of a plot and contains files corresponding to that plot.

For example, the folder structure for a data set would look similar to the following.
The folder `2019-12-01` contains the generated information for the image with the same date.
The folder named `100_01` is a plot-level folder containing files specific to the plot (which has the same name).
```text
- paper_data_cimmyt.tar.gz
- *.tif
- *.sh
- *.json
- *.yaml
- 2019-12-01
 |- 2019-12-01.json
 |- 2019-12-01.yaml
 |- output
   |- canopycover.csv
   |- *.json
   |- *.tif
   |- 100_01
     |- *.csv
     |- *.json
     |- *.tif
   |- <other plot-level folders>
|- <other folders named after dates>
```

Note that different data sets have differing requirements. Therefore, the resulting folders may not exactly match what's shown above.

## Generate all the data

The `run_all.sh` script will download and run the canopy cover analysis for all the data sets.
For each of the data sets, this script will automatically clean up the created folders and files, keeping the final CSV file with the calculated canopy cover values.

The `run_all.sh` script is a *bash* shell script that calls a separate script for each of the data sets.
Running the script generates canopy cover for each of the data sets.

Use the following command to run the script:
```bash
./run_all.sh
```

If you encounter a permission's error when trying to run the script, refer to the [Problems when running script files](#bash_problems) section above.

Refer to each of the section below for more information on the data sets processed by this script.

Running this script will automatically clean up all artifacts generated for each data set, except for the final CSV files.

## Generate CIMMYT canopy cover

It is **strongly** recommended that when running this script directly, it is run in a folder that is empty, or that can be easily recreated.

Run the `run_all_cimmyt.sh` script to generate the canopy cover values for this data set.
Depending upon the speed of your machine, this may take a very long time to complete.

This script automatically downloads any files it needs, creates sub-folders, executes algorithms, and moves the resulting CSV file to the current folder.
Note that the artifacts from running this script will not be removed by default.

Running the following command will generate the CSV file containing the canopy cover calculations.
```bash
./run_all_cymmit.sh
```

This same script can also be used to clean up the downloaded files and other artifacts from processing canopy cover.

**IMPORTANT:** running this command may remove files and sub-folders in the current directory that existed before the canopy cover values were generated.
```bash
# Run this command to clean up after a run
./run_all_cymmit.sh --clean 
```

Refer to the [Problems when running script files](#bash_problems) section above if you encounter issues when trying to run this script.

## Generate tamu_corn canopy cover

It is **strongly** recommended that when running this script directly, it is run in a folder that is empty, or that can be easily recreated.

Running this script requires the IRODs command line tools to be installed.
Refer to the [Before you start](#before_you_start) section above for more information on this and other requirements.

Run the `run_all_tamu_corn.sh` script to generate the canopy cover values for this data set.
As with some of the other data sets, this may take a very long time to complete.

This script automatically downloads files it needs from [IRODs](#irods), creates sub-folders, executes algorithms, and moves the resulting CSV file to the current folder.
Note that the artifacts from running this script will not be removed by default.

Running the following command will generate the CSV file containing the canopy cover calculations.
```bash
./run_all_tamu_corn.sh
```

This same script can also be used to clean up the downloaded files and other artifacts from processing canopy cover.

**IMPORTANT:** running this command may remove files and sub-folders in the current directory that existed before the canopy cover values were generated.
```bash
# Run this command to clean up after a run
./run_all_tamu_corn.sh --clean 
```

Refer to the [Problems when running script files](#bash_problems) section above if you encounter issues when trying to run this script.

## Generate yceda canopy cover

It is **strongly** recommended that when running this script directly, it is run in a folder that is empty, or that can be easily recreated.

Run the `run_all_yceda.sh` script to generate the canopy cover values for this data set.
This is a large data set so it will take a long time to process as well as consuming a large amount of disk space.

This script automatically downloads files it needs from [IRODs](#irods), creates sub-folders, executes algorithms, and moves the resulting CSV file to the current folder.
Note that the artifacts from running this script will not be removed by default.

Running the following command will generate the CSV file containing the canopy cover calculations.
```bash
./run_all_yceda.sh
```

This same script can also be used to clean up the downloaded files and other artifacts from processing canopy cover.

**IMPORTANT:** running this command may remove files and sub-folders in the current directory that existed before the canopy cover values were generated.
```bash
# Run this command to clean up after a run
./run_all_yceda.sh --clean 
```

Refer to the [Problems when running script files](#bash_problems) section above if you encounter issues when trying to run this script.


## Generate TERRAREF canopy cover

It is **strongly** recommended that when running this script directly, it is run in a folder that is empty, or that can be easily recreated.

Run the `run_all_terraref.sh` script to generate the canopy cover values for this data set.
This is a large data set so it will take a long time to process as well as consuming a large amount of disk space.

This script automatically downloads any files it needs, creates sub-folders, executes algorithms, and moves the resulting CSV file to the current folder.
Note that the artifacts from running this script will not be removed by default.

Running the following command will generate the CSV file containing the canopy cover calculations.
```bash
./run_all_terraref.sh
```

This same script can also be used to clean up the downloaded files and other artifacts from processing canopy cover.

**IMPORTANT:** running this command may remove files and sub-folders in the current directory that existed before the canopy cover values were generated.
```bash
# Run this command to clean up after a run
./run_all_terraref.sh --clean 
```

Refer to the [Problems when running script files](#bash_problems) section above if you encounter issues when trying to run this script.


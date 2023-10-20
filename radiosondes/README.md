# Processing radiosoundings

Radiosonde data was processed with the [pysonde](https://github.com/observingClouds/pysonde) package. The radiosounding [dataset](UPDATE) contains three processing levels:

|Processing level | Description | Usage examples |
| --- | --- | --- |
| 0 | mwx sounding files as delivered by Vaisalas sounding software | Checking specific setup of sounding station, Archival of data |
| 1 | Level 0 data converted to netCDF4 | Analysis of single soundings for the most accurate measurements possible |
| 2 | Level 1 data interpolated to a vertical grid | Analysis of entire campaign or comparison with other observations or simulations |

## Reprocessing radiosoundings

By running `reproduce.sh` the level 1 and level 2 data can be reproduced. Output units, variable names, and global attributes can be setup with the yaml files in the `config` folder.

To release a new version of the dataset, please make sure to adjust the DOI in `config/level1.yaml` and `config/level2.yaml`. DOI can be reserved before publishing at most DOI providers, e.g. at [zenodo.org](https://help.zenodo.org/) by creating a new record/version.

We combined the files of the single soundings to datasets. Further standardisation was done with the script `../instruments/Radiosoundings_renaming.py`
#!/bin/bash
module load nco
pip install pysonde
sounding_converter -i ./data/level0/*.mwx -o "./data/level1/ARC_{platform}_L1-{direction}_%Y%m%dT%H%M_{version}.nc" -c config/main.yaml
sounding_converter -i ./data/level1/*.nc -o "./data/level2/ARC_{platform}_L2-{direction}_%Y%m%dT%H%M_{version}.nc" -c config/main.yaml
ncrcat -h ./data/level2/ARC_*L2-*.nc ./data/level2/ARC_MSM_soundings_level2_v1.0.0.nc
rm ./data/level2/*_????????T????_*.nc
zip -r data.zip data


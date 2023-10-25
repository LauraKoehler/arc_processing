#!/bin/bash
source path/to/anaconda3/etc/profile.d/conda.sh
conda activate shippy-dev

# pip install shippy

# DShip
shippy dship -i data/dship_data.txt -o data/renamed/arc_dship_renamed.nc -a shippy_settings/DShip_variables.yaml -s Merian
shippy sections -i data/renamed/arc_dship_renamed.nc -o arc_dship.nc -s shippy_settings/ARC_sections.txt 

# DustTrak
shippy rename -i data/dusttrak_data.nc -o data/renamed/arc_dusttrak_renamed.nc -a shippy_settings/DustTrak_variables.yaml -d dusttrak
shippy sections -i data/renamed/arc_dusttrak_renamed.nc -o arc_dusttrak.nc -s shippy_settings/ARC_sections.txt 

# Calitoo
shippy rename -i data/calitoo_data.nc -o data/renamed/arc_calitoo_renamed.nc -a shippy_settings/Calitoo_variables.yaml -d calitoo
shippy sections -i data/renamed/arc_calitoo_renamed.nc -o arc_calitoo.nc -s shippy_settings/ARC_sections.txt -a shippy_settings/Calitoo_global_attrs.yaml

# Microtops
shippy rename -i data/microtops_data.lev15 -o data/renamed/arc_microtops_renamed.nc -a shippy_settings/Microtops_variables.yaml -d microtops
shippy sections -i data/renamed/arc_microtops_renamed.nc -o arc_microtops.nc -s shippy_settings/ARC_sections.txt -a shippy_settings/Microtops_global_attrs.yaml

# CTD
python additional_scripts/ctd_preparation.py
shippy rename -i data/ctd_data.nc -o data/renamed/arc_ctd_renamed.nc -a shippy_settings/CTD_variables.yaml -d ctd
shippy sections -i data/renamed/arc_ctd_renamed.nc -o arc_ctd.nc -s shippy_settings/ARC_sections.txt -a shippy_settings/CTD_global_attrs.yaml -t start_time

# Radiosondes level 1
shippy rename -i data/radio_level1 -o data/renamed/arc_radiosondes_level1_renamed.nc -a shippy_settings/Radiosondes_variables_level1.yaml -d radiosondes
shippy sections -i data/renamed/arc_radiosondes_level1_renamed.nc -o arc_radiosondes_level1.nc -s shippy_settings/radio_ARC_sections.txt -a shippy_settings/Radiosondes_level1_global_attrs.yaml -t start_time

# Radiosondes level 2
shippy rename -i data/radio_level2 -o data/renamed/arc_radiosondes_level2_renamed.nc -a shippy_settings/Radiosondes_variables_level2.yaml -d radiosondes
shippy sections -i data/renamed/arc_radiosondes_level2_renamed.nc -o arc_radiosondes_level2.nc -s shippy_settings/radio_ARC_sections.txt -a shippy_settings/Radiosondes_level2_global_attrs.yaml -t start_time

# UAV
shippy rename -i data/uav_data.nc -o data/renamed/arc_uav_renamed.nc -a shippy_settings/UAV_variables.yaml -d uav
shippy sections -i data/renamed/arc_uav_renamed.nc -o arc_uav.nc -s shippy_settings/ARC_sections.txt -t start_time

# HATPRO
shippy rename -i data/hatpro_data.nc -o data/renamed/arc_hatpro_renamed.nc -a shippy_settings/HATPRO_variables.yaml -d hatpro
shippy sections -i data/renamed/arc_hatpro_renamed.nc -o arc_hatpro.nc -s shippy_settings/hatrpo_ARC_sections.txt


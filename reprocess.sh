#!/bin/bash
source path/to/anaconda3/etc/profile.d/conda.sh
conda activate shipspy-dev

# pip install shipspy

# DShip
shipspy dship -i data/dship_data.txt -o data/renamed/arc_dship_renamed.nc -a shipspy_settings/DShip_variables.yaml -s Merian
shipspy sections -i data/renamed/arc_dship_renamed.nc -o arc_dship.nc -s shipspy_settings/ARC_sections.txt 

# DustTrak
shipspy rename -i data/dusttrak_data.nc -o data/renamed/arc_dusttrak_renamed.nc -a shipspy_settings/DustTrak_variables.yaml -d dusttrak
shipspy sections -i data/renamed/arc_dusttrak_renamed.nc -o arc_dusttrak.nc -s shipspy_settings/ARC_sections.txt 

# Calitoo
shipspy rename -i data/calitoo_data.nc -o data/renamed/arc_calitoo_renamed.nc -a shipspy_settings/Calitoo_variables.yaml -d calitoo
shipspy sections -i data/renamed/arc_calitoo_renamed.nc -o arc_calitoo.nc -s shipspy_settings/ARC_sections.txt -a shipspy_settings/Calitoo_global_attrs.yaml

# Microtops
shipspy rename -i data/microtops_data.lev20 -o data/renamed/arc_microtops_renamed.nc -a shipspy_settings/Microtops_variables.yaml -d microtops
shipspy sections -i data/renamed/arc_microtops_renamed.nc -o arc_microtops.nc -s shipspy_settings/ARC_sections.txt -a shipspy_settings/Microtops_global_attrs.yaml

# CTD
python additional_scripts/ctd_preparation.py
shipspy rename -i data/ctd_data.nc -o data/renamed/arc_ctd_renamed.nc -a shipspy_settings/CTD_variables.yaml -d ctd
shipspy sections -i data/renamed/arc_ctd_renamed.nc -o arc_ctd.nc -s shipspy_settings/ARC_sections.txt -a shipspy_settings/CTD_global_attrs.yaml -t start_time

# Radiosondes level 1
shipspy rename -i data/radio_level1 -o data/renamed/arc_radiosondes_level1_renamed.nc -a shipspy_settings/Radiosondes_variables_level1.yaml -d radiosondes
shipspy sections -i data/renamed/arc_radiosondes_level1_renamed.nc -o arc_radiosondes_level1.nc -s shipspy_settings/radio_ARC_sections.txt -a shipspy_settings/Radiosondes_level1_global_attrs.yaml -t start_time

# Radiosondes level 2
shipspy rename -i data/radio_level2 -o data/renamed/arc_radiosondes_level2_renamed.nc -a shipspy_settings/Radiosondes_variables_level2.yaml -d radiosondes
shipspy sections -i data/renamed/arc_radiosondes_level2_renamed.nc -o arc_radiosondes_level2.nc -s shipspy_settings/radio_ARC_sections.txt -a shipspy_settings/Radiosondes_level2_global_attrs.yaml -t start_time

# UAV
shipspy rename -i data/uav_data.nc -o data/renamed/arc_uav_renamed.nc -a shipspy_settings/UAV_variables.yaml -d uav
shipspy sections -i data/renamed/arc_uav_renamed.nc -o arc_uav.nc -s shipspy_settings/ARC_sections.txt -t start_time

# HATPRO
shipspy rename -i data/hatpro_data.nc -o data/renamed/arc_hatpro_renamed.nc -a shipspy_settings/HATPRO_variables.yaml -d hatpro
shipspy sections -i data/renamed/arc_hatpro_renamed.nc -o arc_hatpro.nc -s shipspy_settings/hatrpo_ARC_sections.txt

# Ceilometer
python additional_scripts/ceilometer_preparation.py
shipspy rename -i data/ceilometer_data.nc -o data/renamed/arc_ceilometer_renamed.nc -a shipspy_settings/Ceilometer_variables.yaml -d ceilometer
shipspy sections -i data/renamed/arc_ceilometer_renamed.nc -o arc_ceilometer.nc -s shipspy_settings/ceilometer_ARC_sections.txt -a shipspy_settings/Ceilometer_global_attrs.yaml


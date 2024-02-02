# Additional processing scripts

## CTD

By running `ctd_preparation.py`, single ctd files are combined. The coordinates start_time and identifier are added, depth is made a dimension and latitude and longitude are replaced by the values from DShip.

## Ceilometer

`ceilometer_preparations.py` selects the physical relevant variables and takes the 1-minute means. Furthermore, the coordinates latitude and longitude are added from DShip.

## UAV ocean

`uav_ocean.py` adds the ship position from DShip to the UAV ocean data.
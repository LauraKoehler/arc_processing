import xarray as xr
import numpy as np

# This script adds the position from DShip to the UAV ocean data points.

infile = 'data/uav_ocean_data.nc'
outfile = 'data/uav_ocean_data_pos.nc'
dship = xr.open_dataset('arc_dship.nc')

ds = xr.open_dataset(infile)

lats = dship.sel(time = ds.start_time.values, method = 'nearest').lat.values
lons = dship.sel(time = ds.start_time.values, method = 'nearest').lon.values

ds = ds.assign(lat = ("start_time", lats), lon = ("start_time", lons))

ds.lat.attrs = {'axis': 'Y',
 'instrument': 'Seapath (DShip)',
 'long_name': 'latitude',
 'standard_name': 'latitude',
 'units': 'degree_north'}

ds.lon.attrs = {'axis': 'X',
 'instrument': 'Seapath (DShip)',
 'long_name': 'longitude',
 'standard_name': 'longitude',
 'units': 'degree_east'}

ds.to_netcdf(outfile)
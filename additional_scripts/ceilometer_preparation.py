import numpy as np
import xarray as xr

infile = 'data/ceilometer_data_raw.nc'
outfile = 'data/ceilometer_data.nc'

def fix_ceilo(ds):
    ds = ds.where(ds.sci >= 0)
    for var in ['tcc', 'bcc']:
        ds[var] = ds[var].where(ds[var] <=8, other = np.nan)
        ds[var].attrs["units"] = "1/8"
    return ds

def min_means(ds, var):
    """
    Calculate minutely means
    """
    if var in list(['sci']):
        var_mean = ds[[var]].resample(time = 'min').max()
    else:
        var_mean = ds[[var]].resample(time = 'min').mean()
    return var_mean

ds = xr.open_dataset(infile)
dship = xr.open_dataset("data/renamed/arc_dship_renamed.nc")

variables = ["pbl", "tcc", "bcc", "sci", "vor", "voe", "mxd", "cbh", "cbe", "cdp", "cde", "beta_raw", "beta_raw_hr", "stddev", "base"]
ds = ds[variables] 

print("fix")
for v in variables:
    ds = fix_ceilo(ds)

print("1-minute mean")
for v in variables:
    print(v)
    minutely_data = min_means(ds, v)
    if v == variables[0]:
        out = minutely_data
    else:
        out = xr.merge([out, minutely_data])
        
out = out.assign_coords(lat = ('time', dship.sel(time = out.time).lat.values))
out.lat.attrs = dship.lat.attrs
out = out.assign_coords(lon = ('time', dship.sel(time = out.time).lon.values))
out.lon.attrs = dship.lon.attrs

out.to_netcdf(outfile)
import xarray as xr
import numpy as np

from datetime import datetime as dt

indir = '/Users/laura/ownCloud/Campaigns/ARC/Datenpaper/Daten/CTD/Datenpaper'
outfile = '/Users/laura/ownCloud/Campaigns/ARC/Datenpaper/Daten/CTD/ARC_CTD_prep.nc'
dship = xr.open_dataset('/Users/laura/ownCloud/Campaigns/Data/DShip/Merian_DShip.nc')

filenumbers = np.array([ '01',  '02',  '03',  '04',  '05',  '06',  '07', '09', '10', '11', '12', '13', '14', '15', '16', '17',
       '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34',
       '35', '36', '37', '38', '39', '40', '41', '42', '43', '44', '45', '46'])

for fn in filenumbers:
    filename = f'{indir}/ST0{fn}_filt_align_ctm_loop_bin.nc'
    ctd = xr.open_dataset(filename)
    timestamp = np.array([np.datetime64(dt.strptime(ctd.gps_datetime, '%b %d %Y %H:%M:%S'),'s')])
    timestamp = timestamp.astype('datetime64[ns]')
    ctd = ctd.assign_coords(start_time = timestamp)
    ctd = ctd.swap_dims({'scan' : 'DEPTH'})
    ctd = ctd.assign_coords(identifier = ('start_time', [f'CTD0{fn}']))
    if fn == filenumbers[0]:
        ctd_data = ctd
    else:
        ctd_data = xr.concat([ctd_data, ctd], dim = 'start_time')
        
ctd_data = ctd_data.assign_coords(lat = ('start_time', dship.sel(time = ctd_data.start_time, method = 'nearest').lat.values))
ctd_data = ctd_data.assign_coords(lon = ('start_time', dship.sel(time = ctd_data.start_time, method = 'nearest').lon.values))
ctd_data = ctd_data.drop(['LATITUDE', 'LONGITUDE'])

ctd_data.to_netcdf(outfile)

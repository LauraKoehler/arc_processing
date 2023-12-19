# Processing with shipspy

The standardisation of the data sets was done with the [shipspy](https://github.com/shipspy-development/shipspy) package. This folder contains the used settings.

* `ARC_sections.txt`: specifications of the time periods (total campaign and sections)
* `instrument_ARC_sections.txt`: exceptional different time periods for specific instruments (radiosondes, hatpro, and ceilometer)
* `instrument_variables.yaml`: renaming dictionary for all variables, variable attributes (long_name, standard_name, units, instrument, comment,...)
* `instrument_global_attrs.yaml`: global attributes for the instrument data set

## Reprocessing the ARC campaign data

The needed python environment is specified in `../environment.yml`. To reprocess the data with shipspy run `../reprocess.sh`.
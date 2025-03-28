import xarray as xr

ds = xr.open_dataset("/data2/share/hezhan/model/ice_sheet_model/myism/data/GrIS_init_input.nc")

topg = ds.topg

print(topg)

print(topg[0,299,199])
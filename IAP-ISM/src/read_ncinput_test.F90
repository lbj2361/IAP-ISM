!****************************************************************
!IAP-ISM -Version 1.0
!Author: Hezhan
!        the University of Chinese Academy of Science (UCAS)
!        Institute of Atmospheric Physics, Chinese Academy of Sciences (IAP)
!        International Center for Climate and Environment Sciences (ICCES)
!E-mail: 13598987127@163.com

! This module is used to read input data from netcdf file.
!=================================================================================

program read_ncinput_test
    use netcdf_io
    implicit none

    type nc_obj
        character(len=256) :: filename
        integer :: ncid = -1 
        real(kind=8),allocatable,dimension(:) :: x1,y1,x0,y0,level,time 
        real(kind=8),allocatable,dimension(:,:) :: lon,lat
        real(kind=8),allocatable :: thk(:,:,:)           ! ice thickness, units: m
        real(kind=8),allocatable :: topg(:,:,:)          ! bed topography, units: m
        real(kind=8),allocatable :: usurf(:,:,:)         ! surface elevation, units: m
        real(kind=8),allocatable :: bheatflux(:,:,:)     ! basal heat flux, units: W/m^2,downward
        real(kind=8),allocatable :: smb(:,:,:)           ! surface mass balance, units:meter/year ice
        real(kind=8),allocatable :: artm(:,:,:)          ! 2m air temperature, units: K
        real(kind=8),allocatable :: uvel(:,:,:,:)        ! ice velocity in x direction, units: m/a
        real(kind=8),allocatable :: vvel(:,:,:,:)        ! ice velocity in y direction, units: m/a
        real(kind=8),allocatable :: temp(:,:,:,:)            ! ice temperature, units: K
    end type nc_obj
    character(len=256) :: filename
    integer :: ncid
    type(nc_obj) :: nc_obj

    filename = "/data2/share/hezhan/model/ice_sheet_model/myism/data/GrIS_init_input.nc"
    call nc_open(ncid,filename)
    nc_obj%filename = filename
    nc_obj%ncid = ncid
    write(*,*) nc_obj%filename,nc_obj%ncid

end program read_ncinput_test
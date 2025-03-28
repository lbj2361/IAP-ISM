program test
    use constant
    use netcdf_io
    implicit none

    integer ncid,status,dimid,dimlen,varid,varlen
    integer x1_len,y1_len,x0_len,y0_len,level_len,time_len
    character(len=1024) filename
    character(len=64) dimname,varname 
    real(kind=8), allocatable, dimension(:) :: var
    real(kind=8), allocatable, dimension(:,:,:,:) :: ts
    real(kind=8), allocatable, dimension(:,:,:) :: thk

    type nc_object
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
    end type nc_object

    type(nc_object) :: nc_obj
    filename = "/data2/share/hezhan/model/ice_sheet_model/myism/data/GrIS_init_input.nc"
    dimname = "x1"
    varname = "x1"
    ! Test constant module
    call write_line()
    write(*,*) "Test constant module"
    write(*,*) "pi", pi
    write(*,*) "g", g
    call write_line()

    ! Test netcdf_io module
    call nc_open(ncid,filename)
    write(*,*) ncid,trim(filename)
    call nc_dim(ncid,dimname,dimid,dimlen)
    write(*,*) dimid,trim(dimname),dimlen

    call nc_var_1d(ncid,varname,varid,[dimlen],var)
    write(*,*) varid,trim(varname),dimlen,shape(var)

    call nc_var_3d(ncid,"thk",varid,[416,704,1],thk)
    write(*,*) varid,"thk",shape(thk)

    call nc_close(ncid,filename)
    write(*,*) ncid,trim(filename)

    call nc_open(ncid,filename)
    nc_obj%filename = filename
    nc_obj%ncid = ncid

    ! write(*,*) "nc_obj%ncid,trim(nc_obj%filename)",nc_obj%ncid,trim(nc_obj%filename)
    call nc_dim(ncid,"x1",dimid,x1_len)
    call nc_var_1d(ncid,"x1",varid,[x1_len],nc_obj%x1)
    call nc_dim(ncid,"y1",dimid,y1_len)
    call nc_var_1d(ncid,"y1",varid,[y1_len],nc_obj%y1)
    call nc_dim(ncid,"x0",dimid,x0_len)
    call nc_var_1d(ncid,"x0",varid,[x0_len],nc_obj%x0)
    call nc_dim(ncid,"y0",dimid,y0_len)
    call nc_var_1d(ncid,"y0",varid,[y0_len],nc_obj%y0)
    call nc_dim(ncid,"level",dimid,level_len)
    call nc_var_1d(ncid,"level",varid,[level_len],nc_obj%level)
    call nc_dim(ncid,"time",dimid,time_len)
    call nc_var_1d(ncid,"time",varid,[time_len],nc_obj%time)

    write(*,*) "nc_obj%x1",shape(nc_obj%x1)
    write(*,*) "nc_obj%y1",shape(nc_obj%y1)
    write(*,*) "nc_obj%x0",shape(nc_obj%x0)
    write(*,*) "nc_obj%y0",shape(nc_obj%y0)
    write(*,*) "nc_obj%level",shape(nc_obj%level)
    write(*,*) "nc_obj%time",shape(nc_obj%time)

    call nc_var_2d(ncid,"lon",varid,[x1_len,y1_len],nc_obj%lon)
    call nc_var_2d(ncid,"lat",varid,[x1_len,y1_len],nc_obj%lat)
    call nc_var_3d(ncid,"thk",varid,[x1_len,y1_len,time_len],nc_obj%thk)
    call nc_var_3d(ncid,"topg",varid,[x1_len,y1_len,time_len],nc_obj%topg)
    ! call nc_var_3d(ncid,"usurf",varid,[x1_len,y1_len,time_len],nc_obj%usurf)
    call nc_var_3d(ncid,"bheatflux",varid,[x1_len,y1_len,time_len],nc_obj%bheatflux)
    call nc_var_3d(ncid,"acab",varid,[x1_len,y1_len,time_len],nc_obj%smb)
    call nc_var_3d(ncid,"artm",varid,[x1_len,y1_len,time_len],nc_obj%artm)
    call nc_var_4d(ncid,"uvel",varid,[x0_len,y0_len,level_len,time_len],nc_obj%uvel)
    call nc_var_4d(ncid,"vvel",varid,[x0_len,y0_len,level_len,time_len],nc_obj%vvel)
    ! call nc_var_4d(ncid,"temp",varid,[x1_len,y1_len,level_len,time_len],nc_obj%temp)
    write(*,*) "nc_obj%lon",shape(nc_obj%lon)
    write(*,*) "nc_obj%lat",shape(nc_obj%lat)
    write(*,*) "nc_obj%thk",shape(nc_obj%thk)
    write(*,*) "nc_obj%topg",shape(nc_obj%topg)
    ! write(*,*) "nc_obj%usurf",shape(nc_obj%usurf)
    write(*,*) "nc_obj%bheatflux",shape(nc_obj%bheatflux)
    write(*,*) "nc_obj%smb",shape(nc_obj%smb)
    write(*,*) "nc_obj%artm",shape(nc_obj%artm)
    write(*,*) "nc_obj%uvel",shape(nc_obj%uvel)
    write(*,*) "nc_obj%vvel",shape(nc_obj%vvel)
    ! write(*,*) "nc_obj%temp",shape(nc_obj%temp)
    call nc_close(ncid,filename)
end program test

subroutine write_line()
    write(*,*) "-------------------------------------------"
end subroutine write_line
program read_GrIS_test
    use netcdf 
    implicit none

    character(len=256) :: filename 
    integer :: ncid, status
    integer :: x0_dimid, y0_dimid, x1_dimid, y1_dimid, level_dimid, time_dimid
    integer :: x0_len, y0_len, x1_len, y1_len, level_len, time_len
    integer :: x0_varid, y0_varid, x1_varid, y1_varid, level_varid, time_varid
    integer :: topg_varid,thk_varid,bheatflux_varid,acab_varid,artm_varid,uvel_varid,vvel_varid, &
            &  uvel_2d_varid,vvel_2d_varid
    real,allocatable,dimension(:) :: x0, y0, x1, y1, level, time
    real, allocatable :: topg(:,:,:)        ! 基底地形 (time, y1, x1)
    real, allocatable :: thk(:,:,:)         ! 冰厚度 (time, y1, x1)
    real, allocatable :: bheatflux(:,:,:)   ! 基底热通量 (time, y1, x1)
    real, allocatable :: acab(:,:,:)        ! 表面质量平衡 (time, y1, x1)
    real, allocatable :: artm(:,:,:)        ! 表面温度 (time, y1, x1)
    real, allocatable :: uvel(:,:,:,:)      ! x 方向流速 (time, level, y0, x0)
    real, allocatable :: vvel(:,:,:,:)      ! y 方向流速 (time, level, y0, x0)
    real, allocatable :: uvel_2d(:,:,:)     ! 二维 x 方向流速 (time, y0, x0)
    real, allocatable :: vvel_2d(:,:,:)     ! 二维 y 方向流速 (time, y0, x0)   

    filename = "/data2/share/hezhan/model/ice_sheet_model/myism/data/GrIS_init_input.nc"

    status = nf90_open(trim(filename), NF90_NOWRITE, ncid)
    call inq_error(status,"nf90_open")
    status = nf90_inq_dimid(ncid, "x0", x0_dimid)
    call inq_error(status,"nf90_inq_dimid x0")
    status = nf90_inq_dimid(ncid, "y0", y0_dimid)
    call inq_error(status,"nf90_inq_dimid y0")
    status = nf90_inq_dimid(ncid, "x1", x1_dimid)
    call inq_error(status,"nf90_inq_dimid x1")
    status = nf90_inq_dimid(ncid, "y1", y1_dimid)
    call inq_error(status,"nf90_inq_dimid y1")
    status = nf90_inq_dimid(ncid, "level", level_dimid)
    call inq_error(status,"nf90_inq_dimid level")
    status = nf90_inq_dimid(ncid, "time", time_dimid)
    call inq_error(status,"nf90_inq_dimid time")


    status = nf90_inquire_dimension(ncid, x0_dimid, len=x0_len)
    call inq_error(status,"nf90_inquire_dimension x0")
    status = nf90_inquire_dimension(ncid, y0_dimid, len=y0_len)
    call inq_error(status,"nf90_inquire_dimension y0")
    status = nf90_inquire_dimension(ncid, x1_dimid, len=x1_len)
    call inq_error(status,"nf90_inquire_dimension x1")
    status = nf90_inquire_dimension(ncid, y1_dimid, len=y1_len)
    call inq_error(status,"nf90_inquire_dimension y1")
    status = nf90_inquire_dimension(ncid, level_dimid, len=level_len)
    call inq_error(status,"nf90_inquire_dimension level")
    status = nf90_inquire_dimension(ncid, time_dimid, len=time_len)
    call inq_error(status,"nf90_inquire_dimension time")

    write(*,*) "x0_dimid = ", x0_dimid, " x0_len = ", x0_len
    write(*,*) "y0_dimid = ", y0_dimid, " y0_len = ", y0_len
    write(*,*) "x1_dimid = ", x1_dimid, " x1_len = ", x1_len
    write(*,*) "y1_dimid = ", y1_dimid, " y1_len = ", y1_len
    write(*,*) "level_dimid = ", level_dimid, " level_len = ", level_len
    write(*,*) "time_dimid = ", time_dimid, " time_len = ", time_len

    allocate(x0(x0_len), y0(y0_len), x1(x1_len), y1(y1_len), level(level_len), time(time_len))
    allocate(topg(x1_len, y1_len, time_len),thk(x1_len, y1_len, time_len),bheatflux(x1_len, y1_len, time_len))
    allocate(acab(x1_len, y1_len, time_len), artm(x1_len, y1_len, time_len))
    allocate(uvel(x0_len, y0_len, level_len, time_len), vvel(x0_len, y0_len, level_len, time_len))
    allocate(uvel_2d(x0_len, y0_len, time_len), vvel_2d(x0_len, y0_len, time_len))
    ! allocate(thk(time_len, y1_len, x1_len), bheatflux(time_len, y1_len, x1_len))
    ! allocate(acab(time_len, y1_len, x1_len), artm(time_len, y1_len, x1_len))
    ! allocate(uvel(time_len, level_len, y0_len, x0_len), vvel(time_len, level_len, y0_len, x0_len))
    ! allocate(uvel_2d(time_len, y0_len, x0_len), vvel_2d(time_len, y0_len, x0_len))

    status = nf90_inq_varid(ncid, "x0", x0_varid)
    call inq_error(status,"nf90_inq_varid x0")
    status = nf90_inq_varid(ncid, "y0", y0_varid)
    call inq_error(status,"nf90_inq_varid y0")
    status = nf90_inq_varid(ncid, "x1", x1_varid)
    call inq_error(status,"nf90_inq_varid x1")
    status = nf90_inq_varid(ncid, "y1", y1_varid)
    call inq_error(status,"nf90_inq_varid y1")
    status = nf90_inq_varid(ncid, "level", level_varid)
    call inq_error(status,"nf90_inq_varid level")
    status = nf90_inq_varid(ncid, "time", time_varid)
    call inq_error(status,"nf90_inq_varid time")

    status = nf90_get_var(ncid, x0_varid, x0)
    call inq_error(status,"nf90_get_var x0")
    status = nf90_get_var(ncid, y0_varid, y0)
    call inq_error(status,"nf90_get_var y0")
    status = nf90_get_var(ncid, x1_varid, x1)
    call inq_error(status,"nf90_get_var x1")
    status = nf90_get_var(ncid, y1_varid, y1)
    call inq_error(status,"nf90_get_var y1")
    status = nf90_get_var(ncid, level_varid, level)
    call inq_error(status,"nf90_get_var level")
    status = nf90_get_var(ncid, time_varid, time)
    call inq_error(status,"nf90_get_var time")

    ! write(*,*) "x0 = ", x0
    ! write(*,*) "y0 = ", y0
    ! write(*,*) "x1 = ", x1
    ! write(*,*) "y1 = ", y1
    ! write(*,*) "level = ", level
    ! write(*,*) "time = ", time

    status = nf90_inq_varid(ncid, "topg", topg_varid)
    call inq_error(status,"nf90_inq_varid topg")
    status = nf90_get_var(ncid, topg_varid, topg)
    call inq_error(status,"nf90_get_var topg")

    status = nf90_inq_varid(ncid, "thk", thk_varid)
    call inq_error(status,"nf90_inq_varid thk")
    status = nf90_get_var(ncid, thk_varid, thk,start=[1,1,1],count=[x1_len,y1_len,time_len])
    call inq_error(status,"nf90_get_var thk")

    status = nf90_inq_varid(ncid, "bheatflux", bheatflux_varid)
    call inq_error(status,"nf90_inq_varid bheatflux")
    status = nf90_get_var(ncid, bheatflux_varid, bheatflux,start=[1,1,1],count=[x1_len,y1_len,time_len])
    call inq_error(status,"nf90_get_var bheatflux")

    status = nf90_inq_varid(ncid, "acab", acab_varid)
    call inq_error(status,"nf90_inq_varid acab")
    status = nf90_get_var(ncid, acab_varid, acab,start=[1,1,1],count=[x1_len,y1_len,time_len])
    call inq_error(status,"nf90_get_var acab")

    status = nf90_inq_varid(ncid, "artm", artm_varid)
    call inq_error(status,"nf90_inq_varid artm")
    status = nf90_get_var(ncid, artm_varid, artm,start=[1,1,1],count=[x1_len,y1_len,time_len])
    call inq_error(status,"nf90_get_var artm")

    status = nf90_inq_varid(ncid, "uvel", uvel_varid)
    call inq_error(status,"nf90_inq_varid uvel")
    status = nf90_get_var(ncid, uvel_varid, uvel,start=[1,1,1,1],count=[x0_len,y0_len,level_len,time_len])
    call inq_error(status,"nf90_get_var uvel")

    status = nf90_inq_varid(ncid, "vvel", vvel_varid)
    call inq_error(status,"nf90_inq_varid vvel")
    status = nf90_get_var(ncid, vvel_varid, vvel,start=[1,1,1,1],count=[x0_len,y0_len,level_len,time_len])
    call inq_error(status,"nf90_get_var vvel")

    status = nf90_inq_varid(ncid, "uvel_2d", uvel_2d_varid)
    call inq_error(status,"nf90_inq_varid uvel_2d")
    status = nf90_get_var(ncid, uvel_2d_varid, uvel_2d,start=[1,1,1],count=[x0_len,y0_len,time_len])
    call inq_error(status,"nf90_get_var uvel_2d")

    status = nf90_inq_varid(ncid, "vvel_2d", vvel_2d_varid)
    call inq_error(status,"nf90_inq_varid vvel_2d")
    status = nf90_get_var(ncid, vvel_2d_varid, vvel_2d,start=[1,1,1],count=[x0_len,y0_len,time_len])
    call inq_error(status,"nf90_get_var vvel_2d")

    status = nf90_close(ncid)
    call inq_error(status,"nf90_close")

    ! write(*,*) "topg(:,1,1) = ", topg(:,1,1)
    write(*,*) "thk(199,:,1) = ", thk(199,:,1)
    
end program read_GrIS_test

subroutine inq_error(status,description)
    use netcdf
    implicit none
    integer status
    character(len=*) description
    character(len=100) message

    if (status .eq. 0) then
        write(*,*) "routine : ",trim(description)
        ! write(*,*) "error: ", status
        write(*,*) "successful"
        write(*,*) "--------------------------------------"        
    else if (status .ne. 0) then
        write(*,*) "routine : ",trim(description)
        write(*,*) "error: ", status
        message=nf90_strerror(status)
        write(*,*) trim(message)
        write(*,*) "--------------------------------------"        
        stop
    endif 
end subroutine inq_error

program test_topg
    use netcdf
    implicit none
    character(len=256) :: filename = "/data2/share/hezhan/model/ice_sheet_model/myism/data/GrIS_init_input.nc"
    integer :: ncid, status, topg_varid, dimid
    integer :: time_len, y1_len, x1_len
    real, allocatable :: topg(:,:,:)
    
    ! 打开文件并检查错误
    status = nf90_open(filename, NF90_NOWRITE, ncid)
    call handle_err(status)
    
    ! 获取维度ID和长度（逐行检查错误）
    status = nf90_inq_dimid(ncid, "time", dimid)
    call handle_err(status)
    status = nf90_inquire_dimension(ncid, dimid, len=time_len)
    call handle_err(status)
    
    status = nf90_inq_dimid(ncid, "y1", dimid)
    call handle_err(status)
    status = nf90_inquire_dimension(ncid, dimid, len=y1_len)
    call handle_err(status)
    
    status = nf90_inq_dimid(ncid, "x1", dimid)
    call handle_err(status)
    status = nf90_inquire_dimension(ncid, dimid, len=x1_len)
    call handle_err(status)
    
    ! 验证维度长度
    print*, "time_len = ", time_len, "y1_len = ", y1_len, "x1_len = ", x1_len
    
    ! 分配数组并读取数据
    ! allocate(topg(x1_len, y1_len, time_len))
    allocate(topg(time_len, y1_len, x1_len))

    status = nf90_inq_varid(ncid, "topg", topg_varid)
    call handle_err(status)
    
    ! 调整count参数顺序为[x1_len, y1_len, time_len]
    ! status = nf90_get_var(ncid, topg_varid, topg, start=[1,1,1], count=[x1_len, y1_len, time_len])
    status = nf90_get_var(ncid, topg_varid, topg, start=[1,1,1], count=[time_len, y1_len, x1_len])
    call handle_err(status)
    
    print*, "topg(:,1,1) = ", topg(:,1,1)
end program test_topg

subroutine handle_err(status)
    use netcdf
    implicit none
    integer :: status
    if (status /= nf90_noerr) then
        print *, "NetCDF Error: ", trim(nf90_strerror(status))
        stop "Program terminated due to NetCDF error."
    endif
end subroutine handle_err
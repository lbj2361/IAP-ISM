program example_nc_reader
    use nc_reader
    implicit none

    type(nc_file_type) :: ncfile
    real, pointer :: thk_data(:,:,:,:) => null()  ! 使用指针接收数据
    integer :: i, j, k
    character(len=*), parameter :: FILE_PATH = "/data2/share/hezhan/model/ice_sheet_model/myism/data/GrIS_init_input.nc"

    ! ------------------------
    ! 1. 打开文件
    ! ------------------------
    call nc_open(FILE_PATH, ncfile)
    print*, "File opened successfully. ncid = ", ncfile%ncid

    ! ------------------------
    ! 2. 获取维度信息
    ! ------------------------
    call nc_get_dim(ncfile)
    print*, "Total dimensions:", size(ncfile%dims)
    do i = 1, size(ncfile%dims)
        print*, "Dim ", i, ": ", trim(ncfile%dims(i)%name), " length = ", ncfile%dims(i)%len
    end do

    ! ------------------------
    ! 3. 读取厚度变量（3D数据示例）
    ! ------------------------
    call nc_get_var(ncfile, "thk", thk_data)
    print*, "Thickness data dimensions:", shape(thk_data)

    ! 验证数据（输出部分值）
    print*, "Sample data (1:2,1:2,1):"
    do j = 1, 2
        do k = 1, 2
            print*, thk_data(j, k, 1, 1)
        end do
    end do

    ! ------------------------
    ! 5. 清理资源
    ! ------------------------
    call nc_close(ncfile)
    
    ! 显式释放指针内存
    if (associated(thk_data)) deallocate(thk_data)
    print*, "All resources released."

end program example_nc_reader
module nc_reader
    use netcdf
    implicit none

    private
    public :: nc_file_type, nc_open, nc_close, nc_get_dim, nc_get_var

    !------------------------
    ! 类型定义（Fortran90 兼容性调整）
    !------------------------
    type nc_dim_type
        character(len=NF90_MAX_NAME) :: name  ! 改用固定长度字符[1,6](@ref)
        integer :: len
    end type

    type nc_var_type
        character(len=NF90_MAX_NAME) :: name
        integer :: xtype
        integer, pointer :: dim_ids(:)       ! 改用指针代替可分配数组[3](@ref)
        real, pointer :: data(:,:,:,:)       ! 支持1D-4D数据的指针声明
    end type

    type nc_file_type
        integer :: ncid = -1
        type(nc_dim_type), pointer :: dims(:)! 改用指针实现动态数组[4](@ref)
        type(nc_var_type), pointer :: vars(:)
        character(len=256) :: attrs(100)     ! 固定长度属性存储[2](@ref)
    end type

contains

    !------------------------
    ! 文件操作子程序
    !------------------------
    subroutine nc_open(filename, ncfile, status)
        character(len=*), intent(in) :: filename
        type(nc_file_type), intent(out) :: ncfile
        integer, optional, intent(out) :: status
        integer :: stat

        stat = nf90_open(trim(filename), NF90_NOWRITE, ncfile%ncid)
        if (present(status)) then
            status = stat
        else
            call check_error(stat, "Open file")
        end if
    end subroutine

    subroutine nc_get_dim(ncfile)
        type(nc_file_type), intent(inout) :: ncfile
        integer :: i, ndims, stat

        stat = nf90_inquire(ncid=ncfile%ncid, nDimensions=ndims)
        call check_error(stat, "Get dim count")

        if (associated(ncfile%dims)) deallocate(ncfile%dims)
        allocate(ncfile%dims(ndims))  ! 静态分配前需获取维度数量[1](@ref)

        do i = 1, ndims
            stat = nf90_inquire_dimension(ncfile%ncid, i, ncfile%dims(i)%name, ncfile%dims(i)%len)
            call check_error(stat, "Get dim "//trim(ncfile%dims(i)%name))
        end do
    end subroutine

    !------------------------
    ! 变量读取（Fortran90兼容实现）
    !------------------------
    subroutine nc_get_var(ncfile, varname, var_data)
        type(nc_file_type), intent(in) :: ncfile
        character(len=*), intent(in) :: varname
        real, pointer :: var_data(:,:,:,:)   ! 使用指针传递数据[5](@ref)
        integer :: varid, ndims, stat, i
        integer, allocatable :: dim_sizes(:)

        stat = nf90_inq_varid(ncfile%ncid, trim(varname), varid)
        call check_error(stat, "Find variable "//trim(varname))

        stat = nf90_inquire_variable(ncfile%ncid, varid, ndims=ndims)
        call check_error(stat, "Get var ndims")

        allocate(dim_sizes(ndims))
        do i = 1, ndims
            stat = nf90_inquire_dimension(ncfile%ncid, i, len=dim_sizes(i))  ! 按维度顺序读取[6](@ref)
        end do

        ! 动态内存分配（Fortran90风格）
        select case(ndims)
        case(1)
            allocate(var_data(dim_sizes(1),1,1,1))
        case(2)
            allocate(var_data(dim_sizes(1),dim_sizes(2),1,1))
        case(3)
            allocate(var_data(dim_sizes(1),dim_sizes(2),dim_sizes(3),1))
        case(4)
            allocate(var_data(dim_sizes(1),dim_sizes(2),dim_sizes(3),dim_sizes(4)))
        end select

        stat = nf90_get_var(ncfile%ncid, varid, var_data)
        call check_error(stat, "Read variable "//trim(varname))
    end subroutine

    !------------------------
    ! 关闭文件（增加内存释放）
    !------------------------
    subroutine nc_close(ncfile)
        type(nc_file_type), intent(inout) :: ncfile
        integer :: stat

        if (ncfile%ncid /= -1) then
            stat = nf90_close(ncfile%ncid)
            call check_error(stat, "Close file")
            ncfile%ncid = -1
            
            ! 显式释放指针内存[3](@ref)
            if (associated(ncfile%dims)) deallocate(ncfile%dims)
            if (associated(ncfile%vars)) deallocate(ncfile%vars)
        end if
    end subroutine

    !------------------------
    ! 错误处理（兼容性优化）
    !------------------------
    subroutine check_error(stat, msg)
        integer, intent(in) :: stat
        character(len=*), intent(in) :: msg
        character(len=256) :: full_msg  ! 固定长度错误信息[2](@ref)

        if (stat /= NF90_NOERR) then
            full_msg = "Error in "//trim(msg)//": "//trim(nf90_strerror(stat))
            print *, full_msg
            stop
        end if
    end subroutine

end module nc_reader
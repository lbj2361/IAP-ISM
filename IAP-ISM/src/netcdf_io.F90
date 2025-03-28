!****************************************************************
!IAP-ISM -Version 1.0
!Author: Hezhan
!        the University of Chinese Academy of Science (UCAS)
!        Institute of Atmospheric Physics, Chinese Academy of Sciences (IAP)
!        International Center for Climate and Environment Sciences (ICCES)
!E-mail: 13598987127@163.com

module netcdf_io
    use netcdf
    implicit none
    private 
    public :: nc_open,nc_close,nc_dim,nc_var_1d,nc_var_2d,nc_var_3d,nc_var_4d

    contains 

        subroutine nc_open(ncid,filename)
            use netcdf
            implicit none
            integer ncid,status    
            character(len=*) filename
            status = nf90_open(trim(filename), NF90_NOWRITE, ncid)
            !TODO: write(*,*) trim(filename)
            call inq_error(status,"open nc file:"//trim(filename))
            
        end subroutine nc_open

        subroutine nc_close(ncid,filename)
            use netcdf
            implicit none
            integer ncid,status    
            character(len=*) filename
            status = nf90_close(ncid)
            call inq_error(status,"close nc file:"//trim(filename))
        end subroutine nc_close

        subroutine nc_dim(ncid,dimname,dimid,dimlen)
            use netcdf
            implicit none
            integer ncid,status,dimid,dimlen
            character(len=*) dimname

            status = nf90_inq_dimid(ncid,trim(dimname),dimid)
            call inq_error(status,"inquire dimid:"//trim(dimname))
            status = nf90_inquire_dimension(ncid,dimid,len=dimlen)
            call inq_error(status,"inquire dimlen:"//trim(dimname))
        end subroutine nc_dim

        subroutine nc_var_1d(ncid,varname,varid,vardim,var)
            use netcdf
            implicit none
            integer ncid,status,varid
            integer vardim(1)
            character(len=*) varname
            real(kind=8), allocatable, dimension(:) :: var

            status = nf90_inq_varid(ncid,trim(varname),varid)
            call inq_error(status,"inquire varid:"//trim(varname))

            allocate(var(vardim(1)))
            status = nf90_get_var(ncid,varid,var)
            call inq_error(status,"get var:"//trim(varname))
        end subroutine nc_var_1d

        subroutine nc_var_2d(ncid,varname,varid,vardim,var)
            use netcdf
            implicit none
            integer ncid,status,varid
            integer vardim(2)
            character(len=*) varname
            real(kind=8), allocatable, dimension(:,:) :: var

            status = nf90_inq_varid(ncid,trim(varname),varid)       
            call inq_error(status,"inquire varid:"//trim(varname))

            allocate(var(vardim(1),vardim(2)))
            status = nf90_get_var(ncid,varid,var)
            call inq_error(status,"get var:"//trim(varname))    
        end subroutine nc_var_2d

        subroutine nc_var_3d(ncid,varname,varid,vardim,var)
            use netcdf
            implicit none
            integer ncid,status,varid
            integer vardim(3)
            character(len=*) varname
            real(kind=8), allocatable, dimension(:,:,:) :: var

            status = nf90_inq_varid(ncid,trim(varname),varid)       
            call inq_error(status,"inquire varid:"//trim(varname))

            allocate(var(vardim(1),vardim(2),vardim(3)))
            status = nf90_get_var(ncid,varid,var)
            call inq_error(status,"get var:"//trim(varname))    
        end subroutine nc_var_3d        

        subroutine nc_var_4d(ncid,varname,varid,vardim,var)     
            use netcdf
            implicit none
            integer ncid,status,varid
            integer vardim(4)
            character(len=*) varname
            real(kind=8), allocatable, dimension(:,:,:,:) :: var

            status = nf90_inq_varid(ncid,trim(varname),varid)       
            call inq_error(status,"inquire varid:"//trim(varname))

            allocate(var(vardim(1),vardim(2),vardim(3),vardim(4)))
            status = nf90_get_var(ncid,varid,var)
            call inq_error(status,"get var:"//trim(varname))    
        end subroutine nc_var_4d

        subroutine inq_error(status,description)
            use netcdf
            implicit none
            integer status
            character(len=*) description
            character(len=100) message

            if (status .eq. 0) then
                write(*,*) "routine : ",trim(description)
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
end module netcdf_io
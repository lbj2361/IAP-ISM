!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!constant.F90: define constants used in the model

module constant
    implicit none
    integer, parameter :: dp = selected_real_kind(15, 307)
    real(dp),parameter :: pi = 3.141592653589793_dp
    real(dp),parameter :: g = 9.80665_dp
    real(dp),parameter :: rhoi = 910.0_dp
    real(dp),parameter :: rhow = 1000.0_dp
    real(dp),parameter :: rhoo = 1028.0_dp

end module constant
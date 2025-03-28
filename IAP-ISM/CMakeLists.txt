cmake_minimum_required(VERSION 3.10)

project(myism)

set(CMAKE_Fortran_COMPILER "ifort")
enable_language(Fortran)


# 替换为你的实际路径
set(NETCDF_DIR "/public/software/mathlib/netcdf/intel/4.7.4/")
set(NETCDF_INCLUDE_DIRS "${NETCDF_DIR}/include")
set(NETCDF_LIBRARIES "${NETCDF_DIR}/lib/libnetcdff.so")



add_executable(test.exe src/test.F90 src/constant.F90 src/netcdf_io.F90) 

target_include_directories(test.exe PRIVATE ${NETCDF_INCLUDE_DIRS})
target_link_libraries(test.exe ${NETCDF_LIBRARIES})


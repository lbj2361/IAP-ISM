# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.20

# Note that incremental build could trigger a call to cmake_copy_f90_mod on each re-build
CMakeFiles/test.exe.dir/src/constant.F90.o.provides.build: CMakeFiles/test.exe.dir/constant.mod.stamp
CMakeFiles/test.exe.dir/constant.mod.stamp: CMakeFiles/test.exe.dir/src/constant.F90.o
	$(CMAKE_COMMAND) -E cmake_copy_f90_mod constant.mod CMakeFiles/test.exe.dir/constant.mod.stamp Intel
CMakeFiles/test.exe.dir/src/constant.F90.o.provides.build:
	$(CMAKE_COMMAND) -E touch CMakeFiles/test.exe.dir/src/constant.F90.o.provides.build
CMakeFiles/test.exe.dir/build: CMakeFiles/test.exe.dir/src/constant.F90.o.provides.build
CMakeFiles/test.exe.dir/src/netcdf_io.F90.o: /public/software/mathlib/netcdf/intel/4.7.4/include/netcdf.mod
CMakeFiles/test.exe.dir/src/netcdf_io.F90.o.provides.build: CMakeFiles/test.exe.dir/netcdf_io.mod.stamp
CMakeFiles/test.exe.dir/netcdf_io.mod.stamp: CMakeFiles/test.exe.dir/src/netcdf_io.F90.o
	$(CMAKE_COMMAND) -E cmake_copy_f90_mod netcdf_io.mod CMakeFiles/test.exe.dir/netcdf_io.mod.stamp Intel
CMakeFiles/test.exe.dir/src/netcdf_io.F90.o.provides.build:
	$(CMAKE_COMMAND) -E touch CMakeFiles/test.exe.dir/src/netcdf_io.F90.o.provides.build
CMakeFiles/test.exe.dir/build: CMakeFiles/test.exe.dir/src/netcdf_io.F90.o.provides.build
CMakeFiles/test.exe.dir/src/test.F90.o: CMakeFiles/test.exe.dir/constant.mod.stamp
CMakeFiles/test.exe.dir/src/test.F90.o: CMakeFiles/test.exe.dir/netcdf_io.mod.stamp

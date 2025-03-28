CC = icc
FC = ifort 
MPICC = mpiicc
MPIFC = mpiifort

# 查找所有源文件
F90_src := $(shell find src -name '*.F90')
F90_obj := $(patsubst src/%.F90, obj/%.o, $(F90_src))

# 包含路径和模块路径
include_path := -I./include -I/public/software/mathlib/netcdf/intel/4.7.4/include
module_path := -I./obj
lib_path := -L/public/software/mathlib/netcdf/intel/4.7.4/lib -lnetcdf -lnetcdff

# 编译选项
compile_opt := -g -O3 -w $(include_path) $(module_path) $(lib_path) -module ./obj

# 默认目标
all: bin/test.exe

# 对象文件规则
obj/%.o: src/%.F90
	@mkdir -p $(dir $@)
	$(FC) -c $(compile_opt) $< -o $@

# 可执行文件规则
bin/test.exe : $(F90_obj)
	@mkdir -p $(dir $@)
	$(FC) $(compile_opt) $^ -o $@

# 运行目标
run : bin/test.exe
	./$^

# 打印变量值
print:
	@echo "F90_src: $(F90_src)"
	@echo "F90_obj: $(F90_obj)"
	@echo "compile_opt: $(compile_opt)"

# 清理生成的文件
clean:
	rm -rf obj/*.o obj/*.mod bin/*.exe 

# 确保模块文件先编译
obj/test.o: obj/constant.o obj/netcdf_io.o

.PHONY: all run print clean
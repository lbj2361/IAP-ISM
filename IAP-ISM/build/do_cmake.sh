#!/usr/bin/bash

set -x

# 安全地清理构建文件
if [ -d "./CMakeFiles" ]; then
    rm -rf ./CMakeFiles
    rm -f cmake_install.cmake CMakeCache.txt Makefile
fi

cmake ..

make -j 2

./test.exe

set +x
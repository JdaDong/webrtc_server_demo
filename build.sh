#!/bin/bash

echo "=== WebRTC信令服务器编译脚本 ==="
echo ""

# 检查必要工具
if ! command -v cmake &> /dev/null; then
    echo "错误: 未找到cmake，请先安装CMake"
    echo "安装命令: brew install cmake"
    exit 1
fi

if ! command -v make &> /dev/null; then
    echo "错误: 未找到make，请安装Xcode命令行工具"
    echo "安装命令: xcode-select --install"
    exit 1
fi

# 检查Boost库
echo "检查Boost库依赖..."
if [ ! -d "/opt/homebrew/opt/boost" ]; then
    echo "警告: Boost库未安装或路径不正确"
    echo "请执行: brew install boost"
    echo "或者手动修改CMakeLists.txt中的Boost路径"
    exit 1
fi

echo "创建构建目录..."
mkdir -p build
cd build

echo "配置CMake项目..."
cmake ..

if [ $? -eq 0 ]; then
    echo "编译项目..."
    make -j$(sysctl -n hw.ncpu)
    
    if [ $? -eq 0 ]; then
        echo ""
        echo "✅ 编译成功!"
        echo "可执行文件: $(pwd)/webrtc_server_demo"
        echo ""
        echo "运行命令: ./webrtc_server_demo"
        echo "服务器将在端口9002启动"
    else
        echo ""
        echo "❌ 编译失败，请检查错误信息"
    fi
else
    echo ""
    echo "❌ CMake配置失败"
    echo "可能需要安装缺失的依赖:"
    echo "1. brew install boost"
    echo "2. brew install asio"
    echo "3. 确保Xcode命令行工具已安装"
fi
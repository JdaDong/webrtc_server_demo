# WebRTC信令服务器安装指南

## 依赖安装

### 1. 安装Homebrew（如果尚未安装）
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. 安装必要的依赖库
```bash
# 安装Boost
brew install boost

# 安装websocketpp
brew install websocketpp

# 或者手动安装websocketpp
git clone https://github.com/zaphoyd/websocketpp.git /usr/local/websocketpp
```

### 3. 设置环境变量（如果需要）
```bash
export CPATH=/usr/local/include:/opt/homebrew/include
export LIBRARY_PATH=/usr/local/lib:/opt/homebrew/lib
```

## 编译项目

### 方法一：使用CMake（推荐）
```bash
mkdir -p build
cd build
cmake ..
make -j4
```

### 方法二：直接使用g++编译
```bash
g++ -std=c++17 -I/usr/local/include -I/opt/homebrew/include \
    -L/usr/local/lib -L/opt/homebrew/lib \
    -lboost_system -lpthread \
    main.cpp -o webrtc_server
```

### 方法三：简化编译（无依赖测试）
```bash
g++ -std=c++17 test_compile.cpp -o test_server -pthread
```

## 运行服务器

```bash
# 运行完整版本（需要先安装依赖）
./build/webrtc_server_demo

# 或者运行简化测试版本
./test_server
```

## 验证安装

运行测试程序确认环境正常：
```bash
./test_server
```
应该输出：
```
简易服务器启动成功!
编译环境测试通过
多线程测试通过
```

## 故障排除

### 常见问题1：Boost库找不到
```bash
# 设置Boost路径
export BOOST_ROOT=/opt/homebrew/opt/boost
```

### 常见问题2：头文件找不到
```bash
# 检查头文件路径
find /usr -name "websocketpp" 2>/dev/null
find /opt -name "websocketpp" 2>/dev/null
```

### 常见问题3：链接错误
确保链接了所有必要的库：
- boost_system
- pthread

## 端口配置

服务器默认运行在端口9002，可以在main.cpp中修改。
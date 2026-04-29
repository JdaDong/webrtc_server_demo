cmake_minimum_required(VERSION 3.31)
project(webrtc_server_demo)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# 只需要线程库
find_package(Threads REQUIRED)

# 编译简化版本
add_executable(simple_server simple_server.cpp)

# 链接线程库
target_link_libraries(simple_server
    PRIVATE
    Threads::Threads
)

# 可选：保留原始版本（需要安装依赖后使用）
# add_executable(webrtc_server_demo main.cpp)
# target_link_libraries(webrtc_server_demo PRIVATE Threads::Threads)
#include <iostream>
#include <thread>
#include <mutex>

using namespace std;

class SimpleServer {
public:
    void start() {
        cout << "简易服务器启动成功!" << endl;
        cout << "编译环境测试通过" << endl;
        
        // 测试多线程
        mutex mtx;
        thread t([&mtx]() {
            lock_guard<mutex> lock(mtx);
            cout << "多线程测试通过" << endl;
        });
        t.join();
    }
};

int main() {
    SimpleServer server;
    server.start();
    return 0;
}
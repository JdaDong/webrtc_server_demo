# WebRTC信令服务器

这是一个基于C++和websocketpp实现的WebRTC信令服务器，用于处理WebRTC客户端之间的信令交换。

## 功能特性

- ✅ WebSocket连接管理
- ✅ 房间管理（多用户房间）
- ✅ SDP Offer/Answer转发
- ✅ ICE候选信息转发
- ✅ 多线程安全

## 消息格式

### 加入房间
```json
{
  "type": "join",
  "roomId": "room123"
}
```

### 发送Offer
```json
{
  "type": "offer",
  "sdp": "v=0\r\no=- 1234567890 2 IN IP4 127.0.0.1\r\n..."
}
```

### 发送Answer
```json
{
  "type": "answer", 
  "sdp": "v=0\r\no=- 9876543210 2 IN IP4 127.0.0.1\r\n..."
}
```

### 发送ICE候选
```json
{
  "type": "ice-candidate",
  "candidate": "candidate:1234567890 1 udp 2122260223 192.168.1.1 54321 typ host"
}
```

## 构建和运行

### 依赖安装

1. 安装Boost库:
```bash
brew install boost
```

2. 安装websocketpp:
```bash
# 使用vcpkg
vcpkg install websocketpp

# 或者手动下载
git clone https://github.com/zaphoyd/websocketpp.git
```

### 编译
```bash
mkdir build && cd build
cmake ..
make
```

### 运行
```bash
./webrtc_server_demo
```

服务器将在端口9002上启动。

## 客户端使用示例

WebRTC客户端可以使用以下代码连接到信令服务器：

```javascript
const ws = new WebSocket('ws://localhost:9002');

// 加入房间
ws.send(JSON.stringify({
  type: 'join',
  roomId: 'test-room'
}));

// 发送Offer
ws.send(JSON.stringify({
  type: 'offer',
  sdp: offerSdp
}));

// 处理收到的消息
ws.onmessage = (event) => {
  const message = JSON.parse(event.data);
  switch (message.type) {
    case 'offer':
      // 处理收到的offer
      break;
    case 'answer':
      // 处理收到的answer  
      break;
    case 'ice-candidate':
      // 处理ICE候选
      break;
  }
};
```

## 架构说明

- **SignalingServer**: 主服务器类，处理WebSocket连接和消息分发
- **RoomManager**: 房间管理类，维护房间和用户映射关系
- 支持多房间并发，线程安全

## 端口配置

默认端口：9002
可以在main.cpp中修改端口号。# webrtc_server_demo

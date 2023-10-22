# Hertz
Hertz [həːts] 是一个 Golang 微服务 HTTP 框架，具有高易用性、高性能、高扩展性等特点。如果对微服务性能有要求，又希望框架能够充分满足内部的可定制化需求，Hertz 会是一个不错的选择。

Hertz 由字节跳动开源

## 快速开始
https://www.cloudwego.io/zh/docs/hertz/getting-started/

Hertz 开发环境准备、快速上手与代码生成工具 hz 基本使用。

### 快速上手
按文档步骤，快速上手 Hertz。编写一个简单的 HTTP 服务。完成后启动服务，访问
```shell
curl http://127.0.0.1:8888/ping
```

可以看到返回
```
{"message":"pong"}
```

### 代码自动生成工具 hz
Hertz 提供了代码自动生成工具 hz

首先，删除上一步的所有 go 代码。准备使用 hz 代码生成工具来生成项目的脚手架

#### 安装命令行工具 hz
```shell
go install github.com/cloudwego/hertz/cmd/hz@latest
```

#### 生成项目脚手架
```shell
# 在 GOPATH 外执行，需要指定 go mod 名
hz new -module hertz_demo

# 整理 & 拉取依赖
go mod tidy
```

启动项目
```shell
go run .
```

访问
```shell
curl http://127.0.0.1:8888/ping
```

可以看到返回
```
{"message":"pong"}
```



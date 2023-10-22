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

#### 通过指定已经定义好的 idl 文件进行代码生成
首先，创建 idl/thrift/hello.thrift 文件，内容如下:
```thrift
service HelloService {
    string Hello(1: string name) (api.get="/hello");
}
```
!!注意，官网这里的 idl 文件有误，需要修改成上面这样（添加了 (api.get="/hello") ）。否则生成的代码不完整，不能正常运行。


因为本项目已经是一个 Hertz 项目，所以使用 idl，应该使用 `hz update` 命令
```shell
hz update -idl idl/thrift/hello.thrift
```

反之，如果我们上面并没有使用 `hz new` 命令创建项目，而是想通过 idl 文件创建项目，那么应该使用 `hz new -idl` 命令
```shell
hz new -module hertz_demo -idl idl/thrift/hello.thrift
```

可以看到，biz 目录下已经生成了各种代码。

启动项目
```shell
go run .
```
（如果项目依赖有问题，执行一下 `go mod tidy`）

可以看到，服务已经启动，但是访问 /hello 会报错
```shell
curl  http://127.0.0.1:8888/hello?name=LiLei
```

因为 hello_service.go 中生成的代码，默认是绑定 json 格式的请求。我们现在是 get 请求，不带请求体，需要从 url 中获取参数。所以我们修改一下:
```go
func Hello(ctx context.Context, c *app.RequestContext) {
	// 从请求中获取参数
	name := c.Query("name")

	if name == "" {
		name = "World"
	}

	c.JSON(consts.StatusOK, map[string]string{"msg": "Hello, " + name})
}
```

重新启动项目，访问
```shell
curl  http://127.0.0.1:8888/hello?name=LiLei
```
可以看到，正常返回
```
{"msg":"Hello, LiLei"}
```


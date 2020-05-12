### 1. TCP/IP 协议（搞清楚Socket）
* 应用层（web服务）
* 网络层，数据链路层，物理层
    * 提供点到点的服务。
    * 提供了一台主机到另一台主机之间的通信，不涉及程序或者进程的概念。不会保证数据传输的可靠性，不能说明主机之间那两个进程来通信
* 传输层
    * 提供端到端端服务。
    * 建立在点到点的通信端基础之上，完成应用程序（进程）之间的通信。
    * 这里的端也就是套接字(socket), 所谓套接字，也就是一个通信端点，每个套接字都有一个套接字序号，包括主机的IP地址与一个主机端口号
    * 总之套接字Socket =（IP地址：端口号）

### 2. 简单的scoket 通信程序 
* example1 目录
### 3. 构建简单的request/response 模型
* http 协议报文
    * 请求
    ![图例](http://bajiudongfeng.top:8080//uploads/image/Article/43/cdc4dbbb-f98e-31d5-8270-3c37bf1c54e5.jpg)
        * 请求行
            * 请求方法 请求URL HTTP协议以及版本
            * 例如 GET /orders/17 HTTP/1.1\r\n
        * 请求头
            * 其实就是header 格式为 属性名称:属性值。例如Accept Cache-Control Connection Cookie Host User-Agent
        * 空行
            * 发送回车符和换行符，通知服务器以下不再有请求头.
        * 请求体
            * 例如：name=tom&password=1234
    * 响应
    ![例子](http://bajiudongfeng.top:8080//uploads/image/Article/44/20170707145557633.jpeg)
        * 响应行
            * HTTP协议以及版本 状态码描述
            * 例如 HTTP/1.1 200 OK
        * 响应头
            * 多个属性组成
            * 例如Content-Type: application/json
        * 空行
        * 响应体
            * 真正的数据
            * `{code: 0, msg: 'success', data:{ a: '1', b: '2'}}`
### 4. 最小化的ruby http server
* example2 目录。

### 5. rack 简单介绍
* rack 是一个最小化的接口，介于基于rack的应用程序和基于rack的应用服务器.只要都遵循这个规则，就可以随意搭配使用。
* rake 应用程序rails Sinatra
* rake 应用服务区 webrick puma unicorn
* 想要使用rack,需要提供一个对象：　这个对象可以调用call方法，可以接受一个 hash作为参数，需要返回一个数组,这个数组包含三部分．
    * 一个http 相应代码
    * 一个hash的头部信息
    * 一个数组类型的响应主体

example3 目录
### 6. rack 提供了那些基本的middleware
* x-runtime 请求消耗时间ruby-china 主请求
* etag http缓存，减少数据传输消耗的时间。在header中加入etag例如js文件，不需要每次都传输，只需要比较md5 的值即可。
* ConditionalGet 用于比较etag，返回304
* request 来源于env 简单看下代码.（lib/rack/request.rb）

### 6. rack 在rails 中的应用。

* rails middleware 查看都用了那些
    * 在application.rb 中增加，减少。
        * config.middleware.insert_before
        * config.middleware.use 
*  config.ru  文件(rails s 的过程哪里使用到了此文件 https://ruby-china.github.io/rails-guides/initialization.html) 
* rackup(http://rack.github.io/) 启动 config.ru，研究webrick是如何和应用关联起来的。
        `/Users/dongfeng/.rvm/gems/ruby-2.6.3@mega-crm-api/gems/rack-2.0.7/bin`
        ```
        #!/usr/bin/env ruby
        require "rack"
        Rack::Server.start
        ```
    * 可以读下相关代码。
    * 扩展阅读 rails s 启动过程 https://ruby-china.github.io/rails-guides/initialization.html
### 7. WEBrick 原理留在以后再讲。
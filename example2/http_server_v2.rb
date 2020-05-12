require 'socket'

app = Proc.new do |_env|
  p "env: #{_env}"
  ['200', { 'Content-Type': 'text/html' }, ["hello world #{Time.now}"]]
end

# http://localhost:5678/?a=1&b=2
# 打印env,env包装了请求的信息。
class WEBrickDemo
  class << self
    def run(proc)
      server = TCPServer.new 5678
      loop do
        tcp_socket = server.accept
        req = tcp_socket.gets
        puts req

        method, full_path = req.split(' ')
        path, query = full_path.split('?')

        # 这里为啥要传递参数呢？其实是env
        # https://www.rubydoc.info/github/rack/rack/file/SPEC#The_Environment
        status, headers, body = proc.call(
          'REQUEST_METHOD': method,
          'PATH_INFO': path,
          'QUERY_STRING': query
        )

        tcp_socket.print "HTTP/1.1 #{status} OK\r\n"
        headers.each do |key, val|
          tcp_socket.print "#{key}:#{val}\r\n"
        end
        tcp_socket.print "\r\n"
        body.each do |part|
          tcp_socket.print "#{part}\r\n"
        end

        tcp_socket.close
      end
    end
  end
end

WEBrickDemo.run(app)
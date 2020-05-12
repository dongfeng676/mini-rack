require 'socket'
server = TCPServer.new 5678

app = Proc.new do
  ['200', { 'Content-Type': 'text/html' }, ["Hello world #{Time.now}!"]]
end

while tcp_socket = server.accept
  req = tcp_socket.gets
  puts req
  status, headers, body = app.call

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

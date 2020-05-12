require 'socket'
server = TCPServer.new 5678

while tcp_socket = server.accept
  req = tcp_socket.gets
  puts req
  puts '*' * 10

  tcp_socket.print "HTTP/1.1 200 OK\r\n" # 1
  tcp_socket.print "Content-Type: text/html\r\n" # 2
  # tcp_socket.print "Content-Type: application/json\r\n" # 2
  tcp_socket.print "\r\n" # 3
  tcp_socket.print "Hello world! The time is #{Time.now}" #4
  # tcp_socket.print "{code: 0, data: {a: '2'}}"

  tcp_socket.close
end

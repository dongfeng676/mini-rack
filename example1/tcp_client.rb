require 'socket'
# Opens a TCP connection.
tcp_socket = TCPSocket.new 'localhost', 5678

while data = tcp_socket.gets
  puts data
end

tcp_socket.close

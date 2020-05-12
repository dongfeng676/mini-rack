require 'socket'
# Creates a new server socket bound to port.
tcp_server = TCPServer.new 5678

loop do
  # Accepts an incoming connection. It returns a new TCPSocket object.
  tcp_socket = tcp_server.accept
  tcp_socket.puts "Hello world! The time is #{Time.now}"
  tcp_socket.puts "This is socket code !"
  tcp_socket.close
end

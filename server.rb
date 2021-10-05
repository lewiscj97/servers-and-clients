require 'socket'

server = TCPServer.new(2345)

loop do
  socket = server.accept
  puts 'Something has connected'
  socket.puts "HELLO CLIENT WHAT IS YOUR NAME?"
  name = socket.gets.chomp
  socket.puts "THAT'S A LOVELY NAME #{name}"
  
  socket.close  
end
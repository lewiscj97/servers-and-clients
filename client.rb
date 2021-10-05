require 'socket'

socket = TCPSocket.new('localhost', 2345)

puts socket.gets
puts "Wow what a rude server... My name is: "
name = gets.chomp
socket.puts name.upcase
puts socket.gets

socket.close
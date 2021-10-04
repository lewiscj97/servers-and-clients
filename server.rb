require 'socket'

# Specifies the port
server = TCPServer.new(2345)

# This keeps the server running when people disconnect
while true
  # This threading is so multiple users can interact with the server
  Thread.start(server.accept) do |s|
    # Prints to the console when something connects
    puts("Something has connected")
    # Prints to the client
    s.puts("What do you say!")
    # Gets user input and displays
    while input = s.gets.chomp
      s.puts("You said: #{input}")
      s.puts("What do you say!")
      s.close if input == "exit"
    end
    # When they disconnect
    puts("They've gone!")
  end
end

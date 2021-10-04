require 'socket'

class Notes
  def initialize
    @server = TCPServer.new(2345)
    @notes = []
  end

  def main
    while true
      Thread.start(@server.accept) do |s|
        puts("Something has connected")
        s.puts("1. Enter note\n2. View notes\n0. Exit")
        while input = s.gets.chomp
          break if input == "0"
          s.puts "Please enter a correct option" if input != "1" || input != "2"
          s.puts("1. Enter note\n2. View notes\n0. Exit")
          s.puts(input)
        end
        s.close
        puts("They've gone!")
      end
    end
  end
end

app = Notes.new
app.main
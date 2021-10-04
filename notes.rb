require 'socket'

class Notes
  def initialize
    @server = TCPServer.new(2345)
    @notes = []
    start_server
  end

  def start_server
    while true
      Thread.start(@server.accept) do |s|
        puts("Something has connected")
        s.puts("1. Enter note\n2. View notes\n0. Exit")
        while input = s.gets.chomp
          break if input == "0"
          s.puts("1. Enter note\n2. View notes")
          s.puts(input)
        end
        s.close
        puts("They've gone!")
      end
    end
  end
end

Notes.new
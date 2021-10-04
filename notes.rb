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
        header

        while input = s.gets.chomp
          header
          case input.to_i
          when 0
            break
          when 1
            s.puts("Enter note")
          when 2
            s.puts("View notes")
          else
            s.puts("Please enter a correct option")
          end
        end
        s.close
        puts("They've gone!")
      end
    end
  end

  def view_notes
    # Write this
  end

  def add_note
    # Write this
  end

  private

  def header
    s.puts("1. Enter note\n2. View notes\n0. Exit")
  end
end

app = Notes.new
app.main
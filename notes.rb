require 'socket'

class Notes
  def initialize
    @server = TCPServer.new(2345)
    @notes = []
  end

  def main
    loop do
      Thread.start(@server.accept) do |s|
        puts('Something has connected')
        header(s)
        while (input = s.gets.chomp)
          case input.to_i
          when 0
            s.close
            break
          when 1
            add_note(s)
            header(s)
          when 2
            view_notes(s)
            header(s)
          else
            s.puts('Please enter a correct option')
          end
        end
        puts("They've gone!")
      end
    end
  end

  private

  def header(server)
    server.puts("1. Enter note\n2. View notes\n0. Exit")
  end

  def view_notes(server)
    server.print("\n")
    server.puts('Notes:')
    server.puts(@notes.join("\n"))
    server.print("\n")
  end

  def add_note(server)
    server.print("\n")
    server.print('Note: ')
    @notes << server.gets.chomp
    server.puts('Note added')
    server.print("\n")
    puts('Note added')
  end
end

app = Notes.new
app.main

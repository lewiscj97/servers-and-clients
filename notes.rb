require 'socket'

# To run: telnet localhost 2345
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
        logic(s)
        puts("They've gone!")
      end
    end
  end

  private

  def logic(server)
    while (input = server.gets.chomp)
      case input.to_i
      when 0
        server.close
        break
      when 1
        add_note(server)
      when 2
        view_notes(server)
      else
        server.puts('Please enter a correct option')
      end
    end
  end

  def header(server)
    server.puts("1. Enter note\n2. View notes\n0. Exit")
  end

  def view_notes(server)
    server.print("\n")
    server.puts('Notes:')
    server.puts(@notes.join("\n"))
    server.print("\n")
    header(server)
  end

  def add_note(server)
    server.print("\n")
    server.print('Note: ')
    @notes << server.gets.chomp
    server.puts('Note added')
    server.print("\n")
    puts('Note added')
    header(server)
  end
end

app = Notes.new
app.main

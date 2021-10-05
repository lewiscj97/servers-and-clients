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
      when 3
        delete_note_option(server)
      else
        server.puts('Please enter a correct option')
      end
    end
  end

  def header(server)
    server.puts("1. Enter note\n2. View notes\n3. Delete note\n0. Exit")
  end

  def delete_note_option(server)
    server.puts("Type the number of the note to be deleted: ")
    note_index = server.gets.chomp.to_i - 1
    deleting_note(server, note_index)
    server.print("\n")
    header(server)
  end

  def deleting_note(server, note_index)
    if @notes[note_index].nil?
      no_note_at_index(server)
    else
      note_at_index(server, note_index)
    end
  end

  def note_at_index(server, note_index)
    note = @notes.delete_at(note_index)
    server.print("\n")
    server.puts "Note deleted: #{note}"
    puts "Note deleted"
  end

  def no_note_at_index(server)
    server.print("\n")
    server.puts('There is no note at that index')
  end

  def view_notes(server)
    server.print("\n")
    @notes.empty? ? no_notes_to_show(server) : notes_to_show(server)
    header(server)
  end

  def notes_to_show(server)
    server.puts('Notes:')
    indexed_notes = @notes.map.with_index(1) { |note, index| "#{index}. #{note}" }
    server.puts(indexed_notes.join("\n"))
    server.print("\n")
  end

  def no_notes_to_show(server)
    server.puts('There are currently no notes!')
    server.print("\n")
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

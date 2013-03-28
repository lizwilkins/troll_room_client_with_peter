require 'timeout'
require 'faraday'
require 'json'
require './lib/message'
require './lib/room'

time = 0 
choice = nil
puts "Enter 'r' to create a new chat room."
puts "Enter 'c' to create a new post."
puts "Enter 's' to select a chat room."
puts "Enter 'x' to exit."

room = nil
loop do
  puts "Welcome to the Chatty Cathy."
  until choice == 'c' || choice == 'r' || choice == 'e' || choice == 'x'
    if room != nil
      messages = room.messages
      puts "\e[H\e[2J"
      puts "\nYou are in the #{room.name} Chat Room:\n"
      messages.map {|message| puts "> #{message.name}:  #{message.message}"}
    end
    puts "\nEnter 'c' to create a new post, 'r' to create a new chat room, 'e' to enter a new chat room, 'x' to exit."

    begin
      Timeout.timeout(1) {choice = gets.chomp}    
    rescue
    end
  end

  if choice == 'c'
    if room != nil
      print 'Type your name and press enter:'
      name = gets.chomp
      print 'Type your message and press enter:'
      message = gets.chomp
      Message.create('name' => name, 'message' => message, 'room_id' => room.id)
      choice = nil
    else
      print "Enter 'e' to select a chat room."
      choice = gets.chomp
    end
  elsif choice == 'r'
    rooms = Room.list
    puts "ID  Chat Room"
    rooms.map {|room| puts "#{rooms.id} #{rooms.name}"}
    print 'Type your new chat room name and press enter:'
    name = gets.chomp
    room = Room.create('name' => name)
    choice = nil
  elsif choice == 'e'
    rooms = Room.list
    puts "ID  Chat Room"
    rooms.map {|room| puts "#{room.id} #{room.name}"}
    print 'Enter the ID of your new chat room and press enter:'   
    room = Room.find(gets.chomp)
    choice = nil
  elsif choice == 'x'
    break
  end
end
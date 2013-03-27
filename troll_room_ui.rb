require 'timeout'
require 'faraday'
require 'json'
require './lib/message'

puts "Welcome to the Troll Room."
time = 0 
choice = nil
puts "What would you like to do?"
puts "Enter 'c' to create a new post"
puts "Enter 'x' to exit."

loop do
  until choice == 'c' || choice == 'x'
    messages = Message.list
    puts "\e[H\e[2J"
    messages.map {|message| puts "> #{message.name}:  #{message.message}"}
    puts "Enter 'c' to create a new post, 'x' to exit."

    begin
      Timeout.timeout(1) {choice = gets.chomp}    
    rescue
    end
  end

  if choice == 'c'
    print 'Type your name and press enter:'
    name = gets.chomp
    print 'Type your message and press enter:'
    message = gets.chomp
    Message.create('name' => name, 'message' => message)
    puts 'Nice message. Good-bye!'
  elsif choice == 'x'
    break
  end
  choice = nil
end


#welcome

#loop do 
  #   #if wait 
  #   if timeout?
  #     messages = Message.all
  #   elsif choice == 'x'
  #     break
  #   elsif choice == 'c'
  #     create
  #   elsif choice == 'v'
  #     puts "Here are the 20 most recent posts:"
  #     messages.map {|message| puts (message.name + ": " + message.message)}

  #   end
  # end
# def create
#   name = nil
#   message = nil
#   while message.nil?
#     puts "What name would you like include in your post?"
#     name = gets.chomp
#     puts "What is the message you would like to post to Troll Room?"
#     message = gets.chomp
#     new_name = Message.new({:name => name, :message => message})
#     message.save
#   end    
#   #Test if message was posted and say hurray!
# end
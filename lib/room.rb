class Room

   attr_reader :name, :id

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
  end

  def self.create(attributes)
    post_message = Faraday.post do |request|
      request.url 'http://localhost:3000/rooms'  
      request.headers['Content-Type'] = 'application/json'
      request.body = {:room => {:name => attributes['name']}}.to_json
    end
  end

  def self.list
    get_rooms = Faraday.get do |request|
      request.url 'http://localhost:3000/rooms'  
      request.body = {:limit => 20}.to_json
    end
    if get_rooms.body.nil?
      false
    else
      p get_rooms
      JSON.parse(get_rooms.body).inject([]) do |rooms_array, room|        
        rooms_array << Room.new(:name => room['room']['name'], :id => room['room']['id'])
      end
    end
  end

  def messages
    get_messages = Faraday.get do |request|
      request.url 'http://localhost:3000/messages'  
      request.body = {:limit => 20, :room_id => @id}.to_json
    end
    if get_messages.body.nil?
      false
    else
      JSON.parse(get_messages.body).inject([]) do |messages_array, message|        
        messages_array << Message.new(:name => message['message']['name'], :message => message['message']['message'])
      end
    end
  end


  def self.find(id)
    response = Faraday.get "http://localhost:3000/rooms/#{id}"
    chat_room = JSON.parse(response.body)
    room = Room.new(:name => chat_room['room']['name'], :id => chat_room['room']['id'])
  end

end
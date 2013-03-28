class Message

  attr_reader :name, :message, :room_id

  def initialize(attributes)
    @name = attributes[:name]
    @message = attributes[:message]
    @room_id = attributes[:room_id]
    
  end

  def self.create(attributes)
    post_message = Faraday.post do |request|
      request.url 'http://localhost:3000/messages'  
      request.headers['Content-Type'] = 'application/json'
      request.body = {:message => {:name => attributes['name'], :message => attributes['message'], :room_id => attributes['room_id']}}.to_json
    end
  end

end
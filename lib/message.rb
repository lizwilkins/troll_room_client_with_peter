class Message

  attr_reader :name, :message

  def initialize(attributes)
    @name = attributes[:name]
    @message = attributes[:message]
    
  end

  def self.create(attributes)
    post_message = Faraday.post do |request|
      request.url 'http://trollroom.herokuapp.com/messages'  
      request.headers['Content-Type'] = 'application/json'
      request.body = {:message => {:name => attributes['name'], :message => attributes['message']}}.to_json
    end
  end

  def self.list
    get_messages = Faraday.get do |request|
      request.url 'http://trollroom.herokuapp.com/messages'  
      request.body = {:limit => 20}.to_json
    end
    if get_messages.body.nil?
      false
    else
      JSON.parse(get_messages.body).inject([]) do |messages_array, message|        
        messages_array << Message.new(:name => message['message']['name'], :message => message['message']['message'])
      end
    end
  end
end
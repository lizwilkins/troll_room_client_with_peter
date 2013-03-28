describe Room do

  context 'initialize' do
    it 'initializes a room with a name' do
      room = Room.new(:name => "Epicodus Chat Room")
      room.should be_an_instance_of Room
    end
  end

  context 'readers' do
    it 'should read the name of the room' do
      room = Room.new(:name => "bobby", :id => 2)
      room.name.should eq 'bobby'
    end
  

    it 'should read the room id of the room' do
      room = Room.new(:name => "bobby", :id => 2)
      room.id.should eq 2
    end
  end

 context '.create' do
    it 'POSTs a new room containing a name to the Room table' do 
      attributes = {:name => "Barry's Room"}
      stub = stub_request(:post, 'http://localhost:3000/rooms').to_return(:status => 200, :body => {:room => attributes}.to_json)
      Room.create(attributes)
      stub.should have_been_requested
    end
  end

  context '.list' do
    it 'request GETs from the database' do
      stub = stub_request(:get, 'http://localhost:3000/rooms').to_return(:status => 200)
      Room.list
      stub.should have_been_requested
    end
  end

  context 'messages' do
    it 'request GETs from the database' do
      # (1..2).each {|num| Message.create(:name => "name#{num}", :message =>  "message#{num}", :room_id => 1)}
      # stub = stub_request(:post, 'http://localhost:3000/messages').to_return(:status => 200)

      attributes = {:name => 'name1', :message => 'message1', :room_id => 1}
      stub = stub_request(:post, 'http://localhost:3000/messages').to_return(:status => 200, :body => {:message => attributes}.to_json)
      stub = stub_request(:post, 'http://localhost:3000/messages').to_return(:status => 200, :body => {:message => attributes}.to_json)
      room = Room.new(:name => 'hio', :id => 1)
      stub = stub_request(:get, 'http://localhost:3000/messages').to_return(:status => 200)
      messages = room.messages
      stub.should have_been_requested
      # messages.should eq [{:name => "name1", :message =>  "message1", :room_id => 1}, {:name => "name1", :message =>  "message1", :room_id => 1}]
    end
  end
    
  context '.find' do 
    it 'requests the chat room name from the server for a given ID' do 
      id = 13
      stub = stub_request(:get, "http://localhost:3000/rooms/13").
         to_return(:status => 200, :body => {:room => {:id => 13, :name => 'foo'}}.to_json)
      Room.find(13)
      stub.should have_been_requested
    end
  end
end
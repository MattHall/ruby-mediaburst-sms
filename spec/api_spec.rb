require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + '/../lib/mediaburst'

module Mediaburst
  describe "creating an instance" do
    it "should initialise with a username and password" do
      Mediaburst::API.new('Username', 'Password').should_not be_nil
    end
  end
  
  
  describe "if the server has gone away" do
    it "should throw a ServerError exception" do
      client = Mediaburst::API.new('username', 'password')
      stub_request(:post, Mediaburst::ENDPOINT).to_return(:status => [500, "Internal Server Error"])
      
      lambda do
        client.send_message('1234567890', 'test')
      end.should raise_error(Mediaburst::ServerError)
    end
  end
  
  
  describe "with invalid requests" do
    it "should throw an InvalidRequest exception" do
      client = Mediaburst::API.new('username', 'password')
      stub_request(:post, Mediaburst::ENDPOINT).to_return(:status => 200, :body => File.open(File.dirname(__FILE__) + '/fixtures/invalid_response.xml', "r").read)
      
      lambda do
        client.send_message('1234567890', 'test')
      end.should raise_error(Mediaburst::InvalidRequest)
    end
  end
  
  
  describe "creating XML" do
    describe "concat parameter" do
      before(:each) do
        @client = Mediaburst::API.new('username', 'password')
      end
      
      it "should add the concat parameter to the XML is passed in" do
        xml = @client.create_xml('1234567890', 'test', :Concat => 3)
        (xml =~ /<Concat>3<\/Concat>/).should_not be_nil
      end
    
      it "should not add the concat parameter if not requested" do
        xml = @client.create_xml('1234567890', 'test', {})
        (xml =~ /<Concat>3<\/Concat>/).should be_nil
      end
    end
    
    describe "authentication" do
      before(:each) do
        @client = Mediaburst::API.new('username', 'password')
        @xml = @client.create_xml('1234567890', 'test', {})
      end
      
      it "should add the username" do
        (@xml =~ /<Username>username<\/Username>/).should_not be_nil
      end
      
      it "should add the password" do
        (@xml =~ /<Password>password<\/Password>/).should_not be_nil
      end
    end
  end
  
  
  
  describe "parsing the response" do
    before(:each) do
      stub_request(:post, Mediaburst::ENDPOINT).to_return(:status => 200, :body => File.open(File.dirname(__FILE__) + '/fixtures/mixed_response.xml', "r").read)
      @client = Mediaburst::API.new('username', 'password')
      @response = @client.send_message('1234567890', 'test')
    end
    
    it "should indicate success in the returned hash" do
      @response['441234567890'].should be_true
    end
    
    it "should describe the error message on failure" do
      @response['441234567891'].should eql(10)
    end
  end
  
end
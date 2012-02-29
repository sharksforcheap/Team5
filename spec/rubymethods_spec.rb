require File.expand_path(File.dirname(__FILE__) + '/../lib/rubymethods')

require 'fakeweb'

describe RubyMethods do
  before(:each) do
   FakeWeb.register_uri(:get, "http://ruby-doc.org/core-1.9.3/", 
                        :body => open("./spec/Cached_Ruby_Core/cached_1.9.3_page.html").read )
   FakeWeb.register_uri(:get, "http://ruby-doc.org/core-1.9.2/", 
                        :body => open("./spec/Cached_Ruby_Core/cached_1.9.2_page.html").read )
  end
  
  it "should return an empty hash given an empty input" do
    info = RubyMethods.new("")
    info.method_hash.should == {}
  end
  
  it "should convert a page into a hash with methods as keys and array of classes as values" do
    info = RubyMethods.new("http://ruby-doc.org/core-1.9.3/")
    info.method_hash["basename"].should == ["File"]
  end

  it "should return nil if method_hash is asked for an array it did not find" do
    info = RubyMethods.new("http://ruby-doc.org/core-1.9.3/")
    info.method_hash["frog"].should == nil
  end
  
end

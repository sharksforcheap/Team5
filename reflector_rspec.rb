require "./reflector.rb"

describe "SourceCode"  do
    before :each do
      @doc = SourceCode.new('test.rb')
    end
    it "should create an array for storing a sourcecode file" do
      @doc.should be_an_instance_of(SourceCode)
    end
    
    it "#method_extraction should return an array of methods" do
      @doc.method_extraction.should == ['reverse','split']
    end
    
    
    
    
    
    
    
    
    it "#method_extraction should pull out the methods and return them in a hash"





  # 
  #   it "should instantiate a new object with class relfector" do
  #     Reflector.new.should be_an_instance_of(Reflector)
  #   end
  # 
  #   describe "#parse_for_methods" do
  #   it "should read a file" do
  # 
  #     Reflector.new.parse_for_methods('test.rb').should be_a_kind_of(Array)
  #   end
  # 
  #   it "should split the test file" do 
  #     Reflector.new.parse_for_methods('test.rb').should == ['def', 'hello','end']
  #   end
  # 
  # end
end
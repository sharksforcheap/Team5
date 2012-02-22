require "./reflector.rb"

describe "SourceCode"  do
    before :each do
      @doc = SourceCode.new('test.rb')
    end
    it "#should create an array for storing a sourcecode file" do
      @doc.should be_an_instance_of(SourceCode)
    end
    
    it "#count_methods should return an array of methods" do
      input_hash = {'reverse'=>['string','hash','array'], 'split'=>['string'], 'each'=>['array', 'hash'], 'find'=>['array']}
      @doc.count_methods(input_hash).should == {"reverse"=>1, "each"=>2, "split"=>1, "find"=>1}
    end





  

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
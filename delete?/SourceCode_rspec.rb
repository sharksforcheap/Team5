require "./SourceCode.rb"

describe "SourceCode"  do
    before :each do
      @doc = SourceCode.new('test.rb')
      @input_hash = {'reverse'=>['string','hash','array'], 'split'=>['string'], 'each'=>['array', 'hash'], 'find'=>['array']}
    end
    it "#should create an array for storing a sourcecode file" do
      @doc.should be_an_instance_of(SourceCode)
    end
    
    it "#count_methods should return an array of methods" do
      @doc.count_methods(@input_hash).should == {"reverse"=>1, "each"=>2, "split"=>1, "find"=>1}
    end

    it "should be able to instantiate through factory method on single file" do
      code_obj = SourceCode.from_file('test.rb')
      code_obj.count_methods(@input_hash)
      code_obj.parts_list.should == {"reverse"=>1, "each"=>2, "split"=>1, "find"=>1}
    end
    
    it "should be able to instantiate through factory method on directory" do
      code_obj = SourceCode.from_dir('./test_input_directory')
      code_obj.count_methods(@input_hash)
      code_obj.parts_list.should == {"reverse"=>2, "each"=>4, "split"=>2, "find"=>2}
    end
    
    it "should be able to instantiate through factory method on directory if given with final slash" do
      code_obj = SourceCode.from_dir('./test_input_directory/')
      code_obj.count_methods(@input_hash)
      code_obj.parts_list.should == {"reverse"=>2, "each"=>4, "split"=>2, "find"=>2}
    end
    
    it "should be able to instantiate through factory method on directory with subdirectories" do
      code_obj = SourceCode.from_subdir('./test_input_directory')
      code_obj.count_methods(@input_hash)
      code_obj.parts_list.should == {"reverse"=>3, "each"=>6, "split"=>3, "find"=>3}
    end

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
require "./reflector.rb"

describe "SourceCode"  do
    before :each do
      @doc = SourceCode.new('tests/test.rb')
    end
    it "should create an array for storing a sourcecode file" do
      @doc.should be_an_instance_of(SourceCode)
    end
    
    describe "#count_methods" do
      it "should return an array of methods" do
        input_hash = {'reverse'=>['string','hash','array'], 'split'=>['string'], 'each'=>['array', 'hash'], 'find'=>['array']}
        @doc.count_methods(input_hash).should == {"reverse"=>1, "each"=>2, "split"=>1, "find"=>1}
      end

      it "should return methods followed by paranthesis as part of the #count_methods array" do
        @doc = SourceCode.new('tests/test_parens.rb')
        input_hash = {'reverse'=>['string','hash','array'], 'split'=>['string'], 'each'=>['array', 'hash'], 'find'=>['array'], 'sort_by'=>['string', 'object']}
        @doc.count_methods(input_hash).should == {"sort_by"=>1, "each"=>2, "split"=>2}
      end

      it "should return an array of methods, ignoring anything commented." do
        @doc = SourceCode.new('tests/test_commenting.rb')
        input_hash = {'reverse'=>['string','hash','array'], 'split'=>['string'], 'each'=>['array', 'hash'], 'find'=>['array']}
        @doc.count_methods(input_hash).should == {"reverse"=>1, "each"=>2, "split"=>1, "find"=>1}
      end
    end
    
    describe "directory structure" do
      before :each do
        @input_hash = {'reverse'=>['string','hash','array'], 'split'=>['string'], 'each'=>['array', 'hash'], 'find'=>['array']}
      end
      it "should be able to instantiate through factory method on single file" do
        code_obj = SourceCode.from_file('test.rb')
        code_obj.count_methods(@input_hash).should == {"reverse"=>1, "each"=>2, "split"=>1, "find"=>1}
      end
    
      it "should be able to instantiate through factory method on directory" do
        code_obj = SourceCode.from_dir('./test_input_directory')
        code_obj.count_methods(@input_hash).should == {"reverse"=>2, "each"=>4, "split"=>2, "find"=>2}
      end
    
      it "should be able to instantiate through factory method on directory if given with final slash" do
        code_obj = SourceCode.from_dir('./test_input_directory/')
        code_obj.count_methods(@input_hash).should == {"reverse"=>2, "each"=>4, "split"=>2, "find"=>2}
      end
    
      it "should be able to instantiate through factory method on directory with subdirectories" do
        code_obj = SourceCode.from_subdir('./test_input_directory')
        code_obj.count_methods(@input_hash).should == {"reverse"=>3, "each"=>6, "split"=>3, "find"=>3}
      end
    end
end
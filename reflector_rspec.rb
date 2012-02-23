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
    
    it "#should return methods followed by paranthesis as part of the #count_methods array" do
      @doc = SourceCode.new('test_parens.rb')
      input_hash = {'reverse'=>['string','hash','array'], 'split'=>['string'], 'each'=>['array', 'hash'], 'find'=>['array'], 'sort_by'=>['string', 'object']}
      @doc.count_methods(input_hash).should == {"sort_by"=>1, "each"=>2, "split"=>2}
    end
    
    it "#count_methods should return an array of methods, ignoring anything commented." do
      @doc = SourceCode.new('test_commenting.rb')
      input_hash = {'reverse'=>['string','hash','array'], 'split'=>['string'], 'each'=>['array', 'hash'], 'find'=>['array']}
      @doc.count_methods(input_hash).should == {"reverse"=>1, "each"=>2, "split"=>1, "find"=>1}
    end
end

describe "Statistics" do
  before :each do
    @methods_hash = {"sort"=>3, "each"=>2, "find"=>1, "split"=>400}
  end
  it "statistics should take a hash as an input" do
    Statistics.new(@methods_hash).should be_an_instance_of(Statistics)
  end
end
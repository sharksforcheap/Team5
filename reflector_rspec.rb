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
    
end

describe "Statistics" do
  before :each do
    @methods_hash = {"sort"=>3, "each"=>2, "find"=>1, 
      "split"=>43, "reverse"=>9, "pop"=>5, "center" => 12,
      "gsub" => 40, "really_popular"=> 80, "not_at_all_popular"=>1,
      "tony"=>16, "christian"=>30, "lachy"=>17
      }
    @stats = Statistics.new(@methods_hash)
  end
  it "statistics should take a hash as an input" do
    @stats.should be_an_instance_of(Statistics)
  end
  it "should return a top 5 list" do
    @stats.top_five.should == {"really_popular" => 80, "split"=>43, "gsub"=>40, "christian"=>30, "lachy"=>17}
  end
  it "should return the outliers"
  it "should return the bottom 5 list"
  it "should return the median"
end
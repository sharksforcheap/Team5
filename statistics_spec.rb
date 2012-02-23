require "./statistics.rb"

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
  it "should return the outliers" do
    @stats.outliers.should == { A LIST OF OUTLIERS}
  end
  it "should return the bottom 5 list"
  it "should return the median"
end
require "./reflector.rb"

describe "Reflector"  do

  it "should instantiate a new object with class relfector" do
  	Reflector.new.should be_an_instance_of(Reflector)
  end
	
  describe "#parse_for_methods" do
		it "should read a file" do

	  	Reflector.new.parse_for_methods('test.rb').should be_a_kind_of(Array)
		end

		it "should split the test file" do 
			Reflector.new.parse_for_methods('test.rb').should == ['def', 'hello','end']
		end

	end
end
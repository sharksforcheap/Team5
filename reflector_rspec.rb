require "./reflector.rb"

describe "Reflector"  do

  it "should instantiate a new object with class relfector" do
  	Reflector.new.should be_an_instance_of(Reflector)
  end
	
end
require './RubyMethods.rb'

class Statistics
  def initialize(hash)
    @hash = hash
  end
  
  def top_five
    top_list(5)
  end
  
  def top_list(integer)
   @output_hash = {}
   top_x_list = @hash.sort_by {|key, value| value}.reverse[0..(integer-1)]
   top_x_list.each { |pair| @output_hash[pair[0]] = pair[1] }
   @output_hash
  end
end

class DisplayStatistics
  def initialize(statistics_hash)
    @ruby_methods = RubyMethods.new("http://ruby-doc.org/core-1.9.3/").method_hash
    @statistics_hash = statistics_hash
    @output = ""
  end
  def format_and_display
    @statistics_hash.keys.each do |method|
      method_class_string = ""
      @ruby_methods[method].each do |class_method|
          method_class_string << class_method + "   "
      end
      @output << "#{method} (#{@statistics_hash[method]}): #{method_class_string} \n"
    end
    @output
  end
end

#### Following code is for testing purposes, to retrieve the top 5 used methods and output their statsitics in a neat display.

# @methods_hash = {"sort"=>3, "each"=>2, "find"=>1, 
#   "split"=>43, "reverse"=>9, "pop"=>5, "center" => 12,
#   "gsub" => 40 }
# @stats = Statistics.new(@methods_hash)
# @stats = @stats.top_list(5)
# display = DisplayStatistics.new(@stats)
# display.format_and_display
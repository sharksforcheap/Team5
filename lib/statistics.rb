require './lib/RubyMethods.rb'

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

class MethodReport
  def initialize(statistics_hash)
    @ruby_methods = RubyMethods.new("http://ruby-doc.org/core-1.9.3/").method_hash
    @statistics_hash = statistics_hash
    @output = ""
  end
  def format_and_display(format = :raw)
    case format
    when :raw
      @statistics_hash.keys.each do |method|
        method_class_string = ""
        @ruby_methods[method].each do |class_method|
            method_class_string << class_method + "\t"
        end
        @output << "#{method} (#{@statistics_hash[method]}):\n\t#{method_class_string} \n\n"
      end
      @output
    end
  end
end 

# Process for MethodReport:
#  - Take our data and convert it to a hash that all formats can use (:raw, :json, :xml, :html)
#    + Take that hash and convert it to 'raw'
#    + Take that hash and convert it to 'json'
#    + Take the 'json' and convert it to 'xml'
#  - BOOM.
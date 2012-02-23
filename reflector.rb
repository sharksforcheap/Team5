require './RubyMethods.rb'

class SourceCode

  def initialize document
    @file = File.open(document, 'r')
    @file_lines = ''
    while line = @file.gets do      
      @file_lines += line.split("#")[0]
    end
  end
  
  def parse(string)
    string.gsub("(", ' ').gsub(")", ' ')
  end
  
  def count_methods(input_hash = {})
    @parts_list = {}
    @file_lines.gsub!(/([""'])(?:(?=(\\?))\2.)*?\1/, "")
    @file_lines = parse(@file_lines)
    puts @file_lines
    @file_lines.split.each do |line_part|
      if line_part.include?('.')
        line_part.split(".")[1..-1].each do |word|
        word = word.split("\(")[0]
          if input_hash.has_key?(word)
            @parts_list[word] = (@parts_list[word].nil? ? 1 : @parts_list[word] + 1)
          end
        end
      end
    end
    @parts_list
  end
  
end

a = SourceCode.new('./reflector.rb')
b = RubyMethods.new('http://www.ruby-doc.org/core-1.9.3/')
puts a.count_methods(b.method_hash).sort_by {|key, value| value}

class Statistics
  
end

# ignore commented code
# - The second it hits a "#" it should stop, except when the hash is followed by a "{"
# ignore strings, except when interpolated
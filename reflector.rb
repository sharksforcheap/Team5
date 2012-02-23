require './RubyMethods.rb'

class SourceCode

  def initialize document
    @file_lines = get_file_contents document
  end
  
  def get_file_contents document
    file = File.open(document, 'r')
    file_lines = ''
    while line = file.gets do      
      file_lines += line.split("#")[0]
    end
    file_lines
  end
  
  def parse(string)
    string.gsub("(", ' ').gsub(")", ' ')
  end
  
  def count_methods(input_hash = {})
    @parts_list = {}
    @file_lines.gsub!(/([""'])(?:(?=(\\?))\2.)*?\1/, "")
    @file_lines = parse(@file_lines)
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
  
  def self.from_subdir path, accumulating_object = SourceCode.new
    formatted_path = format_path(path)
    # first, iterate over subdirectories
    Dir.glob(formatted_path + "**/*").select {|s| s.end_with?(".rb")}.each do |f|
      accumulating_object.input_file(f)
    end
    accumulating_object
  end

  def self.format_path path
    path << "/" unless path.end_with?("/")
    path
  end
  
  def self.from_file filename
    SourceCode.new(filename)
  end
  
  def self.from_dir(directory)
    
  end
  
end


# ignore strings, except when interpolated
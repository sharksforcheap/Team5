class SourceCode
  
  attr_accessor :parts_list
  
  def initialize document = ""
    @raw_text = ""
    if document != ""
      input_file(document)
    end
  end
  
  def input_file document
    file = File.open(document, 'r')
    while line = file.gets do
      if @raw_text == nil
        @raw_text = line
      else
        @raw_text += line
      end
    end
  end

  def count_methods(input_hash = {})
    @parts_list = {}
    @raw_text.split.each do |line_part|
      if line_part.include?('.')
        line_part.split(".")[1..-1].each do |word|
          if input_hash.has_key?(word) 
def SourceCode.from_subdir path, accumulating_object = SourceCode.new
  formatted_path = format_path(path)
  # first, iterate over subdirectories
  Dir.glob(formatted_path + "**/*").select {|s| s.end_with?(".rb")}.each do |f|
    accumulating_object.input_file(f)
  end
  accumulating_object
end

def format_path path
  output = path
  if !path.end_with?("/")
    output << "/"
  end
  output
end

SourceCode.from_subdir("./test_input_directory")

  # @methods = []
  #  @parts_list.each do |part|
  #    puts "#" * 50
  #    puts part.class 
  #    unclean_methods = part.split
  #    puts 
  #    @methods << unclean_methods[1..-1]
  #  end
  #  @methods

  # def parse_for_methods document
  #   file = File.open(document, 'r')
  #   output_array = []
  #   while (line = file.gets)
  #     line_array = line.split
  #     line_array.each {|part| output_array << part}
  #   end
  #   output_array
  # end
  #
class SourceCode

  def initialize document
    @file = File.open(document, 'r')
    @file_lines = ''
    while line = @file.gets do
      @file_lines += line
    end
  end

  
  def count_methods
    @parts_list = {}
    @file_lines.split.each do |line_part|
      if line_part.include?('.')
        line_part.split(".")[1..-1].each do |word|
          @parts_list[word] = (@parts_list[word].nil? ? 1 : @parts_list[word] + 1)
        end
      end
    end
    @parts_list
  end
  







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

  





end
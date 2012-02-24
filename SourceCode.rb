require './RubyMethods.rb'
require 'git'

class SourceCode

  def initialize source, file_type= :file
    if file_type == :file
      @file_lines = SourceCode.get_file_contents source
    elsif file_type == :string
      @file_lines = source      
    elsif file_type == :folder
      @file_lines = SourceCode.from_dir source      
    end
  end
  
  def see_contents
    @file_lines
  end
    
  def self.get_file_contents document
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

  def self.format_path path
    path << "/" unless path.end_with?("/")
    path
  end

  def self.from_file filename
    SourceCode.new(filename)
  end
  
  def self.from_git git_repo
    repo_name = git_repo.split('/')[-2..-1].join('/').split('.')[0]
    location = './repos/' + repo_name
    begin
      Git.clone(git_repo, location)
    rescue
      SourceCode.from_dir(location)
    else
      SourceCode.from_dir(location)
    end
  end
  
  
  def self.from_dir(directory)
    formatted_path = SourceCode.format_path(directory)
    directories = Dir.glob(formatted_path + "**/*")
    directories << directory
    accumulated_contents = ''
    directories.each do |subdirectory|
      unless subdirectory.match(/\w\./)
        Dir.foreach(subdirectory) do |file|
          if file.match(/\w/) && file.end_with?('.rb')
            accumulated_contents += SourceCode.get_file_contents(SourceCode.format_path(subdirectory) + file)
          end
        end
      end
    end
    SourceCode.new(accumulated_contents, :string)
  end
end

# puts SourceCode.from_dir('./tests/').count_methods({'reverse'=>['string','hash','array'], 'split'=>['string'], 'each'=>['array', 'hash'], 'find'=>['array']}
# )

# ignore strings, except when interpolated
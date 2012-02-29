#require './lib/rubymethods.rb'
require File.expand_path(File.dirname(__FILE__) + '/rubymethods')

require 'git'

class SourceCode

  def initialize source, file_type= :file
    case file_type
    when :file
      @file_lines = SourceCode.file_contents source
    when :string
      @file_lines = source      
    when :folder
      @file_lines = SourceCode.from_dir source      
    end
  end

  
  def parse(string)
    string.gsub("(", ' ').gsub(")", ' ')
  end
  
  def count_methods(library_methods = {})
    parts = {}
    
    @file_lines.gsub!(/([""'])(?:(?=(\\?))\2.)*?\1/, "") #wow. you're smart, and i feel stupid
    @file_lines = parse(@file_lines)
    
    @file_lines.split.each do |line_part|
      next unless line_part.include?('.') && line_part.length > 3
      line_part.split(".")[1..-1].each do |word|
        word = word.split("\(")[0]
        if library_methods.has_key?(word)
          parts[word] = (parts[word].nil? ? 1 : parts[word] + 1)
        end
      end
    end
    parts
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
  
  class << self
    def from_dir(directory)
      formatted_path = SourceCode.format_path(directory)
      directories = Dir.glob(formatted_path + "**/*")
      directories << directory
      accumulated_contents = ''
      directories.each do |directory|
        if File.directory?(directory)
          Dir.foreach(directory) do |file|
            if file.match(/\w/) && file.end_with?('.rb')
              accumulated_contents += SourceCode.file_contents(SourceCode.format_path(directory) + file)
            end
          end
        end
      end
      SourceCode.new(accumulated_contents, :string)
    end
  end
  
  private
  
  class << self
    def file_contents document
      file = File.open(document, 'r')
      file_lines = ''
      while line = file.gets do 
        unless line.strip[0] == '#'
          file_lines += line.split("#")[0]
        end
      end
      file_lines
    end
  end 
   
end

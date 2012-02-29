require 'nokogiri'
require 'open-uri'
require 'fakeweb'

class RubyMethods
  attr_accessor :method_hash
  
  def initialize(url)
    @method_hash = {}
    begin
      doc = Nokogiri::HTML(open(url))
    rescue
      puts "Invalid URL or missing file"
      return
    end
    doc.css('#method-index .entries p a').each do |link|
      entry_array = link.content.split
      method_string = entry_array[0]
      class_string = entry_array[1].delete("()")
      if @method_hash.has_key?(method_string)
        @method_hash[method_string].push class_string
      else
        @method_hash[method_string] = [class_string]
      end
    end
  end
end


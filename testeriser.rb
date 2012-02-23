# def parse(string)
#   puts string
#   puts
#   puts
#   puts
#   matched_string = string[/([(].+[)])/]
#   puts matched_string
#   puts
#   deparenth_string = matched_string[1..-2]
#   puts deparenth_string
#   puts
#   string += deparenth_string
#   puts string
#   puts
#   # parse(string)
# end

def parse(string)
  puts string
  matched_string = string[/([(].+[)])/]
  deparenth_string = matched_string[1..-2]
  string = string.gsub(matched_string, "")
  string << "." + deparenth_string
end

puts parse("this.each(test.each.do(test.each.do))  sometime later this.each(test.each.do(test.each.do))")
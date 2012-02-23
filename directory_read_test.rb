# d = Dir.new("./")
# d.each do |file|
#   puts file
# end

Dir.entries("./test_input_directory/").select {|s| File.directory?(s)}.each {|s| puts s}
# Dir.entries("test_sub_dir").select {|s| !s.start_with?(".")}.each {|s| puts s}
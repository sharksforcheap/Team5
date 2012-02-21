class Reflector


	def parse_for_methods document
		file = File.open(document, 'r')
		output_array = []
		while (line = file.gets)
			line_array = line.split
			line_array.each {|part| output_array << part}
		end
		output_array
	end
  

  





end
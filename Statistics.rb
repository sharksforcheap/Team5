class Statistics
  def initialize(hash)
    @hash = hash
  end
  
  def top_five
    top_list(5)
  end
  
  def top_list(integer)
   @output_hash = {}
   top_x_list = @hash.sort_by {|key, value| value}.reverse[0..(integer-1)]
   top_x_list.each { |pair| @output_hash[pair[0]] = pair[1] }
   @output_hash
  end
end

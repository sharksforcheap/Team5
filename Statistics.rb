class Statistics
  def initialize(hash)
    @hash = hash
  end
  
  def top_five
    @output_hash = {}
    top_five_list = @hash.sort_by {|key, value| value}.reverse[0..4]
    top_five_list.each { |pair| @output_hash[pair[0]] = pair[1] }
    @output_hash
  end
  
  def outliers
    
  end
end

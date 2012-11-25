class Array
  def odd_values
    self.values_at(* self.each_index.select(&:odd?))
  end
  def even_values
    self.values_at(* self.each_index.select(&:even?))
  end
end
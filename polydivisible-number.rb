class Integer
    def poly_divisible?()
        txt = self.to_s
        (1..txt.size).all?{|size| txt[0,size].to_i % size == 0 }
    end
end

digits = gets.split.map(&:to_i)

puts (digits.max+1..36).select{|base|
    digits.reverse.map.with_index{|d,i| d * base ** i }.sum.poly_divisible?
}
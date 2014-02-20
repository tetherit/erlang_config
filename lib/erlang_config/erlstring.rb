module ErlangConfig
  class ErlString < ErlTerm
    def to_ruby
      self.str.gsub(/"/,"")
    end
  end
end

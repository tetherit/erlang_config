module ErlangConfig
  class ErlAtom < ErlTerm
    def to_ruby
      self.str.gsub(/'/,"")
    end
  end
end

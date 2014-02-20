module ErlangConfig
  class ErlRef < ErlTerm
    def to_ruby
      self.str.gsub!(/#Ref<|>/,"")
      bin_els = self.str.split(".")
    end
  end
end

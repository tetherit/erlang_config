module ErlangConfig
  class ErlPid < ErlTerm
    def to_ruby
      self.str.gsub!(/<>/,"")
      bin_els = self.str.split(".")
    end
  end
end

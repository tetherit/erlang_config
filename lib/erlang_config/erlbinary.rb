module ErlangConfig
  class ErlBinary < ErlTerm
    def to_ruby
      self.str.gsub!(/[<>]/,"")
      bin_els = self.str.split(",")
      els = bin_els.map { |el|
        if el[/^[0-9]+$/]
          el.to_i
        elsif el[/^"/]
          el.gsub(/"/,"")
        end
      }
      els.length > 1 ? els : els[0]
    end
  end
end

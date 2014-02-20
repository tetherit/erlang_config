module ErlangConfig
  class ErlList < ErlEnumeration
    def to_ruby
      @elements.map {|el|
        (el.is_a?(ErlTerm) || el.is_a?(ErlEnumeration))? el.to_ruby : el
      }
    end
  end
end

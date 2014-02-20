module ErlangConfig
  class ErlTuple < ErlEnumeration
    def to_ruby
      arr = @elements.map {|el|
        (el.is_a?(ErlTerm) || el.is_a?(ErlEnumeration))? el.to_ruby : el
      }
      key = arr.delete_at(0)
      hash = {key => ( arr.length>1 ? arr: arr[0])}
    end
  end
end

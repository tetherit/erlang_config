module ErlangConfig
  class ErlEnumeration
    attr_accessor :str, :elements
    def initialize(str)
      @str = str
      @elements = []
    end

    def parse
      strs = get_element_strs
      @elements = parse_element_strs(strs)
    end

    def pos_close_str(str, open_str)
      close_str = ERL_CLOSE_STRS[open_str]
      if open_str == close_str
        return str.index(close_str,1)
      else
        open_count = 1
        for i in ((str.index(open_str)+1)..(str.length))
          opened = (str[i,open_str.length ] == open_str)
          open_count += 1 if opened
          closed = (str[i,close_str.length] == close_str)
          open_count -= 1 if closed
          return i if (closed && open_count==0)
        end
        raise "Parse error, not found matching close of #{open_str} in #{str}"
      end
    end

    def parse_first_term(str_to_parse)
      open_str = str_to_parse[/^(\[|\{|\"|\'|<<|#Ref|<)/,1]
      if open_str
        close_str = ERL_CLOSE_STRS[open_str]
        pos_open_str = str_to_parse.index(open_str)
        pos_close_str = pos_close_str(str_to_parse,open_str)
        term_str = str_to_parse[pos_open_str..(pos_close_str+close_str.length-1)]
        new_str_to_parse = str_to_parse[(pos_close_str+close_str.length), str.length]
      else
        pos_open_str = 0
        pos_close_str = str_to_parse.index(",") || str_to_parse.length
        term_str = str_to_parse[pos_open_str..(pos_close_str-1)]
        new_str_to_parse = str_to_parse[pos_close_str+1, str.length]
      end
      new_str_to_parse = "" if new_str_to_parse.nil?
      [term_str, new_str_to_parse.gsub(/^[,\s]+/,"")]
    end

    #parse @str to elements to the end of @str, and each elements must be separated by ","
    def get_element_strs
      element_strs=[]
      str_to_parse = @str[1,@str.length-2].strip  # between [ and ], or { and }
      until str_to_parse == ""
        term_str, new_str_to_parse = parse_first_term(str_to_parse)
        element_strs << term_str
        str_to_parse = new_str_to_parse
      end
      element_strs
    end

    def parse_element_strs(strs)
      strs.map {|term_str|
        term = ErlTerm.decode(term_str)
        if term.is_a?(ErlTuple) or term.is_a?(ErlList)
          term_strs = term.get_element_strs
          term.elements = term.parse_element_strs(term_strs)
        end
        term
      }
    end
  end
end

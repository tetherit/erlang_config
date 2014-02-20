module ErlangConfig
  class ErlTerm
    attr_accessor :str
    def initialize(str)
      @str = str
    end

    def self.decode(str)
      str.strip!
      term_open_str = str[/^(\[|\{|\"|\'|<<|#Ref|<)/,1]
      if term_open_str.nil? # integer,float, or, atom
        matches = /^(([-0-9\.]+)|([a-z][a-z0-9_]*))/.match(str)
        term = case
          when (matches[2] && str[/\./]) then str.to_f
          when matches[2] then str.to_i
          when matches[3] then str.to_sym
        end
      else
        term_close_str = ERL_CLOSE_STRS[term_open_str]
        re_ends_with_close_str = Regexp.new(Regexp.escape("#{term_close_str}")+"$")
        raise "Parse error, Invalid erlang term #{str}" unless re_ends_with_close_str.match(str)
        term = case term_open_str
          when '[' then ErlList.new(str)
          when '{' then ErlTuple.new(str)
          when '"' then ErlString.new(str)
          when "'" then ErlAtom.new(str)
          when "<<" then ErlBinary.new(str)
          when "#Ref" then ErlRef.new(str)
          when "<" then ErlPid.new(str)
          else raise "Parse error with #{term_open_str}"
        end
      end
      term
    end
  end
end

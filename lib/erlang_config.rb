require "erlang_config/erlterm"
require "erlang_config/erlatom"
require "erlang_config/erlbinary"
require "erlang_config/erlnumeration"
require "erlang_config/erllist"
require "erlang_config/erlpid"
require "erlang_config/erlref"
require "erlang_config/erlstring"
require "erlang_config/erltuple"

ERL_CLOSE_STRS  = {"["=>"]", "{"=>"}", '"'=>'"', "'"=>"'", '<<'=>'>>', "#Ref<"=>">", "<"=>">"}

module ErlangConfig

  def self.decode(str)
    str.gsub!(/[\n\r]/,"")
    erl_obj = ErlTerm.decode(str)
    erl_obj.parse if erl_obj.is_a?(ErlEnumeration)
    erl_obj.to_ruby
  end

  def self.encode(hash)
    puts "Sorry, this has not been written yet, pull requests are welcome :)"
  end

end

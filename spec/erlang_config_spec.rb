require 'spec_helper'

describe ErlangConfig do
  context "when decoding an erlang config" do
    it "should decode simple stuff correctly" do
      erlang_string = '[{"x-max-hops",1},{"x-internal-purpose","federation"}]'
      expect = [{"x-max-hops"=>1}, {"x-internal-purpose"=>"federation"}]
      ErlangConfig.decode(erlang_string).should == expect
    end

    it "should decode rabbitmq status message without errors" do
      erlang_string = File.read(File.expand_path('../data/rabbitmq_status.txt', __FILE__))
      expect {
        decoded = ErlangConfig.decode(erlang_string)
      }.not_to raise_error
    end
  end

  context "when encoding from a ruby hash" do
    it "should encode correctly" do
      ruby_hash = [{"x-max-hops"=>1}, {"x-internal-purpose"=>"federation"}]
      expect = '[{"x-max-hops",1},{"x-internal-purpose","federation"}]'
      # Erlang::Config.encode(ruby_hash).should == expect
      pending "Encoding has not been implemented yet, pull requests welcome!"
    end
  end
end

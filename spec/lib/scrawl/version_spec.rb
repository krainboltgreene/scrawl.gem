require "spec_helper"

RSpec.describe Scrawl::VERSION do
  it "should be a string" do
    expect(Scrawl::VERSION).to be_kind_of(String)
  end
end

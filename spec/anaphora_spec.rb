require 'spec_helper'

describe Anaphora do
  it "works" do
    (1..10).map(&it * 2 + 1).should == [3, 5, 7, 9, 11, 13, 15, 17, 19, 21]
    (["12345", "12345"]).map(&it.slice(0..1)).should == ["12", "12"]
  end
end

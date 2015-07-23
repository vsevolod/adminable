require 'test_helper'

class AdminableTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, Adminable
  end
end

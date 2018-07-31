# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'

require './lib/vendor'

# Vendor test class
class VendorTest < Minitest::Test
  def setup
    @vendor = Vendor.new('Rocky Mountain Fresh')
  end

  def test_it_exists
    assert_instance_of Vendor, @vendor
  end

  def test_it_has_a_name
    expected = 'Rocky Mountain Fresh'
    actual   = @vendor.name

    assert_equal expected, actual
  end
end

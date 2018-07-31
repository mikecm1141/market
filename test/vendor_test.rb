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

  def test_inventory_hash_starts_empty
    assert_empty @vendor.inventory
  end

  def test_stock_can_be_checked_and_default_is_zero
    expected = 0
    actual   = @vendor.check_stock('Peaches')

    assert_equal expected, actual
  end

  def test_stock_can_be_added_to
    expected = 30
    actual   = @vendor.stock('Peaches', 30)

    assert_equal expected, actual

    expected2 = 30
    actual2   = @vendor.check_stock('Peaches')

    assert_equal expected2, actual2

    expected3 = 55
    actual3   = @vendor.stock('Peaches', 25)

    assert_equal expected3, actual3

    expected4 = 55
    actual4   = @vendor.check_stock('Peaches')

    assert_equal expected4, actual4
  end

  def test_it_can_have_different_items
    expected = 12
    actual   = @vendor.stock('Tomatoes', 12)

    assert_equal expected, actual
  end

  def test_its_inventory_hash_stores_stock
    @vendor.stock('Peaches',  55)
    @vendor.stock('Tomatoes', 12)

    expected = { 'Peaches' => 55, 'Tomatoes' => 12 }
    actual   = @vendor.inventory

    assert_equal expected, actual
  end
end

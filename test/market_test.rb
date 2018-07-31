# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'

require './lib/vendor'
require './lib/market'

# Market class test
class MarketTest < Minitest::Test
  def setup
    @market = Market.new('South Pearl Street Farmers Market')

    @vendor1 = Vendor.new('Rocky Mountain Fresh')
    @vendor2 = Vendor.new('Ba-Nom-a-Nom')
    @vendor3 = Vendor.new('Palisade Peach Shack')

    @vendor1.stock('Peaches', 35)
    @vendor1.stock('Tomatoes', 7)

    @vendor2.stock('Banana Nice Cream',           50)
    @vendor2.stock('Peach-Raspberry Nice Cream',  25)

    @vendor3.stock('Peaches', 65)
  end
  def test_it_exists
    assert_instance_of Market, @market
  end

  def test_it_has_a_name
    expected = 'South Pearl Street Farmers Market'
    actual   = @market.name

    assert_equal expected, actual
  end

  def test_vendors_array_start_empty
    assert_empty @market.vendors
  end

  def test_it_can_add_vendors
    expected = [@vendor1]
    actual   = @market.add_vendor(@vendor1)

    assert_equal expected, actual

    expected2 = [@vendor1, @vendor2]
    actual2   = @market.add_vendor(@vendor2)

    assert_equal expected2, actual2

    expected3 = [@vendor1, @vendor2, @vendor3]
    actual3   = @market.add_vendor(@vendor3)

    assert_equal expected3, actual3
  end

  def test_it_returns_vendor_names_as_array
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)

    expected = ['Rocky Mountain Fresh', 'Ba-Nom-a-Nom', 'Palisade Peach Shack']
    actual   = @market.vendor_names

    assert_equal expected, actual
  end

  def test_it_returns_vendors_that_sell_an_item
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)

    expected = [@vendor1, @vendor3]
    actual   = @market.vendors_that_sell('Peaches')

    assert_equal expected, actual

    expected2 = [@vendor2]
    actual2   = @market.vendors_that_sell('Banana Nice Cream')

    assert_equal expected2, actual2
  end

  def test_it_returns_a_sorted_unique_list
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)

    expected = ['Banana Nice Cream', 'Peach-Raspberry Nice Cream', 'Peaches', 'Tomatoes']
    actual   = @market.sorted_item_list

    assert_equal expected, actual
  end

  def test_it_returns_total_inventory_as_a_hash
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)

    expected = {
      'Peaches'                    => 100,
      'Tomatoes'                   => 7,
      'Banana Nice Cream'          => 50,
      'Peach-Raspberry Nice Cream' => 25
    }
    actual = @market.total_inventory

    assert_equal expected, actual
  end
end

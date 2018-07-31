# frozen_string_literal: true

# Market class
class Market
  attr_reader :name,
              :vendors

  def initialize(name)
    @name    = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map(&:name)
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor.inventory.key?(item)
    end
  end

  def sorted_item_list
    vendor_items.uniq.sort
  end

  def total_inventory
    inventory_hash = Hash.new(0)

    @vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
        inventory_hash[item] += quantity
      end
    end

    inventory_hash
  end

  private

  def vendor_items
    @vendors.map do |vendor|
      vendor.inventory.keys
    end.flatten
  end
end

class Market
  attr_reader :name,
              :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor.check_stock(item) > 0
    end
  end

  def total_inventory
    total_hash = {}
    @vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
      if total_hash[item].nil?
        total_hash[item] = {quantity: 0, vendors: []}
      end
        total_hash[item][:quantity] += quantity
        total_hash[item][:vendors] << vendor
      end
    end
    total_hash
  end

  def overstocked_items
    overstock_list = []
    total_inventory.each do |item, info|
      if info[:vendors].length > 1 && info[:quantity] > 50
        overstock_list << item
      end
    end
    overstock_list.flatten
  end
end

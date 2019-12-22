require_relative './gilded_rose_constants'

class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      case item.name
      when GildedRoseConstants::ITEM_AGED_BRIE
        item = update_aged_brie(item)
      when GildedRoseConstants::ITEM_SULFURAS
        item = item
      when GildedRoseConstants::ITEM_BACKSTAGE_PASSES
        item = update_backstage_passes(item)
      when GildedRoseConstants::ITEM_CONJURED
        item = update_conjured(item)
      else
        item = update_normal(item)
      end
    end
  end

  def change_quality(current_quality, value, is_increase)
    if is_increase
      if current_quality+value < GildedRoseConstants::MAX_QUALITY
        return current_quality+value
      end
    else
      if current_quality-value > GildedRoseConstants::MIN_QUALITY
        return current_quality-value
      end
    end
    return current_quality
  end

  def update_aged_brie(item)
    item.quality = change_quality(item.quality, 1, true)
    item.sell_in = item.sell_in - 1

    return item
  end

  def update_backstage_passes(item)
    item.quality = change_quality(item.quality, 1, true)
    if item.sell_in <= 10
      item.quality = change_quality(item.quality, 1, true)
    end
    if item.sell_in <= 5
      item.quality = change_quality(item.quality, 1, true)
    end
    if item.sell_in <= GildedRoseConstants::MIN_SELL_IN
      item.quality = 0
    end
    return item
  end

  def update_conjured(item)
    if item.sell_in <= GildedRoseConstants::MIN_SELL_IN
      item.quality = change_quality(item.quality, 4, false)
    else
      item.quality = change_quality(item.quality, 2, false)
    end

    item.sell_in = item.sell_in - 1
    return item
  end

  def update_normal(item)
    if item.sell_in <= GildedRoseConstants::MIN_SELL_IN
      item.quality = change_quality(item.quality, 2, false)
    else
      item.quality = change_quality(item.quality, 1, false)
    end

    item.sell_in = item.sell_in - 1
    return item
  end
end

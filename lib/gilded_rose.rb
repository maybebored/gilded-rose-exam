class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      case item.name
      when 'Aged Brie'
        item = update_aged_brie(item)
      when 'Sulfuras, Hand of Ragnaros'
        item = item
      when 'Backstage passes to a TAFKAL80ETC concert'
        item = update_backstage_passes(item)
      else
        item = update_normal(item)
      end
    end
  end
end

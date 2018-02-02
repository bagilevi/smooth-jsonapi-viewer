class Document
  extend Memoist

  attr_reader :raw, :entities

  def initialize(raw)
    @raw = raw
    populate
  end

  def entity
    if @collection
      raise 'This document contains a collection of entities, use the `entities` method.'
    end
    entities.first
  end

  def get_included_entity(data)
    @included.find { |e| e.type == data['type'] && e.id == data['id'] }
  end

  def links
    (raw['links'] || {}).except('self')
  end
  memoize :links

  private

  def populate
    populate_data
    populate_included
  end

  def populate_data
    if raw['data'].is_a?(Array)
      @collection = true
      @entities = raw['data'].map { |item| Entity.new(item, self) }
    else
      @collection = false
      @entities = [Entity.new(raw['data'], self)]
    end
  end

  def populate_included
    @included = Array(raw['included']).map do |raw_item|
      Entity.new(raw_item, self)
    end
  end
end

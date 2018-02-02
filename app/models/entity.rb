class Entity
  extend Memoist
  attr_reader :raw, :type, :id, :attributes, :relationships, :links

  def initialize(raw, context)
    @raw = raw
    @context = context
    populate
  end

  def relationships
    (raw['relationships'] || []).map do |key, value|
      [
        key,
        relationship_value(value)
      ]
    end.to_h
  end
  memoize

  def links
    (raw['links'] || {}).except('self')
  end

  def self_link
    (raw['links'] || {})['self']
  end

  def full_key
    "#{type}:#{id}"
  end

  private

  def populate
    @type = raw['type']
    @id = raw['id']
    populate_attributes
  end

  def populate_attributes
    @attributes = raw['attributes'] || {}
    @attributes.each do |key, value|
      class_eval <<-EVAL
        def #{key.to_s.underscore}
          #{value.inspect}
        end
      EVAL
    end
  end


  def relationship_value(value)
    data = value['data']
    if data.is_a?(Array)
      data.map { |item| resolve_included(item) }
    else
      resolve_included(data)
    end
  end

  def resolve_included(data)
    @context.get_included_entity(data) || Entity.new(data, @context)
  end
end

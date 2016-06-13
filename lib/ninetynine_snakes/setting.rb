class Setting

  attr_accessor :category, :key, :value, :label, :type

  def initialize(category, key, value, label, type)
    @category = category
    @key = key
    @value = value
    @label = label
    @type = type
  end
end
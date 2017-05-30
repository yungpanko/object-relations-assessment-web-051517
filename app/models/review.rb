class Review

  attr_accessor :customer, :restaurant, :content

  @@all = []

  def initialize(restaurant, content)
    @content = content
    @restaurant = restaurant
    self.class.all << self
  end

  def self.all
    @@all
  end

end

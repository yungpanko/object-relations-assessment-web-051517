class Restaurant

  attr_accessor :name, :reviews, :customers

  @@all = []

  def initialize(name)
    @name = name
    self.class.all << self
    @reviews = []
  end

  def self.all
    @@all
  end

  def self.find_by_name(name)
    self.all.find do |restaurant|
      restaurant.name == name
    end
  end

  def reviews
    @reviews
  end

  def customers
    self.reviews.map do |review|
      review.customer
    end
  end

  def save
    self.class.all << self
  end

  def self.create_by_name(name)
    restaurant = Restaurant.new(name)
    restaurant.save
    restaurant
  end

  def self.find_or_create_by_name(name)
    if self.find_by_name(name)
      self.find_by_name(name)
    else
      self.create_by_name(name)
    end
  end

end

# Please copy/paste all three classes into this file to submit your solution!
class Customer

  attr_accessor :first_name, :last_name

  @@all = []

  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name  = last_name
    self.class.all << self
    @reviews = []
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.all
    @@all
  end

  def self.find_by_name(name)
    self.all.find do |customer|
      customer.full_name == name
    end
  end

  def self.find_all_by_first_name(name)
    self.all.select do |customer|
      customer.first_name == name
    end
  end

  def self.all_names
    self.all.map do |customer|
      customer.full_name
    end
  end

  def add_review(restaurant, content)
    resto = Restaurant.find_or_create_by_name(restaurant)
    review = Review.new(resto, content)
    self.reviews << review
    resto.reviews << review
    review.customer = self
    # associate with restaurant
  end

  def reviews
    @reviews
  end


end

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

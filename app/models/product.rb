class Product < ActiveRecord::Base
  validates :title, :description, :image_url, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
      with: %r{\.(png|jpg|gif)\Z}i,
      massage: 'URL должен указывать на изображение формата GIF, JPG или PNG.'
  }
  validates :title, length: {minimum: 10, too_short: "Длина наименования должна быть не менее 10 символов"}, allow_blank: true
end

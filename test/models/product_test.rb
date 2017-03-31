require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products


  test "Product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:image_url].any?
    assert product.errors[:price].any?
  end

  test "Product price must be positive" do
    product = Product.new(title: "Prod1 title",
        description: "Description prod1",
    image_url: "zzz.jpg")
    product.price = -1
    assert product.invalid?
    assert_equal ["может иметь значение большее или равное 0.01"],
                 product.errors[:price]

      product.price=0
    assert product.invalid?
    assert_equal ["может иметь значение большее или равное 0.01"],
                 product.errors[:price]
    product.price=1
    assert product.valid?
  end

  def new_product(image_url)
    Product.new( title: "My Book Title",
                 description: "yyy",
                 price: 1,
                 image_url: image_url)
  end
  test "image url" do
# url изображения
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg
http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }
    ok.each do |name|
      assert new_product(name).valid?, "#{name} shouldn't be invalid"
# не должно быть неприемлемым
    end
    bad.each do |name|
      assert new_product(name).invalid?, "#{name} shouldn't be valid"
# не должно быть приемлемым
    end
  end

  test "product is not valid without a unique title" do
# если у товара нет уникального названия, то он недопустим
    product = Product.new(title: products(:ruby).title,
                          description: "yyy",
                          price: 1,
                          image_url: "fred.gif")
    assert product.invalid?
    #assert_equal [I18n.translate('activerecord.errors.messages.taken')], product.errors[:title]
    assert_equal ["уже существует"], product.errors[:title]
# уже было использовано
  end

  test "product title must have minimum 10 characters" do
    product = Product.new(title: "Too short", description: "uuu", price: 1, image_url: "fred.gif")
    assert product.invalid?
    assert_equal ["Длина наименования должна быть не менее 10 символов"], product.errors[:title]
    # наименование товара меньше 10 символов
  end

  test "Product name must be uniq" do

    product_1 = Product.new(title: "Too short", description: "uuu", price: 1, image_url: "fred.gif")
    product_1.save
    product_2 = Product.new(title: "Too short", description: "uuu", price: 1, image_url: "fred.gif")
    product_2.save
    assert product_2.invalid?

  end



end

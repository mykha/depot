class StoreController < ApplicationController
  include CurrentCart
  before_action :add_counter, only: [:index]

  def index
    @products = Product.order(:title)
  end
end

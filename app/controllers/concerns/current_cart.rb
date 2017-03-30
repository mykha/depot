module CurrentCart
  extend ActiveSupport::Concern
  private
  def set_cart
    @cart = Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    session[:cart_id] = @cart.id
  end

  private
  def add_counter
    if session[:counter].nil?
      session[:counter]=0
    else
      session[:counter] = session[:counter]+1
    end
  end
end
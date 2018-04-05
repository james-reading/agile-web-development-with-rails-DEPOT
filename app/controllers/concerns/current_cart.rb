module CurrentCart

  private
  def set_cart
    @cart = Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    session[:cart_id] = @cart.id
  end

  private
  def increase_view_counter
    if session[:counter].nil?
      session[:counter] = 1
    end
    session[:counter] += 1
  end

  private
  def reset_counter
    unless session[:counter].nil?
      session[:counter] = 0
    end
  end
  
end

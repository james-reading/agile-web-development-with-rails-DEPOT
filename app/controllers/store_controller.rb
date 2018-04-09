class StoreController < ApplicationController

  include CurrentCart

  before_action :set_cart
  
  def index
    @products = Product.order(:title)
    increase_view_counter
    @counter = session[:counter]
  end
end

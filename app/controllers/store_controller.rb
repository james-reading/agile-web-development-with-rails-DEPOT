class StoreController < ApplicationController

  include CurrentCart

  def index
    @products = Product.order(:title)
    increase_view_counter
    @counter = session[:counter]
  end
end

class Public::ItemsController < ApplicationController

  def index
    @items = Item.all
    # @customer = current_customer
  end

  def show
    @item = Item.find(params[:id])
    @tax_price = @item.price * 1.1
    @cart_item = CartItem.new
  end

end

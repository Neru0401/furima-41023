class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @Item = Item.new
  end
  
end

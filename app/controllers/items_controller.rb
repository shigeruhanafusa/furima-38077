class ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.all
  end

  def create
  end

end

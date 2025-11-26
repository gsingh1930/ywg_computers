class ProductsController < ApplicationController
  def index
    @products = Product.page(params[:page]).per(16)
    @categories = Category.all
  end

  def show
    @product = Product.find(params[:id])
  end
end

class ProductsController < ApplicationController
  def index
    @products = Product.all
    @categories = Category.all

    if params[:filter] == "on_sale"
      @products = @products.on_sale
    elsif params[:filter] == "new"
      @products = @products.new_products
    elsif params[:filter] == "recently_updated"
      @products = @products.recently_updated
    end

    if params[:category_id].present?
      @products = @products.where(category_id: params[:category_id])
    end

    if params[:search].present?
      @products = @products.where("name LIKE ? OR description LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    end

    @products = @products.page(params[:page]).per(12)
  end

  def show
    @product = Product.find(params[:id])
  end
end

class ProductsController < ApplicationController
  def index
    @products = Product.all
    @categories = Category.all

    case params[:filter]
    when 'on_sale'
      @products = @products.on_sale
    when 'new'
      @products = @products.new_products
    when 'recently_updated'
      @products = @products.recently_updated
    end

    @products = @products.where(category_id: params[:category_id]) if params[:category_id].present?

    if params[:search].present?
      @products = @products.where('name LIKE ? OR description LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%")
    end

    @products = @products.page(params[:page]).per(12)
  end

  def show
    @product = Product.find(params[:id])
  end
end

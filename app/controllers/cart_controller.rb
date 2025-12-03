class CartController < ApplicationController
  def show
    @cart_items = []
    @cart_total = 0

    cart = session[:cart] || {}

    cart.each do |product_id, quantity|
      product = Product.find_by(id: product_id)
      next unless product

      item_total = product.unit_price * quantity
      @cart_items << { product: product, quantity: quantity, item_total: item_total }
      @cart_total += item_total
    end
  end

  def add
    product = Product.find(params[:id])
    session[:cart] ||= {}

    if session[:cart][product.id.to_s]
      session[:cart][product.id.to_s] += 1
    else
      session[:cart][product.id.to_s] = 1
    end

    redirect_to cart_path, notice: "#{product.name} added to cart!"
  end

  def remove
    session[:cart]&.delete(params[:id].to_s)
    redirect_to cart_path, notice: 'Item removed from cart.'
  end

  def update
    quantity = params[:quantity].to_i

    if quantity.positive?
      session[:cart][params[:id].to_s] = quantity
      redirect_to cart_path, notice: 'Cart updated.'
    else
      session[:cart]&.delete(params[:id].to_s)
      redirect_to cart_path, notice: 'Item removed from cart.'
    end
  end
end

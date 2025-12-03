class CheckoutController < ApplicationController
  before_action :authenticate_user!
  before_action :require_cart_items

  def index
    @cart_items = get_cart_items
    @cart_total = calculate_cart_total
    @provinces = Province.all
    @address = current_user.addresses.last || Address.new
  end

  def process_order
    # Create or find address
    if params[:address_id].present?
      @address = current_user.addresses.find(params[:address_id])
    else
      @address = current_user.addresses.create!(
        street: params[:street],
        city: params[:city],
        postal_code: params[:postal_code],
        province_id: params[:province_id]
      )
    end

    # Calculate totals
    province = @address.province
    subtotal = calculate_cart_total

    if province.hst > 0
      hst_total = (subtotal * province.hst / 100).round(2)
      gst_total = 0
      pst_total = 0
    else
      gst_total = (subtotal * province.gst / 100).round(2)
      pst_total = (subtotal * province.pst / 100).round(2)
      hst_total = 0
    end

    total = subtotal + gst_total + pst_total + hst_total

    # Create order
    @order = current_user.orders.create!(
      address: @address,
      subtotal: subtotal,
      gst_total: gst_total,
      pst_total: pst_total,
      hst_total: hst_total,
      total: total,
      status: "pending"
    )

    # Create order items
    cart = session[:cart] || {}
    cart.each do |product_id, quantity|
      product = Product.find(product_id)
      @order.order_items.create!(
        product: product,
        quantity: quantity,
        unit_price: product.unit_price
      )
    end


    # Clear cart
    session[:cart] = {}

    redirect_to order_path(@order), notice: "Order placed successfully!"
  end

  private

  def require_cart_items
    if session[:cart].blank? || session[:cart].empty?
      redirect_to cart_path, alert: "Your cart is empty."
    end
  end

  def get_cart_items
    cart_items = []
    cart = session[:cart] || {}

    cart.each do |product_id, quantity|
      product = Product.find_by(id: product_id)
      if product
        item_total = product.unit_price * quantity
        cart_items << { product: product, quantity: quantity, item_total: item_total }
      end
    end

    cart_items
  end

  def calculate_cart_total
    total = 0
    cart = session[:cart] || {}

    cart.each do |product_id, quantity|
      product = Product.find_by(id: product_id)
      total += product.unit_price * quantity if product
    end

    total
  end
end

ActiveAdmin.register Order do
  permit_params :status, :user_id, :address_id, :subtotal, :gst_total, :pst_total, :hst_total, :total

  index do
    selectable_column
    id_column
    column :user
    column :status do |order|
      status_tag order.status, class: order.status == "paid" ? "green" : order.status == "shipped" ? "blue" : "orange"
    end
    column :subtotal do |order|
      number_to_currency(order.subtotal)
    end
    column :total do |order|
      number_to_currency(order.total)
    end
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :user
      row :status do |order|
        status_tag order.status, class: order.status == "paid" ? "green" : order.status == "shipped" ? "blue" : "orange"
      end
      row :address do |order|
        "#{order.address.street}, #{order.address.city}, #{order.address.province.abbreviation} #{order.address.postal_code}"
      end
      row :subtotal do |order|
        number_to_currency(order.subtotal)
      end
      row :gst_total do |order|
        number_to_currency(order.gst_total)
      end
      row :pst_total do |order|
        number_to_currency(order.pst_total)
      end
      row :hst_total do |order|
        number_to_currency(order.hst_total)
      end
      row :total do |order|
        number_to_currency(order.total)
      end
      row :created_at
    end

    panel "Order Items" do
      table_for order.order_items do
        column :product
        column :quantity
        column "Unit Price" do |item|
          number_to_currency(item.product.unit_price)
        end
        column "Item Total" do |item|
          number_to_currency(item.product.unit_price * item.quantity)
        end
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :user
      f.input :status, as: :select, collection: [ "pending", "paid", "shipped", "cancelled" ]
      f.input :subtotal
      f.input :gst_total
      f.input :pst_total
      f.input :hst_total
      f.input :total
    end
    f.actions
  end

  # Action buttons to quickly change status
  action_item :mark_paid, only: :show do
    if order.status == "pending"
      link_to "Mark as Paid", mark_paid_admin_order_path(order), method: :put
    end
  end

  action_item :mark_shipped, only: :show do
    if order.status == "paid"
      link_to "Mark as Shipped", mark_shipped_admin_order_path(order), method: :put
    end
  end

  member_action :mark_paid, method: :put do
    resource.update(status: "paid")
    redirect_to admin_order_path(resource), notice: "Order marked as paid!"
  end

  member_action :mark_shipped, method: :put do
    resource.update(status: "shipped")
    redirect_to admin_order_path(resource), notice: "Order marked as shipped!"
  end
end

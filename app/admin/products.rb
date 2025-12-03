ActiveAdmin.register Product do
  permit_params :name, :description, :stock_quantity, :unit_price, :category_id, :on_sale, :sale_price, :image

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :category
      f.input :unit_price
      f.input :stock_quantity
      f.input :on_sale
      f.input :sale_price
      f.input :image, as: :file
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :category
      row :unit_price
      row :stock_quantity
      row :on_sale
      row :sale_price
      row :image do |product|
        if product.image.attached?
          image_tag product.image, style: "max-width: 300px;"
        end
      end
    end
  end

  index do
    selectable_column
    id_column
    column :name
    column :category
    column :unit_price
    column :stock_quantity
    column :on_sale
    actions
  end
end

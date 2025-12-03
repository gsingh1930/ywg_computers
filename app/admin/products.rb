ActiveAdmin.register Product do
  permit_params :name, :description, :stock_quantity, :unit_price, :category_id, :on_sale, :sale_price, :image, tag_ids: []

  index do
    selectable_column
    id_column
    column :name
    column :category
    column :unit_price do |product|
      number_to_currency(product.unit_price)
    end
    column :stock_quantity
    column :on_sale
    column "Tags" do |product|
      product.tags.map(&:name).join(", ")
    end
    actions
  end

  filter :name
  filter :category
  filter :unit_price
  filter :stock_quantity
  filter :on_sale

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :category
      f.input :unit_price, min: 0
      f.input :stock_quantity, min: 0
      f.input :on_sale
      f.input :sale_price, min: 0
      f.input :tags, as: :check_boxes, collection: Tag.all
      f.input :image, as: :file
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :category
      row :unit_price do |product|
        number_to_currency(product.unit_price)
      end
      row :stock_quantity
      row :on_sale
      row :sale_price
      row :tags do |product|
        product.tags.map(&:name).join(", ")
      end
      row :image do |product|
        if product.image.attached?
          image_tag product.image, style: 'max-width: 300px;'
        end
      end
    end
  end
end
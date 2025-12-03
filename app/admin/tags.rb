ActiveAdmin.register Tag do
  permit_params :name

  index do
    selectable_column
    id_column
    column :name
    column "Products" do |tag|
      tag.products.count
    end
    actions
  end

  show do
    attributes_table do
      row :name
      row :products do |tag|
        tag.products.map { |p| link_to p.name, admin_product_path(p) }.join(", ").html_safe
      end
    end
  end
end

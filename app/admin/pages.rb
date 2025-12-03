ActiveAdmin.register Page do
  permit_params :title, :slug, :content

  index do
    selectable_column
    id_column
    column :title
    column :slug
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :slug, hint: "URL-friendly name (e.g., about, contact)"
      f.input :content, as: :text, input_html: { rows: 15 }
    end
    f.actions
  end

  show do
    attributes_table do
      row :title
      row :slug
      row :content do |page|
        simple_format(page.content)
      end
      row :updated_at
    end
  end
end

class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.decimal :subtotal
      t.decimal :gst_total
      t.decimal :pst_total
      t.decimal :hst_total
      t.decimal :total
      t.string :status
      t.references :user, null: false, foreign_key: true
      t.references :address, null: false, foreign_key: true

      t.timestamps
    end
  end
end

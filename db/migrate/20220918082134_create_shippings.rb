class CreateShippings < ActiveRecord::Migration[6.0]
  def change
    create_table :shippings do |t|
      t.string     :postal_code,             null: false
      t.integer    :area_id,                 null: false
      t.string     :municpality,             null: false
      t.string     :address1,                null: false
      t.string     :address2
      t.string     :phone,                   null: false
      t.references :purchase,       null: false, foreign_key: true
      t.timestamps
    end
  end
end

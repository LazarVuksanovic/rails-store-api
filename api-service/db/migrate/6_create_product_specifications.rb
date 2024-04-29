class CreateProductSpecifications < ActiveRecord::Migration[7.1]
  def change
    create_table :product_specifications do |t|
      t.string :description
      t.references :product, null: false, foreign_key: true
      t.references :specification, null: false, foreign_key: true

      t.timestamps
    end
  end
end

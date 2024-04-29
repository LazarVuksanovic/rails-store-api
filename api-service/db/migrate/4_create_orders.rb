class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.string :status
      t.string :name_lastname
      t.string :address
      t.string :telephone
      t.date :date

      t.timestamps
    end
  end
end

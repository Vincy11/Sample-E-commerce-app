class CreateCommodities < ActiveRecord::Migration
  def change
    create_table :commodities do |t|
      t.string :commname
      t.float :price
      t.integer :quantity

      t.timestamps null: false
    end
  end
end

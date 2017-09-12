class CreateDisplayitems < ActiveRecord::Migration
  def change
    create_table :displayitems do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end

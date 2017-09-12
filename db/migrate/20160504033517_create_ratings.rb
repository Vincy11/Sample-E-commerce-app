class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :user_id
      t.float :rating
      t.integer :ratingcount

      t.timestamps null: false
    end
  end
end

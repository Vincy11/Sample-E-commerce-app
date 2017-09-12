class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :message
      t.string :string
      t.string :usertype
      t.string :string
      t.string :user_id
      t.string :string

      t.timestamps null: false
    end
  end
end

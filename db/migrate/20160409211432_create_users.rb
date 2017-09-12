class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :remember_digest
      t.string :usertype
      t.float :loclat
      t.float :loclong

      t.timestamps null: false
    end
  end
end

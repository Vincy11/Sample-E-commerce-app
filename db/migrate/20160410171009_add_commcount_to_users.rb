class AddCommcountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :commcount, :integer
  end
end

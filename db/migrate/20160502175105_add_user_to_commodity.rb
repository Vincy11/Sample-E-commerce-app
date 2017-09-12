class AddUserToCommodity < ActiveRecord::Migration
  def change
    add_reference :commodities, :user, index: true, foreign_key: true
  end
end

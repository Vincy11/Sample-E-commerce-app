class AddFromidToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :fromid, :string
  end
end

class AddDescriptionToCommodities < ActiveRecord::Migration
  def change
    add_column :commodities, :description, :string
  end
end

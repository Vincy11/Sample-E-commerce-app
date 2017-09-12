class AddCommtypeToCommodities < ActiveRecord::Migration
  def change
    add_column :commodities, :commtype, :string
  end
end

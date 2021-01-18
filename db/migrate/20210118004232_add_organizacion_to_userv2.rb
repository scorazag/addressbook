class AddOrganizacionToUserv2 < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :organizacion_id, :integer
  end
end

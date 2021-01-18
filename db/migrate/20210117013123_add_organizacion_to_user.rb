class AddOrganizacionToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :organizacion_id, :integer
    remove_column :organizacions, :user_id
  end
end

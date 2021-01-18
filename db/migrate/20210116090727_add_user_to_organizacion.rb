class AddUserToOrganizacion < ActiveRecord::Migration[6.1]
  def change
    add_column :organizacions, :user_id, :integer
  end
end

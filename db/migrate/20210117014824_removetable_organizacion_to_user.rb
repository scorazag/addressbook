class RemovetableOrganizacionToUser < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :organizacion_id
  end
end

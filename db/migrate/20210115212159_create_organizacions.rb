class CreateOrganizacions < ActiveRecord::Migration[6.1]
  def change
    create_table :organizacions do |t|
      t.string :nombre
      t.string :telefono
      t.string :direccion

      t.timestamps
    end
  end
end

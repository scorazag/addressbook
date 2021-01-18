class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :nombre
      t.string :email
      t.string :password
      t.string :telefono

      t.timestamps
    end
  end
end

class CreateServiceRegistries < ActiveRecord::Migration[5.1]
  def up
    create_table(:service_registries) do |t|
      t.string :service, limit: 50
      t.string :version, limit: 12
      t.integer :status, default: 0
      t.timestamps
    end
  end
  def down
    drop_table :service_registries
  end
end

class CreateServiceRegistries < ActiveRecord::Migration[5.1]
  def change
    create_table :service_registries do |t|
      t.column :service, :string, limit: 50
      t.column :version, :string, limit: 12
      t.column :status, :integer, default: 0
      t.timestamps
    end
  end
end

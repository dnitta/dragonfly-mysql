class CreateDragonflyDataStores < ActiveRecord::Migration
  def change
    create_table :dragonfly_data_stores do |t|
      t.binary :data
      t.text :meta

      t.timestamps
    end
    execute "alter table dragonfly_data_stores modify data mediumblob"
  end

  def self.down
    drop_table :dragonfly_data_stores
  end
end

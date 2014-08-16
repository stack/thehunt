class CreateCheckpoints < ActiveRecord::Migration
  def change
    create_table :checkpoints do |t|
      t.string :message
      t.text :success
      t.text :response
      t.integer :points, default: 0
      t.integer :order

      t.timestamps
    end

    add_index :checkpoints, :message, unique: true
  end
end

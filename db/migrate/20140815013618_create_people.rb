class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :number
      t.string :name
      t.references :team, index: true

      t.timestamps
    end
    add_index :people, :number
  end
end

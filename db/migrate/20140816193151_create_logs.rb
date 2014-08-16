class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.references :checkpoint, index: true
      t.references :team, index: true
      t.references :person, index: true

      t.timestamps
    end
  end
end

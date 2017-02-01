class CreatePatients < ActiveRecord::Migration[5.0]
  def change
    create_table :patients do |t|
      t.string :name
      t.integer :age
      t.string :gender
      t.string :county
      t.string :town
      t.boolean :status

      t.timestamps
    end
  end
end

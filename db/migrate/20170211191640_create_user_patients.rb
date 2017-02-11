class CreateUserPatients < ActiveRecord::Migration[5.0]
  def change
    create_table :user_patients do |t|
      t.integer :user_id
      t.integer :patient_id
      t.text :comments
      t.float :amount
      t.integer :comment_type_id
      t.string :archive

      t.timestamps
    end
  end
end

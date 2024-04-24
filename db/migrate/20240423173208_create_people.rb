class CreatePeople < ActiveRecord::Migration[7.1]
  def change
    create_table :people do |t|
      t.string :name, null: false, limit: 40
      t.string :address, null: false, limit: 200

      t.timestamps
    end

    add_index :people, :name, unique: true  # Unique index to ensure name is unique
  end
end

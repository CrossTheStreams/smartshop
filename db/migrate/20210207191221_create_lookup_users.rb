class CreateLookupUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :lookup_users do |t|
      t.string :email,              null: false, default: ""
      t.string :schema_name,        null: false, default: ""
      t.timestamps
    end

    add_index :lookup_users, :email, unique: true
  end
end

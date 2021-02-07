class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.string :db_user, null: false
      t.timestamps
    end

    add_index :companies, :name, unique: true
    add_index :companies, :db_user, unique: true

    ActiveRecord::Base.connection.execute("
      ALTER TABLE companies ENABLE ROW LEVEL SECURITY;
      CREATE POLICY companies_policy ON companies 
        USING (companies.db_user = current_user)
        WITH CHECK (companies.db_user = current_user);
      GRANT SELECT, INSERT, UPDATE, DELETE on companies TO public;
    ")
  end
end

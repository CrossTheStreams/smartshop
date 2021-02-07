class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description, null: false, default: ""
      t.decimal :invoice_price, null: false
      t.decimal :msrp_price, null: false
      t.decimal :retail_price, null: false
      t.integer :current_stock, null: false, default: 0
      t.string :uuid, null: false
      t.integer :company_id, null: false
      t.text :db_user, null: false
      t.timestamps
    end

    ActiveRecord::Base.connection.execute("
      ALTER TABLE products ENABLE ROW LEVEL SECURITY;
      CREATE POLICY product_policy ON products 
        USING (products.db_user = current_user)
        WITH CHECK (products.db_user = current_user);
      GRANT SELECT, INSERT, UPDATE, DELETE on products TO public;
    ")
  end
end

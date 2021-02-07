module Smartshop
  module MultiTenancy

    def self.connection
      ActiveRecord::Base.connection
    end

    def self.list_schemas
      all_schemas = connection.execute("select schema_name from information_schema.schemata;").to_a.map {|h| h["schema_name"]}
      # Filter out some internal schemas we don't care about here

      all_schemas.reject! {|schema| schema.include?("pg_") || schema == "information_schema"}
    end

    def self.with_schema(schema)
      original_path = connection.execute("SHOW search_path").to_a.first["search_path"]
      new_path = if schema == "public"
        '"$user", public'
      else
        "#{schema}, public"
      end
      set_search_path(new_path)
      result = yield
      set_search_path(original_path)
      result
    end

    def self.set_search_path(search_path)
      connection.execute("SET search_path TO #{search_path}");
    end

    def self.create_schema(schema_name)
      connection.execute("CREATE SCHEMA #{schema_name}")
    end

    def self.drop_schema(schema_name)
      connection.execute("DROP SCHEMA #{schema_name}")
    end

    def self.copy_public_schema_to_new_schema(new_schema_name)
      dump_string = open("db/structure.sql").read
      new_schema_dump = dump_string.gsub("public", new_schema_name)
      connection.execute(new_schema_dump)
    end

    def self.import_remote_schema(schema_name, remote_server_name)
      # Create the local schema
      create_schema(schema_name)
      sql = %{
        IMPORT FOREIGN SCHEMA #{schema_name}
        FROM SERVER #{remote_server_name}
        INTO #{schema_name};
      }
      connection.execute(sql)
    end

  end
end
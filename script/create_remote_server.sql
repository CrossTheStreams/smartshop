CREATE EXTENSION postgres_fdw;

CREATE SERVER smartshop_development_remote
  FOREIGN DATA WRAPPER postgres_fdw
  OPTIONS (host 'localhost', dbname 'smartshop_development', port '5433');

CREATE USER MAPPING FOR CURRENT_USER
  SERVER smartshop_development_remote
  OPTIONS (user 'arhautau');
  
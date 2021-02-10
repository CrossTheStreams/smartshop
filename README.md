# Multi-Tenancy Examples

## Intro

This repo features different approaches to building a multi-tenant application, using
Ruby on Rails 6.1 and PostgreSQL 13. The theme here is an app ("Smartshop") to track the inventory of a
store.

In each approach to multi-tenancy, you'll be able to generate seed data for each tenant, log in as a user in one of the tenants (with authentication using the Devise gem), and view a list of products particular to the tenant (each tenants will have 100 "products", themed for their particular shop).

NOTE: This repo is NOT focused on demonstrating or being an example of any sort of *conventional* approach to some of these. I'm not using the Apartment or acts_as_tenant gems, for instance. Instead, this is just an extremely lightweight demonstation of these different approaches to multi-tenancy.

## Setup

To setup the application up:

1. Install a ruby version manager, like [rbenv](https://github.com/rbenv/rbenv#installation).
2. Install Ruby 3.0.0: `$ rbenv install 3.0.0`.
3. Install [bundler](https://bundler.io) with `$ gem install bundler`.
4. Run `$ bundle install` in this directory to install the required Ruby gems.
5. Install PostgreSQL, if you don't have an installation. I'd highly suggest [Postgres.app](https://postgresapp.com)
on macOS, and that's what I'll assume here.
6. Create and start PostgreSQL instances, with one on the default port 5432, and the other on port 5433.
7. Decide which feature branch you'd like to demo. Checkout the feature branch with `$ git checkout <feature branch>`.
8. I've bundled a few commands togther in a `.script/setup.sh` script. Run that script from main directory of repo. This will create the databases, seed data for 5 tenants, and other setup depending on the feature branch. Note the output of the generated seed data. You can copy one of the user emails and log in with the copied email and the password `secretpassword`.
9. In a separate terminal tab, start the Rails application with `bin/rails s`.
10. Once you're done assessing the feature branch you're looking at, run the `script/teardown.sh` script. This will drop the databases.

Below is a description of each feature branch, and the approach(es) to multi-tenancy they are concerned with.

## Feature branches

### `main` branch : "Siloed" multi-tenancy and simple "Pool" multi-tenancy

If you'd like to try a "Siloed" approach to multi-tenancy, this could be demonstrated by:

1. Copying the entire directory of this repo
2. Specifying port 5433 for the `development` database in `config/database.yml`, with `port: 5433`.
3. Running `.script/setup.sh`
4. Starting the rails server on a different port with `$ bin/rails s`

Simple "Pool"-based multi-tenancy is demonstrated simply by following the basic setup instructions on the `master` branch. When you log in, the tenant's products are filtered by a simple `WHERE` clause that filters by tenant id. This is dictated by `@products = current_user.company.products` in the `ProductsController#index` controller action.

### `rls` branch : Row Level Security

On the Row Level Security branch, a basic RLS policy is created in the same migrations that create the `companies`, `products`, and `users` tables (`Company`, `Product`, and `User` in the Rails model layer). Each table is given a `db_user` attribute.

On each request, if the user has logged in, we set active PostgreSQL user to the `db_user` for the tenant in `ApplicationController#set_db_user`. The product list will be filtered just like in the simple "Pool" approach, but this time, no `WHERE` clause is used.

### `multi_schema` branch : Multi-schema Multi-tenancy

On this branch, tenants each exist in a different PostgreSQL schema. A reference table, `LookupUser`, exists in the `public` schema. This allows us to lookup the user's schema name after they've authenticated successfully, and then tie the schema to the user's session (which persists across requests via a browser cookie). The product list will just consist of products in the tenant's schema, because we set the `search_path` in PostgreSQL to the tenant schema using this session value.

### `sharding` branch: Multi-schema Multi-tenancy + Sharding with postgres_fdw

This branch is the same as the `multi_schema` branch, except you'll want a separate PostgreSQL instance running on port 5433.

The `script/setup.sh` will establish a foreign data wrapper with the second postgres instance. Also, the 5th of the five tenants/schemas will be created on this second PosgreSQL instance. However, the Rails application won't know the difference, since postgres_fdw allows for Rails to make queries against the primary PostgreSQL, even for the fifth tenant/schema that only lives on the "remote" instance.
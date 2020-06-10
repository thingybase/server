# Migrations

The migrations in this folder are scripts or any other **non-schema** migrations that need to be run manually from a console. They are kept seperate from `db/migrations` because it calls application code to perform the migrations and isn't really reversable.

Each migration has it's own folder that's the `month-day-year` format, scripts to run the migrations, and an entry in this README.md file so we can keep track of why the migrations are in place.

## June 8, 2020

The Container model is no longer needed; instead an Item will be capable of containing other Items. Since there's only a few hundred records in production at the time of this writing, its much easier to do the migration via Ruby app code than it would be to figure out how to build a hierarchy in pure SQL.

Just run the `transform.rb` file in `rails console` after you set `dry_run = false` up top. If all goes well, the migration will finish. If something blows up, the transaction will be aborted and no changes should happen.
class EnablePgTriagramExtension < ActiveRecord::Migration[7.0]
  def change
    enable_extension "pg_trgm"
  end
end

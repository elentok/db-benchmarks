require 'active_record'
require 'benchmark'

ActiveRecord::Migration.verbose = false

def init_database
  `rm -rf tmp`
  `mkdir -p tmp`
  ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: 'tmp/db.sqlite3')

  MyMigration.new.up
end

class MyMigration < ActiveRecord::Migration
  def up
    create_table :lists do |t|
      t.string :title
      t.timestamps
    end

    create_table :items do |t|
      t.string :title
      t.references :list
    end
  end
end

class List < ActiveRecord::Base
  has_many :items
end

class Item < ActiveRecord::Base
  belongs_to :list
end


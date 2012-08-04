require 'active_record'
require 'benchmark'

ActiveRecord::Migration.verbose = false

def connect_to_database
  ActiveRecord::Base.establish_connection(
    adapter: 'postgresql',
    encoding: 'unicode',
    username: 'david',
    database: 'david1')
end

def init_database
  `dropdb david1`
  `createdb david1`
  connect_to_database

  MyMigration.new.up
end

class MyMigration < ActiveRecord::Migration
  def up
    create_table :items do |t|
      t.string :col1
      t.string :col2
      t.string :col3
      t.string :col4
      t.string :col5
      t.integer :col6
      t.integer :col7
      t.integer :col8
      t.integer :col9
      t.integer :col10
      t.text :col11
      t.date :col12
      t.date :col13
      t.float :col14
      t.float :col15
    end
  end

  def down
    drop_table :items
  end
end

class Item < ActiveRecord::Base
end

if __FILE__ == $0
  init_database
end

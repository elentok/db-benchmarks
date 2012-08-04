require 'active_record'
require 'benchmark'

ActiveRecord::Migration.verbose = false

def connect_to_database
  ActiveRecord::Base.establish_connection(
    adapter: 'postgresql',
    encoding: 'unicode',
    username: 'david',
    database: 'david1')
    #database: ':memory:')
end

def init_database
  connect_to_database

  MyMigration.new.up
end

def clean_database
  mig = MyMigration.new
  mig.down
  mig.up
  #Item.destroy_all
  #List.destroy_all
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

  def down
    drop_table :items
    drop_table :lists
  end
end

class List < ActiveRecord::Base
  has_many :items
end

class Item < ActiveRecord::Base
  belongs_to :list
end

if __FILE__ == $0
  init_database
end

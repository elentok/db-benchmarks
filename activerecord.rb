require 'active_record'
require 'benchmark'

ActiveRecord::Migration.verbose = false

# add 1000000 lists + 100 items per list

def main
  benchmark
  `rm -r tmp`
end

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

def benchmark
  puts "lists, items per list, notes, realtime"
  [10, 100, 1000].each do |lists_count|
    [0, 1, 10, 100].each do |items_per_list|
      init_database
      time = Benchmark.realtime { create_many_objects_with_bang(lists_count, items_per_list) }
      puts "#{lists_count}, #{items_per_list}, create!, #{time}"

      init_database
      time = Benchmark.realtime { create_many_objects_without_bang(lists_count, items_per_list) }
      puts "#{lists_count}, #{items_per_list}, create, #{time}"
    end
  end
end

def create_many_objects_with_bang(lists_count, items_per_list)
  lists_count.times do |i|
    list = List.create!(title: "list #{i}")
    items_per_list.times do |j|
      list.items.create!(title: "item #{i}.#{j}")
    end
  end
end

def create_many_objects_without_bang(lists_count, items_per_list)
  lists_count.times do |i|
    list = List.create(title: "list #{i}")
    items_per_list.times do |j|
      list.items.create(title: "item #{i}.#{j}")
    end
  end
end

main

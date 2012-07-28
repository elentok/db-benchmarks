require 'mongoid'

def main
  Mongoid.load!('mongoid.yml', :test)
  benchmark
end

class List
  include Mongoid::Document
  field :title
  embeds_many :items
end

class Item
  include Mongoid::Document
  field :title
  embedded_in :list
end

def benchmark
  puts "lists, items per list, notes, realtime"
  [10, 100, 1000].each do |lists_count|
    [0, 1, 10, 100].each do |items_per_list|
      clear_database
      time = Benchmark.realtime { create_many_objects(lists_count, items_per_list) }
      puts "#{lists_count}, #{items_per_list}, List.create + list.items.create, #{time}"
    end
  end
end

def create_many_objects(lists_count, items_per_list)
  lists_count.times do |i|
    list = List.create(title: "list #{i}")
    items_per_list.times do |j|
      list.items.create(title: "item #{i}.#{j}")
    end
  end
end

def clear_database
  List.destroy_all
end

main

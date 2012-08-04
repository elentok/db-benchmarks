require_relative 'migrate'
require 'activerecord-import'

def main
  init_database
  benchmark
end

def benchmark

  n_items = 100_000

  fields = %w{col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12
    col13 col14 col15}

  items = []

  creation_time = Benchmark.realtime do

    #ActiveRecord::Base.transaction do
    
    items = []

    (1..n_items).each do |id|
      title = "Item #{id}"

      if id % 1000 == 0
        puts "at id = #{id}"
      end

      items << [
        title, title, title, title, title,
        10, 20, 30, 40, 50,
        "bla bla bla #{id}",
        '2012-11-15',
        '2012-11-15',
        1.5,
        4.5]
      
    end

    #end

  end

  puts "Creation time: #{creation_time}"

  insert_time = Benchmark.realtime do
    Item.import fields, items
  end

  puts "Insert time: #{insert_time}"





end

main

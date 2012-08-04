def main
  n_items = 1_000_000

  File.open('items.csv', 'w') do |f|
    (1..n_items).each do |id|
      title = "Item #{id}"
      values = [id, title, title, title, title, title, 10, 20, 30, 40, 50,
        "bla bla bla #{id}", '2012-11-15', '2012-11-15', 1.5, 4.5]
      
      f.write(values.join(', '))
      f.write("\n")
    end
  end
end

main

class Application

  @@items = [ 
    Item.new("Figs",3.42),
    Item.new("Pears",0.99)
  ]
  # Another way to find if the item is present in the inventory. 
  # Push all names into the @@inventory class variable then check @@inventory.include?(<selected_item>)
  # @@inventory = []
  # @@items.map { |item| @@inventory << item.name.downcase }

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path=="/items" 

      resp.write "You've requested the item's path\n\n"
      count = 1
      @@items.each do |item|
        resp.write "Item #{count}) #{item.name}\n\n"
        count += 1
      end

      if req.path.match(/items/) && !!req.params["q"]
        selected_item = req.params["q"]      
        if !!(@@items.find { |item| item.name == selected_item.capitalize })
          item_found = @@items.find { |item| item.name == selected_item.capitalize }
          resp.write "#{item_found.price}"
        else
          resp.write "Item not found"
          resp.status = 400
        end
      end
    else

      resp.write "Route not found"
      resp.status = 404

    end
    
    resp.finish
  end
end

# puts "============================"
# puts "OUTSIDE"
# puts "============================"
# puts "============================"
# puts "INSIDE"
# puts "============================"
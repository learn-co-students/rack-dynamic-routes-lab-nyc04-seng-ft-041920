class Application

def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
 
    if req.path.match(/items/) 
       # tried using this at first req.path==`/items/<ITEM NAME>`, then thought I should try path.match 
        item_name = req.path.split("/items/").last #turn /songs/Sorry into Sorry
        item = @@items.find{|i| i.name == item_name}
        
        if @@items.include?(item) 
            
 
            resp.write "#{item.price}"
        else 
            
            resp.write "Item not found"
            resp.status = 400
        end
    
    else
      resp.write "Route not found"
      resp.status = 404
    end
 
    resp.finish
  end
end
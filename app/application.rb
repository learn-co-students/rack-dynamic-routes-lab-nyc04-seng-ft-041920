class Application 
    @@items = [Item.new("Apples",5.23), Item.new("Oranges",2.43)]

    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)
    

        if req.path.match(/items/)
            item = nil
            item_name = req.path.split("/items/").last
            if item = @@items.find {|i| i.name == item_name}
            resp.write item.price
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
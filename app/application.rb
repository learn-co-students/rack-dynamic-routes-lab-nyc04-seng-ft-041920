class Application

    @@item = []

    def  call(env)
        req = Rack::Request.new(env)
        resp = Rack::Response.new

        if req.path.match(/items/)

                item_name = req.path.split("/items/").last
 
                if item = @@items.find{|i| i.name == item_name}

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
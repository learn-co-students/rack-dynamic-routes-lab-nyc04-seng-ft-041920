class Application
    # @@item = [Item.new("Figs",3.42),Item.new("Pears",0.99)]
    # @@item = []
    def call(env)
        
        response = Rack::Response.new
        request = Rack::Request.new(env)

        
        if request.path.match(/items/)
            #turn /items/*** into ***
            items = request.path.split("/items/").last 
            if item = @@items.find{|i| i.name == items }
                # binding.pry
                response.write item.price
            else
                response.write "Item not found"
                response.status = 400
            end
        else
        response.write "Route not found"
        response.status = 404
        end
        
        response.finish

    end
end
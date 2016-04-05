@tokens = 
    [{:type=>"paren", :value=>"("}, 
    {:type=>"name", :value=>"add"}, 
    {:type=>"number", :value=>"2"}, 
    {:type=>"paren", :value=>"("}, 
    {:type=>"name", :value=>"subtract"}, 
    {:type=>"number", :value=>"4"}, 
    {:type=>"number", :value=>"3"}, 
    {:type=>"paren", :value=>")"},
    {:type=>"paren", :value=>")"}]

def parser
    
    @current = 0
    
    def walk
        token = @tokens[@current]
        if token[:type] == 'number'
            @current += 1
            return {type: 'NumberLiteral', value: token[:value]}
        end
        
        if (token[:type] == 'paren' and token[:value] == '(')
            token = @tokens[@current += 1]
            node = {type: 'CallExpression', name: token[:value], params: []}
            token = @tokens[@current += 1]
            while token[:value] != ')'
                node[:params].push(walk())
                token = @tokens[@current]
            end
            @current += 1
            return node
        end
    end
    ast = {type: 'Program', body: []}
    while (@current < @tokens.length)
        ast[:body] << walk
    end
    return ast
end

puts parser
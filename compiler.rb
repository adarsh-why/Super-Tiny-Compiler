def tokenize input
    tokens = input.gsub!('(', '( ').gsub!(')', ' )').split
    (0...tokens.length).each do |indx|
        case tokens[indx]
            when '('
            tokens[indx] = {type: 'paren', value: '('}

            when ')'
            tokens[indx] = {type: 'paren', value: ')'}

            when /^([0-9])/
            tokens[indx] = {type: 'number', value: tokens[indx]}
    
            when /[a-z]/
            tokens[indx] = {type: 'name', value: tokens[indx]}
        end
    end
    return tokens
end

def make_tree
    token = @tokens[@current]
    if token[:type] == 'number'
        @current += 1
        return {type: 'NumberLiteral', value: token[:value]}
    end        
    if (token[:value] == '(')
        token = @tokens[@current += 1]
        node = {type: 'CallExpression', name: token[:value], params: []}
        token = @tokens[@current += 1]
        while token[:value] != ')'
            node[:params] << make_tree
            token = @tokens[@current]
        end
        @current += 1
        return node
    end
end

def parser    
    @current = 0
    ast = {type: 'Program', body: []}
    while (@current < @tokens.length)
        ast[:body] << make_tree
    end
    return ast
end

@tokens = tokenize '(add 2 (subtract 4 2))'
puts parser
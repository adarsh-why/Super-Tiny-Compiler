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

def abs_tree tokens, current
	token = tokens[current]

	if token[:type] == 'number'
		current += 1
		return {type: 'NumberLiteral', value: token[:value]}, current
	end

	if (token[:type] == 'paren' and token[:value] == '(')
		current += 1
		token = tokens[current]
		node = {type: 'CallExpression', name: token[:value], params: []}
		token = tokens[current]

		while ((token[:type] != 'paren') || (token[:type] == 'paren' && token[:value] != ')'))
			node[:params] << abs_tree(tokens, current)
			token = tokens[current += 1]
		end

		current += 1

		return node, current
	end
end

def parser tokens
	
	current = 0
	ast = {type: 'Program', body: []}

	while (current < tokens.length)
		node, current = abs_tree(tokens, current)
		ast[:body] << node
	end

	return ast
end

###### Test Case for Functions ######
tok = tokenize '(add 2 (subtract 4 2))'
p parser tok
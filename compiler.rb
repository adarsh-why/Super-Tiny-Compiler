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
            when /[a-z]/i
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
    if token[:value] == '('
        token = @tokens[@current += 1]
        node = {type: 'CallExpression', callee: {type: 'Identifier', name: token[:value]}, arguments: []}
        token = @tokens[@current += 1]
        while token[:value] != ')'
            node[:arguments] << make_tree
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

def code_generate node
    case node[:type]
    when 'Program'
        return node[:body].map{|node| code_generate node}.join("\n")
    when 'CallExpression'
        return (code_generate(node[:callee]) + '(' + 
            node[:arguments].map{|node| code_generate node}.join(', ') + ')')
    when 'Identifier'
        return node[:name]
    when 'NumberLiteral'
        return node[:value]
    end
end

input = '(add 3 (subtract 4 2))'
puts "\n\n#{input}\n\n"
@tokens = tokenize input
puts "#{@tokens}\n\n"
puts "#{parser}\n\n"
puts "#{code_generate parser}\n\n"

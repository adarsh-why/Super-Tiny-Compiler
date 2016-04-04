def tokenize input
    tokens = input.gsub!('(', '( ').gsub!(')', ' )').split
    (0...tokens.length).each do |indx|
        case tokens[indx]
            when '('
            tokens[indx] = {type: 'parens', value: '('}

            when ')'
            tokens[indx] = {type: 'parens', value: ')'}

            when /^([0-9])/
            tokens[indx] = {type: 'number', value: tokens[indx]}

            when /[a-z]/
            tokens[indx] = {type: 'name', value: tokens[indx]}
        end
    end
    puts tokens
end

###### Test Case for Functions ######
tokenize '(add 2 (subtract 4 2))'
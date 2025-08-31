Tree = Struct.new(:root, :left, :right)

def insert(tree, i)
    if i < tree.root
        if tree.left.nil?
            tree.left = Tree.new(i)
        else
            insert(tree.left, i)
        end
    else
        if tree.right.nil?
            tree.right = Tree.new(i)
        else
            insert(tree.right, i)
        end
    end        
end

def pre_order(tree)
    return [] if tree.nil?
    [tree.root, *pre_order(tree.left), *pre_order(tree.right)]
end

def in_order(tree)
    return [] if tree.nil?
    [*in_order(tree.left), tree.root, *in_order(tree.right)]
end

def post_order(tree)
    return [] if tree.nil?
    [*post_order(tree.left), *post_order(tree.right), tree.root]
end

def level_order(tree)
    todo = [tree]
    result = []
    while !todo.empty? do
        t = todo.shift
        result << t.root
        todo << t.left if !t.left.nil?
        todo << t.right if !t.right.nil?
    end
    return result
end


n = gets.to_i
root, *inputs = gets.split.map(&:to_i)

tree = Tree.new(root)

inputs.each do |i|
    insert(tree, i)
end

puts pre_order(tree) * " ",
     in_order(tree) * " ",
     post_order(tree) * " ",
     level_order(tree) * " "
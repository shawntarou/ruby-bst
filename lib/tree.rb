class Tree
  def initialize(array)
    @root = build_tree(array)
  end

  def insert(value)
    insert_recursion(@root, value)
  end
  
  def delete(value)
    delete_recursion(@root, value)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def find(value)
    find_recursion(@root, value)
  end

  def level_order 
    return @root if @root.nil?

    queue = Array.new
    queue.push(@root)
    values_array = Array.new

    until queue.empty?
      curr_node = queue.first

      if block_given? then yield(curr_node.data)
      else values_array << curr_node.data end

      if curr_node.left != nil then queue.push(curr_node.left) end
      if curr_node.right != nil then queue.push(curr_node.right) end
        
      queue.shift()
    end

    return values_array.empty? ? nil : values_array 
  end

  def inorder(root = @root, &block)
    return root if root.nil?

    if block_given?
      inorder(root.left, &block)
      yield(root.data)
      inorder(root.right, &block)
    else
      left_values = inorder(root.left) 
      root.data 
      right_values = inorder(root.right) 

      [left_values, root.data, right_values].compact.flatten
    end
  end

  def preorder(root = @root, &block)
    return root if root.nil?

    if block_given?
      yield(root.data)
      preorder(root.left, &block)
      preorder(root.right, &block)
    else
      root.data 
      left_values = preorder(root.left) 
      right_values = preorder(root.right) 

      [root.data, left_values, right_values].compact.flatten
    end
  end

  def postorder(root = @root, &block)
    return root if root.nil?

    if block_given?
      postorder(root.left, &block)
      postorder(root.right, &block)
      yield(root.data)
    else
      left_values = postorder(root.left) 
      right_values = postorder(root.right) 
      root.data 

      [left_values, right_values, root.data].compact.flatten
    end
  end

  def height(node = @root)
    return -1 if node.nil?
    
    [height(node.left), height(node.right)].max + 1
  end

  def depth(node = @root)
    if @root.nil? || node.nil? then return -1 end
    
    curr_node = @root
    depth = 0

    until curr_node.data == node.data
      if node.data < curr_node.data then curr_node = curr_node.left 
      else curr_node = curr_node.right end
      depth += 1
    end

   depth 
  end

  def balanced?
    balanced_recursion(@root) > 0
  end
  
  def rebalance
    new_tree_array = inorder
    @root = build_tree(new_tree_array)
  end

  private 

  def build_tree(array)
    sorted_array = array.sort.uniq
    sorted_array_to_bst(sorted_array)
  end

  def sorted_array_to_bst(array)
    sorted_array_to_bst_recursion(array, 0, array.length-1)
  end

  def sorted_array_to_bst_recursion(array, start, finish)
    return nil if start > finish

    mid = start + (finish - start) / 2
    root = Node.new(array[mid])

    root.left = sorted_array_to_bst_recursion(array, start, mid - 1)
    root.right = sorted_array_to_bst_recursion(array, mid + 1, finish)

    root
  end

  def insert_recursion(root, value)
    return Node.new(value) if root.nil?
    return root if root.data == value

    if root.data < value then root.right = insert_recursion(root.right, value) 
    else root.left = insert_recursion(root.left, value) end

    root
  end

  def delete_recursion(root, value)
    return root if root.nil?

    if root.data > value then root.left = delete_recursion(root.left, value) 
    elsif root.data < value then root.right = delete_recursion(root.right, value) 

    else
      return root.right if root.left.nil?
      return root.left if root.right.nil?

      succ = get_successsor(root)
      root.data = succ.data
      root.right = delete_recursion(root.right, succ.data)
    end

    root  
  end

  def get_successsor(curr)
    curr = curr.right
    while !curr.nil? && !curr.left.nil? 
      curr = curr.left
    end

    curr
  end

  def find_recursion(root, value)
    return root if root.nil?
    
    if value < root.data then return find_recursion(root.left, value) end
    if value > root.data then return find_recursion(root.right, value) end

    root
  end

  def balanced_recursion(root)
    return 0 if root.nil?
    
    left_height = balanced_recursion(root.left)
    right_height = balanced_recursion(root.right)
    
    if left_height == -1 || right_height == -1 || (left_height - right_height).abs > 1
      return -1
    end
    
    [left_height, right_height].max + 1
  end

  class Node
    include Comparable

    attr_accessor :data, :left, :right

    def <=>(other)
      return if other.nil?
      data <=> other.data
    end

    def initialize(data)
      @data = data    
      @left = nil
      @right = nil
    end
  end
end
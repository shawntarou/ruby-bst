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

  def find(value)

  end

  def level_order 

  end

  def inorder

  end

  def preorder

  end

  def postorder
    
  end

  def height(node)
    
  end

  def depth(node)

  end

  def balanced?

  end

  def rebalance

  end

  class Node
    include Comparable

    attr_accessor :data, :left, :right

    def <=>(other)
      data <=> other.data
    end

    def initialize(data)
      @data = data    
      @left = nil
      @right = nil
    end
  end
end
class Tree
  def initialize(array)
    @root = build_tree(array)
  end
  
  def build_tree(array)
    array.sort!
    sorted_array_to_bst(array)
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

  def insert(value)

  end

  def delete(value)
    
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

  def pretty_print(node = @root, prefix = '..', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
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
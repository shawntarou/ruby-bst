require_relative 'lib/tree.rb'

array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
BST = Tree.new(array)

BST.pretty_print
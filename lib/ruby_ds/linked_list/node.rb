class RubyDS::LinkedList::Node
  
  # A constructor to create the linked list node.
  #
  # @param key [Object] - the key representing the node.
  # @param value [Object] - the value of the node.
  def initialize(key, value)
    @key = key
    @value = value

    @next = nil
  end

  # Get the key of the node.
  #
  # @return [Object] - the key.
  def key
    @key
  end

  # Get the value of the node.
  #
  # @return [Object] - the value.
  def value
    @value
  end

  # Update this node with a new value.
  #
  # @param value [Object] - The new value given to the node.
  def value=(value)
    @value = value
  end

  # Get the node that goes after this node.
  #
  # @return [RubyDS::LinkedList::Node] - the node that goes after this one.
  def next
    @next
  end

  # Set the node that would go after this node.
  #
  # @param node [RubyDS::LinkedList::Node] - the node that we want to assign as
  # the node that will go after this one.
  def next=(node)
    @next = node
  end
end


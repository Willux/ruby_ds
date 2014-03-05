class RubyDS::LinkedList

  # Construct the new linked list.
  def initialize
    @head = nil
    @tail = nil

    @count = 0
  end

  # Use an array assignment style to add a key value pair. If a node with a given
  # key already exists, just update the value in that node.
  #
  # @param key [Object] - they key, by which the user can access the element.
  # @param value [Object] - the value.
  def []=(key, value)

    # If a node by a given key exists,
    # simply change the value in that node.
    if node = get_node_by_key(key)
      node.value = value

    # Create the first node if this linked list is empty.
    elsif @head.nil?
      @head = RubyDS::LinkedList::Node.new(key, value)
      @tail = @head
      @count += 1

    # In all other cases we can simply put it after the tail.
    else
      @tail.next = RubyDS::LinkedList::Node.new(key, value)
      @tail = @tail.next
      @count += 1
    end
  end

  # Retrieve the value based on a given key.
  #
  # @param key [Object] - the key, by which the value is being accessed.
  #
  # @return [Object, Nil] - the value, which was accessed by a given key. Nil if the
  # value associated with the given key doesn't exist.
  def [](key)
    node = get_node_by_key(key)

    # If the node exists, return the value. Otherwise, we can return nil.
    node ? node.value : nil
  end

  # Give a user the ability to easily iterate over the linked list.
  def each(&block)
    curr = @head
    until curr.nil? do
      yield(curr.key, curr.value)
      curr = curr.next
    end
  end

  # Check if the two linked lists are identical.
  #
  # @param other [RubyDS::LinkedList] - the linked list to which we are comparing this
  # linked list.
  #
  # @return [Boolean] - TRUE if both linked lists are identical. FALSE
  # otherwise.
  def ==(other)
    # If objects are of different type or the linked lists of different length,
    # they cannot be the same then.
    return false unless self.class == other.class && self.length == other.length

    # Otherwise, each key / value pair should match and should be in the right
    # order.
    curr = @head
    other.each do |key, value|
      return false unless curr.key == key && curr.value == value
      curr = curr.next
    end

    true
  end

  # Make a deep copy of this linked list.
  #
  # @return [RubyDS::LinkedList] - a deep copy of this linked list.
  def deep_copy
    new_list = RubyDS::LinkedList.new

    # Copy each key / value pair to the new list.
    each do |key, value|
      new_list[key] = value
    end

    # And just return it.
    new_list
  end

  # Get the number of elements in the linked list.
  #
  # @return [Fixnum] - the number of elements in this list.
  def length
    @count
  end

  # Find out whether the linked list is empty or not.
  #
  # @return [Boolean] - TRUE if there are no elements in this list. FALSE
  # otherwise.
  def empty?
    @count == 0
  end

  # Check if an element with a given key exists in the linked list.
  #
  # @param key [Object] - the key that we are looking for.
  #
  # @return [Boolean] - TRUE if the given key exists in the linked list. FALSE otherwise.
  def has_key?(key)
    search_by(:key, key)
  end

  # Check if an element with a given value exists in the linked list.
  #
  # @param value [Object] - the value that we are looking for.
  #
  # @return [Boolean] - TRUE if the given value exists in the linked list. FALSE otherwise.
  def has_value?(value)
    search_by(:value, value)
  end

  # Delete an element based on a given key. If a given element is not found,
  # return nil, unless a block with a default value is passed in, in which case
  # the default value is returned.
  #
  # @param key [Object] - the key of the element we are trying to remove.
  #
  # @param value [Object, Nil] - the value of the removed element. Nil if the
  # element was not found.
  def delete(key, &block)
    value_to_return = nil

    if @head.key == key
      value_to_return = @head.value
      next_node = @head.next
      @head.next = nil
      @head = next_node
    else
      curr = @head

      # Traverse until we get to the end
      # or hit the node with the given key.
      until curr.next.nil? || curr.next.key == key
        curr = curr.next
      end

      # If we found our key of interest,
      # we just need to remove it.
      if curr.next
        value_to_return = curr.next.value
        old_node = curr.next
        curr.next = old_node.next
        old_node.next = nil

        # Make sure to update the tail if the node
        # we are removing is the tail.
        @tail = curr if @tail == old_node
      end
    end

    # At the end of the day, if we have a value to return,
    # return it. Otherwise, it's either nil or the default value.
    if value_to_return.nil?
      if block_given?
        yield(key)
      else
        nil
      end
    else
      # Since we have some kind of value to return,
      # we know we removed an element.
      @count -= 1
      value_to_return
    end
  end

  # Delete the elements that satisfy a given condition shown in the block.
  #
  # @return [RubyDS::LinkedList, Enumerable] - the updated linked list after all
  # of the elements satisfying condition are removed. An enumerable if there is
  # no block given.
  def delete_if(&block)
    return to_enum(__method__) unless block_given?
    reject!(&block)
  end

  # @see 'delete_if'.
  #
  # The only difference is that this method doesn't update THIS linked list, but
  # rather returns a new one.
  def reject(&block)
    return to_enum(__method__) unless block_given?
    deep_copy.reject!(&block)
  end

  # @see 'delete_if'
  def reject!(&block)
    return to_enum(__method__) unless block_given?

    while @head && yield(@head.key, @head.value) do
      next_node = @head.next
      @head.next = nil
      @head = next_node
      @count -= 1
    end

    if @head.nil?
      @tail = nil
    else
      curr = @head
      until curr.next.nil?
        if yield(curr.next.key, curr.next.value)
          @count -= 1
          node_to_remove = curr.next
          curr.next = node_to_remove.next
          node_to_remove.next = nil

          @tail = curr if @tail == node_to_remove
        else
          curr = curr.next
        end
      end
    end

    self
  end

  # @see 'select!'
  #
  # The only exception is that this method doesn't update THIS linked list.
  def select(&block)
    return to_enum(__method__) unless block_given?
    deep_copy.select!(&block)
  end

  # Get all of the elements that satisfy a given condition in the block.
  #
  # @return [RubyDS::LinkedList, Enumerable] - The linked list with the elements
  # that satisfy a given conditions. An enumerable if a block was not given.
  def select!(&block)
    return to_enum(__method__) unless block_given?

    # Keep removing the first elements until we hit
    # the element that passes a given condition or hit a dead end..
    until @head.nil? || yield(@head.key, @head.value) do
      next_node = @head.next
      @head.next = nil
      @head = next_node
      @count -= 1
    end

    if @head.nil?
      @tail = nil
    else

      # We can then remove all of the unnecessary elements
      # in the middle of the list.
      curr = @head
      until curr.next.nil?
        if yield(curr.next.key, curr.next.value)
          curr = curr.next
        else
          @count -= 1
          node_to_remove = curr.next
          curr.next = node_to_remove.next
          node_to_remove.next = nil

          @tail = curr if @tail == node_to_remove
        end
      end
    end

    self
  end

  # Clear up everything in this linked list.
  def clear
    @count = 0
    @head = nil
    @tail = nil
  end

  # Convert this linked list to a hash.
  #
  # @return [Hash] - the hash that is converted from this linked list.
  def to_hash
    hsh = {}

    self.each do |key, value|
      hsh[key] = value
    end

    hsh
  end

  protected

  # Look for a search value in either the key or value of all the elements.
  #
  # @param type [Symbol] - The part of the element that we are looking at. The
  # values are either :key or :value.
  # @param search_value [Object] - the value that we are looking for.
  #
  # @return [Boolean] - TRUE if the search value in a certain part of the
  # element exists. FALSE otherwise.
  def search_by(type, search_value)
    each do |key, value|
      if (type == :key && key == search_value) || (type == :value && value == search_value)
        return true
      end
    end

    false
  end

  # Given the key, find the full linked list node.
  #
  # @param key [Object] - The key by which the node is being looked up.
  #
  # @return [RubyDS::LinkedList::Node, Nil] - The node searched by the given key.
  # Nil if no node was found.
  def get_node_by_key(key)
    curr = @head
    until curr.nil? do
      return curr if curr.key == key
      curr = curr.next
    end
    
    # We can't find the node of interest. Return nil.
    nil
  end
end


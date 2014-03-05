class RubyDS::Queue

  # Construct this queue.
  def initialize
    @head = nil
    @tail = nil

    @count = 0
  end

  # Add an element to the back of the queue.
  #
  # @param value [Object] - the value that is to be put at the end of the queue.
  def enqueue(value)
    @count += 1
    new_element = RubyDS::StackQueue::Element.new(value)

    # If this is the first element, just assign the head and tail.
    if @head.nil?
      @head = new_element
      @tail = @head

    # Add the element as a new tail.
    else
      @tail.next = new_element
      @tail = @tail.next 
    end
  end

  # @see 'enqueue'
  def <<(value)
    enqueue(value)
  end

  # Remove the element from the head of the queue and return its value.
  #
  # @return [Object, Nil] - The value of the element returned. Nil if the queue
  # was empty to begin with.
  def dequeue
    return nil if @head.nil?

    # Remove the head element and return the value.
    @count -= 1
    old_node = @head
    @head = @head.next
    old_node.next = nil

    # We can also nullify the tail if the head is nil now.
    @tail = nil if @head.nil?

    old_node.value
  end

  # Clear out the entire queue.
  def clear
    @count = 0
    @head = nil
    @tail = nil
  end

  # Get the number of elements that is in the queue.
  #
  # @return [Fixnum] - the number of elements in the queue.
  def count
    @count
  end

  # Check whether this queue has any elements or not.
  #
  # @param [Boolean] - TRUE if the queue doesn't contain any elements. FALSE
  # otherwise.
  def empty?
    @count == 0
  end

  # Get the value from the front of the queue.
  #
  # @param [Object, Nil] - The value that is in the front element. Nil if the
  # queue is empty.
  def peek
    @head ? @head.value : nil
  end
end


class RubyDS::Stack

  # Initialize a stack.
  def initialize
    @head = nil
    @count = 0
  end

  # Push the given value onto the stack.
  #
  # @param value [Object] - the value that is to be pushed to the stack.
  def push(value)
    @count += 1
    new_element = RubyDS::StackQueue::Element.new(value)
    if @head.nil?
      @head = new_element
    else
      new_element.next = @head
      @head = new_element
    end
  end

  # Push the given value onto the stack. This is the same as 'push'
  #
  # @param value [Object] - the value that is to be pushed to the stack.
  def <<(value)
    push(value)
  end

  # Remove the element from the top of the stack (the last one added)
  # and return the value back to the user.
  #
  # @return [Object] - the value of the element that was popped.
  def pop
    return nil if @head.nil?

    to_remove = @head
    @head = @head.next
    to_remove.next = nil
    @count -= 1

    to_remove.value
  end

  # Clears up the entire stack.
  def clear
    @count = 0
    @head = nil
  end

  # Get the value from the top of the stack.
  #
  # @return [Object, Nil] - the value at the top of the stack. Nil if the stack
  # is empty.
  def peek
    empty? ? nil : @head.value
  end

  # Check if the stack contains any elements.
  #
  # @return [Boolean] - TRUE if the stack is empty. FALSE otherwise.
  def empty?
    @count == 0
  end

  # Get the number of elements contained in the stack.
  #
  # @return [Fixnum] - the number of elements in the stack.
  def length
    @count
  end
end


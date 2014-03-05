class RubyDS::StackQueue::Element

  # Initialize the element that would be in the stack or queue.
  #
  # @param value [Object] - the value that will be contained in this element.
  def initialize(value)
    @value = value

    @next = nil
  end

  # A getter for the value in this element.
  #
  # @return [Object] - the value of this element.
  def value
    @value
  end

  # A reference to the next element going after this one.
  #
  # @return [RubyDS::StackQueue::Element] - the element going after this one.
  def next
    @next
  end

  # Create a reference to the element going after this one.
  #
  # @param element [RubyDS::StackQueue::Element] - the element to which the
  # reference is being created.
  def next=(element)
    @next = element
  end
end


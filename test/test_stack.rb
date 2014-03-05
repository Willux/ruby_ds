require_relative "../lib/ruby_ds"
require "test/unit"

class TestStack < Test::Unit::TestCase
  def test_constructor
    stack = RubyDS::Stack.new
    assert_equal(stack.class, RubyDS::Stack)
  end

  def test_push_pop_length_peek
    stack = RubyDS::Stack.new
    assert_equal(stack.peek, nil)
    assert_equal(stack.length, 0)

    stack << 42
    assert_equal(stack.peek, 42)
    assert_equal(stack.length, 1)

    stack.push("boom")
    assert_equal(stack.peek, "boom")
    assert_equal(stack.length, 2)

    removed = stack.pop
    assert_equal(removed, "boom")
    assert_equal(stack.length, 1)
    assert_equal(stack.peek, 42)

    removed = stack.pop
    assert_equal(removed, 42)
    assert_equal(stack.length, 0)
    assert_equal(stack.peek, nil)
  end

  def test_empty_and_clear
    stack = RubyDS::Stack.new

    assert_equal(stack.empty?, true)

    stack.push("test")
    assert_equal(stack.empty?, false)

    stack.push("test2")
    assert_equal(stack.empty?, false)

    stack.clear
    assert_equal(stack.empty?, true)
    assert_equal(stack.peek, nil)
  end
end


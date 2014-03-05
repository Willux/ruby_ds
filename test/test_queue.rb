require_relative "../lib/ruby_ds"
require "test/unit"

class TestQueue < Test::Unit::TestCase
  def test_constructor
    queue = RubyDS::Queue.new
    assert_equal(queue.class, RubyDS::Queue)
  end

  def test_enqueue_dequeue_count_empty_peek
    queue = RubyDS::Queue.new
    assert_equal(queue.count, 0)
    assert_equal(queue.peek, nil)
    assert_equal(queue.empty?, true)
    assert_equal(queue.dequeue, nil)

    queue << 52
    assert_equal(queue.count, 1)
    assert_equal(queue.peek, 52)
    assert_equal(queue.empty?, false)

    queue.enqueue("value")
    assert_equal(queue.count, 2)
    assert_equal(queue.peek, 52)
    assert_equal(queue.empty?, false)

    removed = queue.dequeue
    assert_equal(removed, 52)
    assert_equal(queue.count, 1)
    assert_equal(queue.peek, "value")
    assert_equal(queue.empty?, false)

    removed = queue.dequeue
    assert_equal(removed, "value")
    assert_equal(queue.count, 0)
    assert_equal(queue.peek, nil)
    assert_equal(queue.empty?, true)
  end

  def test_clear
    queue = RubyDS::Queue.new

    queue.enqueue("test1")
    queue.enqueue("test2")
    assert_equal(queue.empty?, false)
    assert_equal(queue.count, 2)

    queue.clear
    assert_equal(queue.peek, nil)
    assert_equal(queue.empty?, true)
    assert_equal(queue.count, 0)

  end
end


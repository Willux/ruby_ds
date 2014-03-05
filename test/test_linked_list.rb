require_relative "../lib/ruby_ds"
require "test/unit"

class TestLinkedList < Test::Unit::TestCase

  def test_constructor
    linked_list = RubyDS::LinkedList.new
    assert_equal(linked_list.class, RubyDS::LinkedList)
  end

  def test_assignment_and_access1
    linked_list = RubyDS::LinkedList.new
    linked_list['test_index'] = 42
    linked_list[432] = nil

    assert_equal(linked_list['test_index'], 42)
    assert_equal(linked_list[432], nil)
    assert_equal(linked_list["non_existant"], nil)
  end

  def test_assignment_and_access2
    linked_list = RubyDS::LinkedList.new

    linked_list["test_index"] = "val1"
    assert_equal(linked_list["test_index"], "val1")

    linked_list["test_index"] = "new_value"
    assert_equal(linked_list["test_index"], "new_value")
  end

  def test_comparison1
    linked_list1 = RubyDS::LinkedList.new
    linked_list2 = RubyDS::LinkedList.new

    assert_equal(linked_list1 == linked_list2, true)
  end

  def test_comparison2
    linked_list1 = RubyDS::LinkedList.new
    linked_list2 = RubyDS::LinkedList.new

    linked_list1["index1"] = "boom"
    linked_list1["index2"] = "yay"

    linked_list2["index1"] = "good"
    linked_list2["don't care index"] = "yay"

    assert_equal(linked_list1 == linked_list2, false)
  end

  def test_comparison3
    linked_list1 = RubyDS::LinkedList.new
    linked_list2 = RubyDS::LinkedList.new

    linked_list1["index1"] = "boom"
    linked_list1["index2"] = "yay"

    linked_list2["index1"] = "good"

    assert_equal(linked_list1 == linked_list2, false)
  end

  def test_comparison4
    linked_list1 = RubyDS::LinkedList.new
    linked_list2 = RubyDS::LinkedList.new

    linked_list1["index1"] = "boom"
    linked_list1["index2"] = "yay"

    linked_list2["index1"] = "boom"
    linked_list2["index2"] = "yay"

    assert_equal(linked_list1 == linked_list2, true)
  end

  def test_deep_copy
    linked_list = RubyDS::LinkedList.new

    linked_list["t"] = 23
    linked_list[43] = 4435

    new_list = linked_list.deep_copy

    assert_not_equal(new_list.object_id, linked_list.object_id)
    assert_equal(new_list == linked_list, true)
  end

  def test_length
    linked_list = RubyDS::LinkedList.new
    assert_equal(linked_list.length, 0)

    linked_list[4] = "val1"
    linked_list[52] = "val2"
    assert_equal(linked_list.length, 2)

    linked_list.clear
    assert_equal(linked_list.length, 0)
  end

  def test_empty
    linked_list = RubyDS::LinkedList.new
    assert_equal(linked_list.empty?, true)

    linked_list[32] = "val1"
    assert_equal(linked_list.empty?, false)

    linked_list[44] = 324
    assert_equal(linked_list.empty?, false)

    linked_list.clear
    assert_equal(linked_list.empty?, true)

    linked_list[42] = 423
    assert_equal(linked_list.empty?, false)

    linked_list.delete(42)
    assert_equal(linked_list.empty?, true)
  end

  def test_has_key
    linked_list = RubyDS::LinkedList.new
    
    assert_equal(linked_list.has_key?("index"), false)
    assert_equal(linked_list.has_key?(nil), false)

    linked_list["index"] = "boom"
    linked_list[nil] = "yay"
    assert_equal(linked_list.has_key?("index"), true)
    assert_equal(linked_list.has_key?(nil), true)
  end

  def test_has_value
    linked_list = RubyDS::LinkedList.new

    assert_equal(linked_list.has_value?("boom"), false)
    assert_equal(linked_list.has_value?(nil), false)

    linked_list["who cares"] = "boom"
    linked_list["who cares again"] = nil
    assert_equal(linked_list.has_value?("boom"), true)
    assert_equal(linked_list.has_value?(nil), true)
  end

  def test_select
    linked_list = RubyDS::LinkedList.new
    
    linked_list[43] = "boom"
    linked_list["test"] = "YAY!"
    linked_list["haha"] = "again"

    linked_list_copy = linked_list.clone

    new_list = linked_list.select { |key, val| key.class == Fixnum }
    assert_equal(linked_list == linked_list_copy, true)
    assert_equal(new_list.length, 1)
    assert_equal(new_list[43], "boom")

    linked_list.select! { |key, val| key == "test" }
    assert_equal(linked_list.length, 1)
    assert_equal(linked_list["test"], "YAY!")
  end

  def test_delete
    linked_list = RubyDS::LinkedList.new

    linked_list[42] = 54
    linked_list["another index"] = "another value"

    assert_equal(linked_list[42], 54)
    removed = linked_list.delete(42)
    assert_equal(removed, 54)
    assert_equal(linked_list.length, 1)
    assert_equal(linked_list[42], nil)
    assert_equal(linked_list["another index"], "another value")
  end

  def test_clear
    linked_list = RubyDS::LinkedList.new

    linked_list[42] = 54
    linked_list["another index"] = "another value"
    linked_list["and another one gone"] = "and another one bites the dust"

    assert_equal(linked_list.length, 3)
    assert_equal(linked_list[42], 54)
    assert_equal(linked_list["another index"], "another value")
    assert_equal(linked_list["and another one gone"], "and another one bites the dust")

    linked_list.clear

    assert_equal(linked_list.length, 0)
    assert_equal(linked_list[42], nil)
    assert_equal(linked_list["another index"], nil)
    assert_equal(linked_list["and another one gone"], nil)
  end

  def test_reject
    linked_list = RubyDS::LinkedList.new

    linked_list[43] = "boom"
    linked_list["test"] = "YAY!"
    linked_list["haha"] = "again"

    linked_list_copy = linked_list.clone

    new_list = linked_list.reject { |key, val| key.class == Fixnum }
    assert_equal(linked_list == linked_list_copy, true)
    assert_equal(new_list.length, 2)
    assert_equal(new_list["test"], "YAY!")
    assert_equal(new_list["haha"], "again")

    linked_list.reject! { |key, val| key == "test" }
    assert_equal(linked_list.length, 2)
    assert_equal(linked_list[43], "boom")
    assert_equal(linked_list["haha"], "again")

    linked_list.delete_if { |key, val| key == 43 }
    assert_equal(linked_list.length, 1)
    assert_equal(linked_list["haha"], "again")
    assert_equal(linked_list[43], nil)
  end

  def test_to_hash
    linked_list = RubyDS::LinkedList.new

    linked_list[42] = 54
    linked_list["another index"] = "another value"
    linked_list["and another one gone"] = "and another one bites the dust"

    assert_equal(linked_list.length, 3)
    assert_equal(linked_list[42], 54)
    assert_equal(linked_list["another index"], "another value")
    assert_equal(linked_list["and another one gone"], "and another one bites the dust")

    new_hsh = linked_list.to_hash

    assert_equal(new_hsh.class, Hash)
    assert_equal(new_hsh.length, 3)
    assert_equal(new_hsh[42], 54)
    assert_equal(new_hsh["another index"], "another value")
    assert_equal(new_hsh["and another one gone"], "and another one bites the dust")
  end
end


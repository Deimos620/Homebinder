require 'test_helper'

class BinderTest < ActiveSupport::TestCase
  
  test "name is required" do
    data = Hash.new
    data["name"] = nil
    @binder = Binder.new(data)
    assert !@binder.save, "Saved binder with nil name"
    
    data["name"] = "binder"
    @binder = Binder.new(data)
    assert @binder.save, "Failed to save binder with valid name"
  end
  
  test "name = 50 characters" do
    data = Hash.new
    data["name"] = "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwx"
    @binder = Binder.new(data)
    assert @binder.save, "Failed to save binder with name = 50 characters"
  end
  
  test "name = 51 characters" do
    data = Hash.new
    data["name"] = "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxy"
    @binder = Binder.new(data)
    assert !@binder.save, "Save binder with name = 51 characters"
  end
  
  test "name = 1 character" do
    data = Hash.new
    data["name"] = "x"
    @binder = Binder.new(data)
    assert @binder.save, "Failed to save binder with name = 1 character"
  end
  
  test "notes not required" do
    data = Hash.new
    data["name"] = "binder"
    @binder = Binder.new(data)
    assert @binder.save, "Failed to save binder with no notes"
  end
  
  test "save with notes" do
    data = Hash.new
    data["name"] = "binder"
    data["notes"] = "some notes"
    @binder = Binder.new(data)
    assert @binder.save, "Failed to save binder with notes"
  end
  
  test "notes = 250 characters" do
    data = Hash.new
    data["name"] = "binder"
    data["notes"] = "abcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghij"
    @binder = Binder.new(data)
    assert @binder.save, "Failed to save binder with notes = 250 characters"
  end
  
  test "notes > 250 characters" do
    data = Hash.new
    data["name"] = "binder"
    data["notes"] = "abcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghija"
    @binder = Binder.new(data)
    assert !@binder.save, "Saved binder with notes > 250 characters"
  end
    
end

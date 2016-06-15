require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  def setup
    @category = Category.new(name: "sports")
  end

  test 'category should be valid' do
    assert @category.valid?
  end

  #if this is true, test fails, we are expectimg a false return
   test 'name should be present' do
    @category.name = ' '
    assert_not @category.valid?
  end

  # category2 should not be vaild, nam exists
  test 'name should be unique' do
    @category.save
    category2 = Category.new(name: "sports")
    assert_not category2.valid?
  end

  #max a name can be is 25 char
  test 'name should not be too long' do
    @category.name = 'a' * 26
    assert_not @category.valid?
  end

  test 'name should not be too short' do
    @category.name = 'aa'
    assert_not @category.valid?
  end


end
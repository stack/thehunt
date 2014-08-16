require 'test_helper'

class PersonTest < ActiveSupport::TestCase

  def setup
    @params = { name: 'Stephen', number: '+15551112222' }
  end

  test "should not save without a number" do
    person = Person.new @params
    person.number = nil

    assert_not person.save
  end

  test "should not save without a unique number" do
    person1 = people(:joe)

    person2 = Person.new @params
    person2.number = person1.number

    assert_not person2.save
  end

  test "should not save with an invalid number" do
    person = Person.new @params

    person.number = '15551112222'
    assert_not person.save

    person.number = 'something'
    assert_not person.save
  end

  test "should save with valid params" do
    person = Person.new @params
    assert person.save
  end

  test "should give the number for a description without a name" do
    person = Person.new @params
    person.name = nil

    assert_equal '+15551112222', person.description
  end

  test "should give the name for a description when present" do
    person = Person.new @params

    assert_equal 'Stephen', person.description
  end

end

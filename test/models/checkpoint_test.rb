require 'test_helper'

class CheckpointTest < ActiveSupport::TestCase

  def setup
    @params = { message: 'message', success: 'Success!', response: 'Response.', points: 0 }
  end

  test 'should not save without a message' do
    checkpoint = Checkpoint.new @params
    checkpoint.message = nil

    assert_not checkpoint.save
  end

  test 'should not save without a unique message' do
    checkpoint1 = checkpoints(:one)

    checkpoint2 = Checkpoint.new @params
    checkpoint2.message = checkpoint1.message

    assert_not checkpoint2.save
  end

  test 'should not save without a response' do
    checkpoint = Checkpoint.new @params
    checkpoint.response = nil

    assert_not checkpoint.save
  end

  test 'should not save without a valid points value' do
    checkpoint = Checkpoint.new @params

    checkpoint.points = -1
    assert_not checkpoint.save

    checkpoint.points = 3.14
    assert_not checkpoint.save
  end

  test 'should save with valid params' do
    checkpoint = Checkpoint.new @params

    assert checkpoint.save
  end

  test 'should set an initial order number' do
    count = Checkpoint.count

    checkpoint = Checkpoint.new @params
    checkpoint.save

    assert_equal count + 1, checkpoint.order
  end

  test 'should send just the message when there is no success' do
    checkpoint = Checkpoint.new @params
    checkpoint.success = nil

    assert_equal 'Response.', checkpoint.success_message
  end

  test 'should send both success and message where there is a success' do
    checkpoint = Checkpoint.new @params

    assert_equal 'Success! Response.', checkpoint.success_message
  end

end

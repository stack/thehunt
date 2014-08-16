require 'test_helper'

class MessagesControllerTest < ActionController::TestCase

  test "should ignore any unhandled message bodies" do
    post :create, { Body: 'blap', From: '+15551112222' }

    assert_response :success
    assert_match /You must be registered/, @response.body
  end

  test "should fail registering a user if it already exists" do
    person = people(:joe)
    post :create, { Body: 'team xx', From: person.number }

    assert_response :success
    assert_match /already associated/, @response.body
  end

  test "should fail registering a user if the team doesn't exist" do
    post :create, { Body: 'team xx', From: '+15551112222' }

    assert_response :success
    assert_match /Could not find the team/, @response.body
  end

  test "should register a user if everyting is correct" do
    team = teams(:ramrod)
    post :create, { Body: "team #{team.code}", From: '+15551112222' }

    assert_response :success
    assert_match /You have been registered on Team Ram Rod/, @response.body

    team.reload
    assert_equal 1, team.people.count

    person = team.people.first
    assert_equal '+15551112222', person.number
  end

  test "should fail response when the team hasn't started" do
    team = teams(:ramrod)

    person = people(:joe)
    person.team = team
    person.save

    post :create, { Body: "help", From: person.number }

    assert_response :success
    assert_match /Your team has not been started/, @response.body
  end

  test "should send the current response when asking for help" do
    team = teams(:ramrod)

    person = people(:joe)
    person.team = team
    person.save

    team.start!

    checkpoint = checkpoints(:one)

    post :create, { Body: "help", From: person.number }

    assert_response :success
    assert_match /Go to the place/, @response.body
  end


end

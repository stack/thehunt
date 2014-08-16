require 'test_helper'

class MessagesControllerTest < ActionController::TestCase

  test "should ignore any unhandled message bodies" do
    post :create, { Body: 'blap', From: '+15551112222' }

    assert_response :success
    assert_match /\<Response\/\>/, @response.body
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

end

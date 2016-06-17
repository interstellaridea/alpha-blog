require 'test_helper'

class SignupUserTest < ActionDispatch::IntegrationTest


  test "get new user form, signup, redirect to user page if successful" do 
    get signup_path
    # Look for the signup page
    assert_template 'users/new'
    # watch test DB and see if User.create was successful
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { username: "Jon", email: "jon@example.com", password: "password"}
    end
    # check if redirected to user's page
    assert_template 'users/show'
  end



end
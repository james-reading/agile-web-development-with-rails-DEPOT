require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should prompt for login" do
    get login_url
    assert_response :success
  end

  test "should login" do
    james = users(:one)
    post login_url, params: { name: james.name, password: 'secret' }
    assert_redirected_to admin_url
    assert_equal james.id, session[:user_id]
  end

  test "should fail login" do
    james = users(:one)
    post login_url, params: { name: james.name, password: 'wrong' }
    assert_redirected_to login_url
  end

  test "should logout" do
    delete logout_url
    assert_redirected_to store_index_url
  end

  test "access to sensitive data requires login" do
    delete logout_url
    assert_redirected_to store_index_url

    get products_url
    assert_redirected_to login_url
  end
end

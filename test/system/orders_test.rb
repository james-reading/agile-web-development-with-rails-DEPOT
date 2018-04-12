require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  test "check routing number" do
    visit store_index_url

    first('.catalog li').click_on 'Add to Cart'

    click_on 'Checkout'

    fill_in 'order_name', with: 'James Reading'
    fill_in 'order_address', with: '30A Sussex Place'
    fill_in 'order_email', with: 'james@example.com'

    assert_no_selector '#order_routing_number'

    select 'Check', from: 'pay_type'

    assert_selector "#order_routing_number"
  end
end

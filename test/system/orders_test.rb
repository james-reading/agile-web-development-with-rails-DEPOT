require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  include ActiveJob::TestHelper

  test "check routing number" do
    LineItem.delete_all
    Order.delete_all

    visit store_index_url

    first('.catalog li').click_on 'Add to Cart'

    click_on 'Checkout'

    fill_in 'order_name', with: 'James Reading'
    fill_in 'order_address', with: '30A Sussex Place'
    fill_in 'order_email', with: 'james@example.com'

    assert_no_selector '#order_routing_number'

    select 'Check', from: 'pay_type'

    assert_selector "#order_routing_number"

    fill_in 'Routing #', with: '123'
    fill_in 'Account #', with: '456'

    perform_enqueued_jobs do
      click_button "Place Order"
    end

    orders = Order.all
    assert_equal 1, orders.size

    order = orders.first

    assert_equal 'James Reading',      order.name
    assert_equal '30A Sussex Place',   order.address
    assert_equal 'james@example.com',  order.email
    assert_equal 'Check',              order.pay_type

    mail = ActionMailer::Base.deliveries.last
    assert_equal ["james@example.com"],                 mail.to
    assert_equal 'James Reading <depot@example.com>',       mail[:from].value
    assert_equal "Pragmatic Store Order Confirmation", mail.subject

  end
end

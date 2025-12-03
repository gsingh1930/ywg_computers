require 'test_helper'

class CheckoutControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get checkout_index_url
    assert_response :success
  end

  test 'should get process_order' do
    get checkout_process_order_url
    assert_response :success
  end
end

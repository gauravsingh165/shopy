require "test_helper"

class CompletionControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get completion_index_url
    assert_response :success
  end
end

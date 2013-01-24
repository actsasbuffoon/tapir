require 'test_helper'

class OwnersControllerTest < ActionController::TestCase
  setup do
    @owner = owners(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:owners)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create owner" do
    assert_difference('Owner.count') do
      post :create, owner: { first_name: @owner.first_name, gender: @owner.gender, last_name: @owner.last_name }
    end

    assert_response 201
  end

  test "should show owner" do
    get :show, id: @owner
    assert_response :success
  end

  test "should update owner" do
    put :update, id: @owner, owner: { first_name: @owner.first_name, gender: @owner.gender, last_name: @owner.last_name }
    assert_response 204
  end

  test "should destroy owner" do
    assert_difference('Owner.count', -1) do
      delete :destroy, id: @owner
    end

    assert_response 204
  end
end

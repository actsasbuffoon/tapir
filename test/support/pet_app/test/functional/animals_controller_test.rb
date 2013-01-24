require 'test_helper'

class AnimalsControllerTest < ActionController::TestCase
  setup do
    @animal = animals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:animals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create animal" do
    assert_difference('Animal.count') do
      post :create, animal: { gender: @animal.gender, name: @animal.name }
    end

    assert_response 201
  end

  test "should show animal" do
    get :show, id: @animal
    assert_response :success
  end

  test "should update animal" do
    put :update, id: @animal, animal: { gender: @animal.gender, name: @animal.name }
    assert_response 204
  end

  test "should destroy animal" do
    assert_difference('Animal.count', -1) do
      delete :destroy, id: @animal
    end

    assert_response 204
  end
end

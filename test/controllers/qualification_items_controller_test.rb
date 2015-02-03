require 'test_helper'

class QualificationItemsControllerTest < ActionController::TestCase
  setup do
    @qualification_item = qualification_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:qualification_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create qualification_item" do
    assert_difference('QualificationItem.count') do
      post :create, qualification_item: { current: @qualification_item.current, end_date: @qualification_item.end_date, location: @qualification_item.location, qualification_title: @qualification_item.qualification_title, start_date: @qualification_item.start_date }
    end

    assert_redirected_to qualification_item_path(assigns(:qualification_item))
  end

  test "should show qualification_item" do
    get :show, id: @qualification_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @qualification_item
    assert_response :success
  end

  test "should update qualification_item" do
    patch :update, id: @qualification_item, qualification_item: { current: @qualification_item.current, end_date: @qualification_item.end_date, location: @qualification_item.location, qualification_title: @qualification_item.qualification_title, start_date: @qualification_item.start_date }
    assert_redirected_to qualification_item_path(assigns(:qualification_item))
  end

  test "should destroy qualification_item" do
    assert_difference('QualificationItem.count', -1) do
      delete :destroy, id: @qualification_item
    end

    assert_redirected_to qualification_items_path
  end
end

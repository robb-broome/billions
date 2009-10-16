require 'test_helper'

class PlaylistItemsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:playlist_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create playlist_item" do
    assert_difference('PlaylistItem.count') do
      post :create, :playlist_item => { }
    end

    assert_redirected_to playlist_item_path(assigns(:playlist_item))
  end

  test "should show playlist_item" do
    get :show, :id => playlist_items(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => playlist_items(:one).to_param
    assert_response :success
  end

  test "should update playlist_item" do
    put :update, :id => playlist_items(:one).to_param, :playlist_item => { }
    assert_redirected_to playlist_item_path(assigns(:playlist_item))
  end

  test "should destroy playlist_item" do
    assert_difference('PlaylistItem.count', -1) do
      delete :destroy, :id => playlist_items(:one).to_param
    end

    assert_redirected_to playlist_items_path
  end
end

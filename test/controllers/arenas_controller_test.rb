require 'test_helper'

class ArenasControllerTest < ActionController::TestCase
   include Devise::Test::ControllerHelpers
    setup do
      @arena = arenas(:one)
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      user = users(:one)
      sign_in user
      user.account = accounts(:one)
  end

  test "should get index" do
    get :index
  
    assert_response :success
  end

  test "should get new" do
    get :new
  
    assert_response :success
  end

  test "should create arena" do

    assert_difference('Arena.count') do
      post :create, params: { arena: { description: @arena.description, id: @arena.id, name: @arena.name, rated: @arena.rated, url: @arena.url, port: 3001 } }
    end

    assert_redirected_to arena_url(Arena.last)
  end

  test "should show arena" do
    get :show, :id => 1
  
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => 1
  
   assert_response :success
  end

  test "should update arena" do
    patch :update, params: { id: 1,  arena: { created_at: @arena.created_at, created_by: @arena.created_by, description: @arena.description, id: @arena.id, name: @arena.name, rated: @arena.rated, updated_at: @arena.updated_at, updated_by: @arena.updated_by, url: @arena.url, port: @arena.port } }
  
    assert_redirected_to arena_url
  end
end

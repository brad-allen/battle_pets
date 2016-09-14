require 'test_helper'

class ArenasControllerAuthTest < ActionController::TestCase
   include Devise::Test::ControllerHelpers
    setup do
      @redirect_url = 'http://test.host/users/sign_in'
      @arena = arenas(:one)
      @controller = ArenasController.new
  end

   test "index should get redirected" do
    get :index

    assert_redirected_to @redirect_url
  end

  test "new should get redirected" do
    get :new

    assert_redirected_to @redirect_url
  end

  test "create should get redirected" do

    post :create, params: { arena: { description: @arena.description, id: @arena.id, name: @arena.name, rated: @arena.rated, url: @arena.url, port: 3001 } }
    
    assert_redirected_to @redirect_url
  end

  test "show should get redirected" do
    get :show, :id => 1
    
    assert_redirected_to @redirect_url
  end

  test "edit should get redirected" do
    get :edit, :id => 1
    
     assert_redirected_to @redirect_url
  end

  test "update should get redirected" do
    patch :update, params: { id: 1,  arena: { created_at: @arena.created_at, created_by: @arena.created_by, description: @arena.description, id: @arena.id, name: @arena.name, rated: @arena.rated, updated_at: @arena.updated_at, updated_by: @arena.updated_by, url: @arena.url, port: @arena.port } }
  
    assert_redirected_to @redirect_url
  end
end

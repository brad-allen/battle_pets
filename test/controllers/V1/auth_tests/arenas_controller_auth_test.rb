require 'test_helper'

class V1::ArenasControllerAuthTest < ActionController::TestCase
 include Devise::Test::ControllerHelpers
    setup do
      @arena = arenas(:one)
    @controller = V1::ArenasController.new
  end

  test "unauthorized index should not have access" do
    get :index, format: :json

    assert_response :unauthorized
  end

  test "unauthorized create should not have access" do

    post :create, params: { description: @arena.description, id: @arena.id, name: @arena.name, rated: @arena.rated, url: @arena.url, port: 3001 } , format: :json
    
    assert_response :unauthorized
  end

  test "unauthorized show should not have access" do
    get :show, :id => 1, format: :json

    assert_response :unauthorized
  end

  test "unauthorized update should not have access" do
    patch :update, params: { description: @arena.description, id: @arena.id, name: @arena.name, rated: @arena.rated, url: @arena.url, port: 3001 } , format: :json
    
    assert_response :unauthorized
  end

end
